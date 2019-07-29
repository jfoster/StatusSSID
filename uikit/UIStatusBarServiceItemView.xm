#import <SSShared.h>

#import <Foundation/NSDistributedNotificationCenter.h>
#import <UIKit/UIApplication.h>
#import <SpringBoard/SBWiFiManager.h>

#import "UIStatusBarServiceItemView.h"

@interface UIStatusBarServiceItemView ()

@property (nonatomic, retain) NSString *wifiName;
@property (assign, getter=isWiFiEnabled) BOOL wifiEnabled;

-(void)notificationReceived:(NSNotification *)notification;
-(void)updateServiceString:(NSString*)string;

@end

@interface UIStatusBar ()

-(void)setShowsOnlyCenterItems:(BOOL)arg1;

@end

@interface UIApplication ()

-(UIStatusBar*)statusBar;

@end

%group Main

%hook UIStatusBarServiceItemView

%property (nonatomic, retain) NSString *wifiName;

-(id)initWithItem:(id)arg1 data:(id)arg2 actions:(int)arg3 style:(id)arg4 {
	HBLogInfo(@"[StatusSSID] init");

	self.wifiName = [(SBWiFiManager*)[NSClassFromString(@"SBWiFiManager") sharedInstance] currentNetworkName];
	if (self.wifiName > 0) {
		[self updateServiceString:self.wifiName];
	} else {
		[self updateServiceString:@"oi mate"];
	}

	id orig = %orig;
	[[NSDistributedNotificationCenter defaultCenter] addObserver:orig selector:@selector(notificationReceived:) name:SSID_NOTIFICATION_KEY object:nil];
	return orig;
}

// -(BOOL)updateForContentType:(int)arg1 serviceString:(id)arg2 serviceCrossfadeString:(id)arg3 maxWidth:(double)arg4 actions:(int)arg5 {
// 	return %orig(arg1, self.wifiName, arg3, arg4, arg5);
// }

%new
-(void)notificationReceived:(NSNotification*)notification {
	HBLogInfo(@"[StatusSSID] notificationReceived");

	self.wifiName = [notification.userInfo[@"currentNetworkName"] stringValue];

	HBLogInfo(@"[StatusSSID] wifiName: %@", self.wifiName);

	[self updateServiceString:self.wifiName];
}

%new
-(void)updateServiceString:(NSString*)string {
	if (string.length > 0) {
		MSHookIvar<NSString*>(self, "_serviceString") = string;

		[self updateForContentType:nil serviceString:self.wifiName serviceCrossfadeString:self.wifiName maxWidth:nil actions:nil];

		UIStatusBar *statusBar = (UIStatusBar*)[[UIApplication sharedApplication] statusBar];
		[statusBar setShowsOnlyCenterItems:YES];
		[statusBar setShowsOnlyCenterItems:NO];
	}
}

%end

%end

%ctor {
	HBLogInfo(@"[StatusSSID] hooked onto UIStatusBarServiceItemView");
	%init(Main);
}
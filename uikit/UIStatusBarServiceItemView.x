#import <SSShared.h>

#import <Foundation/NSDistributedNotificationCenter.h>
#import <UIKit/UIApplication.h>

#import "UIStatusBarServiceItemView.h"

%group Main

%hook UIStatusBarServiceItemView

%property (nonatomic, retain) NSString *wifiName;
%property (assign, getter=isWiFiEnabled) BOOL wifiEnabled;

-(id)initWithItem:(id)arg1 data:(id)arg2 actions:(int)arg3 style:(id)arg4 {
	HBLogInfo(@"[StatusSSID] service item view hooked");
	[[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationReceived:) name:@"StatusSSIDUpdated" object:nil];
	return %orig;
}

-(void)dealloc {
	[[NSDistributedNotificationCenter defaultCenter] removeObserver:self];
	%orig;
}

%new
-(void)notificationReceived:(NSNotification*)notification {
	self.wifiName = (NSString*)notification.userInfo[@"currentNetworkName"];
	self.wifiEnabled = [notification.userInfo[@"wifiEnabled"] boolValue];

	HBLogInfo(@"[StatusSSID] wifiName: %@", self.wifiName);
	HBLogInfo(@"[StatusSSID] wifiEnabled: %d", self.wifiEnabled);

	MSHookIvar<NSString*>(self, "_serviceString");

	// UIStatusBar *statusBar = (UIStatusBar*)[[UIApplication sharedApplication] statusBar];
	// [statusBar setShowsOnlyCenterItems:YES];
	// [statusBar setShowsOnlyCenterItems:NO];
}

%end

%end

%ctor {
	HBLogInfo(@"[StatusSSID] hooked onto UIStatusBarServiceItemView");
	%init(Main);
}
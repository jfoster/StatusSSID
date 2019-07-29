#import <SSShared.h>

#import <Foundation/NSDistributedNotificationCenter.h>
#import <SpringBoard/SBWiFiManager.h>

%group Main

%hook SBWiFiManager

-(void)_updateCurrentNetwork {
	HBLogInfo(@"[StatusSSID] _updateCurrentNetwork");

	// NSString *currentNetworkName = [self currentNetworkName];

	[[NSDistributedNotificationCenter defaultCenter] postNotificationName:SSID_NOTIFICATION_KEY object:nil userInfo:@{
		@"currentNetworkName" : @"test"
	}];

	%orig;
}

%end

%end

%ctor {
	@autoreleasepool {
		%init(Main);
	}
}
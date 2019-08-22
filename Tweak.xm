#import <Foundation/Foundation.h>
#import <firmware.h>

#define SettingsPath @"/var/mobile/Library/Preferences/tw.hiraku.datalogoswitcher.plist"

%group GiOS12
%hook SBTelephonySubscriptionContext
- (int)modemDataConnectionType
{
    int type = %orig;

    NSDictionary *defaults = [NSDictionary dictionaryWithContentsOfFile:SettingsPath];
    if ([defaults[@"3G"] intValue] == 0)
        if (type == 4 || type == 5)
            return 5;
    if ([defaults[@"3G"] intValue] == 1)
        if (type == 4 || type == 5)
            return 6;
    if ([defaults[@"3G"] intValue] == 2)
        if (type == 4 || type == 5)
            return 7;
    if ([defaults[@"4G"] intValue] == 1 && type == 7)
        return 6;
    if ([defaults[@"4G"] intValue] == 2 && type == 6)
        return 7;
    if ([defaults[@"4G"] intValue] == 0 && type == 6)
        return 6;
    if ([defaults[@"4G"] intValue] == 0 && type == 7)
        return 7;

    return type;
}
%end

%hook SBMutableTelephonyCarrierBundleInfo
- (BOOL)LTEConnectionShows4G
{
    NSDictionary *defaults = [NSDictionary dictionaryWithContentsOfFile:SettingsPath];

    if ([defaults[@"3G"] intValue] == 2)
        return NO;
    if ([defaults[@"4G"] intValue] == 2)
        return NO;

    return %orig;
}
%end
%end

%hook SBTelephonyManager
- (int)dataConnectionType {
    int type = %orig;

    NSDictionary *defaults = [NSDictionary dictionaryWithContentsOfFile:SettingsPath];
    if ([defaults[@"3G"] intValue] == 0)
        if (type == 4 || type == 5)
            return 5;
    if ([defaults[@"3G"] intValue] == 1)
        if (type == 4 || type == 5)
            return 6;
    if ([defaults[@"3G"] intValue] == 2)
        if (type == 4 || type == 5)
            return 7;
    if ([defaults[@"4G"] intValue] == 1 && type == 7)
        return 6;
    if ([defaults[@"4G"] intValue] == 2 && type == 6)
        return 7;
    if ([defaults[@"4G"] intValue] == 0 && type == 6)
        return 6;
    if ([defaults[@"4G"] intValue] == 0 && type == 7)
        return 7;

    return type;
    /*
    0 = null
    1 = 1x
    2 = GPRS
    3 = EDGE
    4 = 3G
    5 = 3G (3.5G)
    6 = 4G
    7 = LTE
    8 = HotSpot
    9 = Wifi
    10 = Wifi(2)
    11 = Syncing
    */
}
%end

%ctor {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    %init;

    if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_12_0) 
    {
        %init(GiOS12);
    }
    [pool release];
}

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Preferences/Preferences.h>
#import <objc/runtime.h>

#define UserDefaultsChangedNotification "tw.hiraku.datalogoswitcher"
#define SettingsPath @"/var/mobile/Library/Preferences/tw.hiraku.datalogoswitcher.plist"

#define kCFCoreFoundationVersionNumber_iOS_5_0 675.00
#define kCFCoreFoundationVersionNumber_iOS_6_0 793.00
#define kCFCoreFoundationVersionNumber_iOS_7_0 847.20
#define VERSION @"0.0.2"

@interface PSSpecifier (DataLogoSwitcher)
- (void)setIdentifier:(NSString *)identifier;
@end

@interface PSListController (DataLogoSwitcher)
- (void)loadView;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface PSTableCell (DataLogoSwitcher)
@property(readonly, assign, nonatomic) UILabel* textLabel;
@end

//====================================================================================================================

id getUserDefaultForKey(NSString *key) {
    NSDictionary *defaults = [NSDictionary dictionaryWithContentsOfFile:SettingsPath];
    return [defaults objectForKey:key];
}

void setUserDefaultForKey(NSString *key, id value) {
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:SettingsPath]];
    [defaults setObject:value forKey:key];
    [defaults writeToFile:SettingsPath atomically:YES];
}
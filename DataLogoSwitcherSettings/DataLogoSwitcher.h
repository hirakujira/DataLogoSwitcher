#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSListController.h>
#import <objc/runtime.h>
#import <spawn.h>
#import <rootless.h>

#define UserDefaultsChangedNotification "tw.hiraku.datalogoswitcher"
#define SettingsPath ROOT_PATH_NS(@"/var/mobile/Library/Preferences/tw.hiraku.datalogoswitcher.plist")

@interface PSSpecifier (DataLogoSwitcher)
@property (nonatomic, retain) NSArray *values;
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

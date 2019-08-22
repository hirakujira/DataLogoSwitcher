#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Preferences/Preferences.h>
#import "DataLogoSwitcher.h"

//============================================================================================================

@interface DLSSettingController: PSListController {
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)respring;
@end

@implementation DLSSettingController
- (NSArray *)specifiers
{
	if(_specifiers == nil) {
        _specifiers = [[self loadSpecifiersFromPlistName:@"DataLogoSwitcher" target:self] retain];
    }
    return _specifiers;
}

- (void)loadView {
  	[super loadView];
  	UINavigationItem* navigationItem = self.navigationItem;
  	
    NSMutableDictionary* settings = [[NSMutableDictionary alloc] initWithContentsOfFile:SettingsPath];
    if(![[NSFileManager defaultManager] fileExistsAtPath:SettingsPath]) {
        settings = [[NSMutableDictionary alloc] initWithObjectsAndKeys: @0, @"3G", 
                                                                        @0, @"4G",
                                                                        nil];
        [settings writeToFile:SettingsPath atomically:YES];
    }
}

//=============================================================================
- (id)getValueForSpecifier:(PSSpecifier *)specifier {
    return getUserDefaultForKey(specifier.identifier);
}

- (void)setValue:(id)value forSpecifier:(PSSpecifier *)specifier {
    setUserDefaultForKey(specifier.identifier, value);
}

-(void)save:(id)param
{
    sleep(1);
    system("killall lsd SpringBoard");

}
//=============================================================================
@end
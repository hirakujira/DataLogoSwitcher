#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Preferences/Preferences.h>
#import <firmware.h>
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

        NSMutableArray *specifiers = [NSMutableArray array];
        
        [specifiers addObject:[PSSpecifier emptyGroupSpecifier]];
		PSSpecifier *logo3G = [PSSpecifier preferenceSpecifierNamed:@"3G Logo" target:self set:@selector(setValue:forSpecifier:) get:@selector(getValueForSpecifier:) detail:NSClassFromString(@"PSListItemsController") cell:[PSTableCell cellTypeFromString:@"PSLinkListCell"] edit:nil];
		[logo3G setIdentifier:@"3G"];

        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_12_2)
        {
            logo3G.values = @[@0,@1,@2,@3,@4,@5];
            logo3G.titleDictionary = [NSDictionary dictionaryWithObjects:@[
                @"Default",
                @"4G",
                @"LTE",
                @"LTE-A",
                @"LTE Plus",
                @"5GE"
            ] forKeys:logo3G.values];
        }
		else
        {
            logo3G.values = @[@0,@1,@2];
            logo3G.titleDictionary = [NSDictionary dictionaryWithObjects:@[
                @"Default",
                @"4G",
                @"LTE"
            ] forKeys:logo3G.values];
        }
		[logo3G setProperty:@"kListValue" forKey:@"key"];
		[specifiers addObject:logo3G];

        [specifiers addObject:[PSSpecifier emptyGroupSpecifier]];
        NSString *name4G = kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_12_2 ?  @"4G/LTE/5GE Logo" : @"4G/LTE Logo";
        PSSpecifier *logo4G = [PSSpecifier preferenceSpecifierNamed:name4G target:self set:@selector(setValue:forSpecifier:) get:@selector(getValueForSpecifier:) detail:NSClassFromString(@"PSListItemsController") cell:[PSTableCell cellTypeFromString:@"PSLinkListCell"] edit:nil];
		[logo4G setIdentifier:@"4G"];

        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_12_2)
        {
            logo4G.values = @[@0,@1,@2,@3,@4,@5];
            logo4G.titleDictionary = [NSDictionary dictionaryWithObjects:@[
                @"Default",
                @"4G",
                @"LTE",
                @"LTE-A",
                @"LTE+",
                @"5GE"
            ] forKeys:logo4G.values];
        }
        else
        {
            logo4G.values = @[@0,@1,@2];
            logo4G.titleDictionary = [NSDictionary dictionaryWithObjects:@[
                @"Default",
                @"4G",
                @"LTE"
            ] forKeys:logo4G.values];
        }
		[logo4G setProperty:@"kListValue" forKey:@"key"];
		[specifiers addObject:logo4G];

        PSSpecifier* footSpecifier = [PSSpecifier emptyGroupSpecifier];
        [footSpecifier setProperty:@"© 2011-2019 Hiraku (@hiraku_dev)" forKey:@"footerText"];
        [specifiers addObject:footSpecifier];

        PSSpecifier *respringButton = [PSSpecifier preferenceSpecifierNamed:@"Save and Respring" target:self set:nil get:nil detail:nil cell:[PSTableCell cellTypeFromString:@"PSButtonCell"] edit:nil];
        respringButton->action = @selector(respring);
        [specifiers addObject:respringButton];

        _specifiers = [[NSArray alloc]initWithArray:specifiers];
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

-(void)respring
{
    sleep(1);
    system("killall lsd SpringBoard");

}
//=============================================================================
@end
//
//  AppDelegate.m
//  Square_Cash_NumPad
//
//  Created by Sandeep on 30/07/15.
//  Copyright (c) 2015 MSN. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+(AppDelegate *)sharedAppDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window =[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    NumpadView *objNumpadView = [[NumpadView alloc] initWithNibName:@"NumpadView" bundle:nil];
    self.window.rootViewController = objNumpadView;
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(UILabel *)BottomLinelbl:(UIButton *)btn
{
    UILabel *BottomLine =  [[UILabel alloc]initWithFrame:CGRectMake(0, btn.frame.size.height - 0.5f, btn.frame.size.width, 0.5)];
    BottomLine.backgroundColor = [UIColor whiteColor];
    return BottomLine;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end

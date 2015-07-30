//
//  AppDelegate.h
//  Square_Cash_NumPad
//
//  Created by Sandeep on 30/07/15.
//  Copyright (c) 2015 MSN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumpadView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(UILabel *)BottomLinelbl:(UIButton *)btn;
+(AppDelegate *)sharedAppDelegate;

@end


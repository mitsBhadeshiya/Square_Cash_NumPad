//
//  DVDonateView.h
//  Devote
//
//  Created by Sandeep on 16/04/15.
//  Copyright (c) 2015 Devote. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BBCyclingLabel.h"

@interface NumpadView : UIViewController

{
    IBOutlet UIButton *btn1;
    IBOutlet UIButton *btn2;
    IBOutlet UIButton *btn3;
    IBOutlet UIButton *btn4;
    IBOutlet UIButton *btn5;
    IBOutlet UIButton *btn6;
    IBOutlet UIButton *btn7;
    IBOutlet UIButton *btn8;
    IBOutlet UIButton *btn9;
    
    
    IBOutlet UIButton *btnDot;
    IBOutlet UIButton *btn0;
    IBOutlet UIButton *btnCancel;
    
    IBOutlet UIView *viewContraner;
    IBOutlet UIView *viewParentContraner;
    IBOutlet UIView *viewKeyBoard;
    IBOutlet UILabel *lblDollor;
    BOOL isCancel;
}

@property (strong, nonatomic) NSMutableString *strAmount;
@property (strong, nonatomic) IBOutlet UILabel *lblAmount;

@end

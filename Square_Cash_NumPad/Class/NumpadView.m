//  Main Copy For Build
//  DVDonateView.m
//  Devote
//
//  Created by Sandeep on 16/04/15.
//  Copyright (c) 2015 Devote. All rights reserved.
//

#import "NumpadView.h"

#define FONT_SIZE 100
#define FONT_DOLLOR 60
#define DEFAULT_LBL_HEIGHT 90
#define CHAR_WIDTH 78

#define ANI_DUR 0.1f
#define CANCEL_BTN_ENABLE_DUR 0.2f

#define FONT_MEDIU [UIFont fontWithName:@"GOTHAM-BOOK" size:110]

#define FONT_MINI [UIFont fontWithName:@"GOTHAM-BOOK" size:60]

//SCREENCONSTS

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

//OSVERSIONCONST

#define IS_IOS5 [[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0
#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0


@interface NumpadView ()

@end

@implementation NumpadView

@synthesize strAmount;
@synthesize lblAmount;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [lblAmount setNeedsLayout];
    
    [btn1 addSubview:[[AppDelegate sharedAppDelegate] BottomLinelbl:btn1]];
    [btn2 addSubview:[[AppDelegate sharedAppDelegate] BottomLinelbl:btn2]];
    [btn3 addSubview:[[AppDelegate sharedAppDelegate] BottomLinelbl:btn3]];
    [btn4 addSubview:[[AppDelegate sharedAppDelegate] BottomLinelbl:btn4]];
    [btn5 addSubview:[[AppDelegate sharedAppDelegate] BottomLinelbl:btn5]];
    [btn6 addSubview:[[AppDelegate sharedAppDelegate] BottomLinelbl:btn6]];
    [btn7 addSubview:[[AppDelegate sharedAppDelegate] BottomLinelbl:btn7]];
    [btn8 addSubview:[[AppDelegate sharedAppDelegate] BottomLinelbl:btn8]];
    [btn9 addSubview:[[AppDelegate sharedAppDelegate] BottomLinelbl:btn9]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [strAmount setString:@""];
    [self buttonclickreset];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)addDefaultContent
{
    [self addDefaultValue:NO];
    CGRect frm =lblAmount.frame;
    frm.size.width = CHAR_WIDTH;
    lblAmount.frame = frm;
    
    [self changeFrmOFDollor];
    
}

-(void)changeFrmOFDollor
{
    CGRect frm1 =lblDollor.frame;
    frm1.origin.x = lblAmount.frame.origin.x -frm1.size.width;
    frm1.origin.y = lblAmount.frame.origin.y;
    lblDollor.frame = frm1;
    
    [self scaleViewforData];
}

-(void)scaleViewforData
{
    if(IS_IPHONE_5 || IS_IPHONE_4_OR_LESS){
        
        if([[lblAmount subviews] count]  <= 2){
            [self scaleViewWith:1.30];
        }else if([[lblAmount subviews] count]  <= 3){
            [self scaleViewWith:1.12];
        }else if([[lblAmount subviews] count]  <= 4){
            [self scaleViewWith:1.0];
        }else if([[lblAmount subviews] count]  <= 5){
            [self scaleViewWith:0.8];
        }else if([[lblAmount subviews] count]  <= 6){
            [self scaleViewWith:0.7];
        }else if([[lblAmount subviews] count]  <= 7){
            [self scaleViewWith:0.6];
        }
        
        
    }else{
        if([[lblAmount subviews] count]  <= 2){
            [self scaleViewWith:1.4];
        }else if([[lblAmount subviews] count]  <= 3){
            [self scaleViewWith:1.3];
        }else if([[lblAmount subviews] count]  <= 4){
            [self scaleViewWith:1.1];
        }else if([[lblAmount subviews] count]  <= 5){
            [self scaleViewWith:0.9];
        }else if([[lblAmount subviews] count]  <= 6){
            [self scaleViewWith:0.85];
        }else if([[lblAmount subviews] count]  <= 7){
            [self scaleViewWith:0.7];
        }
    }
}

-(void)scaleViewWith:(float)val
{
    [UIView animateWithDuration:.02 animations:^{
        viewContraner.transform = CGAffineTransformMakeScale(val,val);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.05 animations:^{
        }];
    }];
}

-(void)buttonclickreset
{
    for(UIView *v in [lblAmount subviews]){
        [v removeFromSuperview];
    }
    [self addDefaultContent];
}

-(void)appendStringWithCharacter:(NSString *)strChar
{
    [strAmount appendFormat:@"%@",[strChar mutableCopy]];
    NSMutableString *strTmp = [[NSMutableString alloc] init];
    NSArray *arrStr = [strAmount componentsSeparatedByString:@"."];
    strTmp = [[arrStr objectAtIndex:0] mutableCopy];
    if ([strTmp length]==4)
    {
        [strAmount insertString:@"," atIndex:1];
    }
    else if ([strTmp length]==6)
    {
        [strAmount replaceCharactersInRange:NSMakeRange(1, 1) withString:@""];
        [strAmount insertString:@"," atIndex:2];
    }
}

-(void)removeLastDigitFromAmount
{
    if ([strAmount length] > 0)
    {
        NSCharacterSet *setForDot = [NSCharacterSet characterSetWithCharactersInString:@"0123456789,"];
        setForDot = [setForDot invertedSet];
        NSRange rangeForDot = [strAmount rangeOfCharacterFromSet:setForDot];
        if (rangeForDot.location == NSNotFound)
        {
            strAmount = [[strAmount substringToIndex:[strAmount length] - 1] mutableCopy];
            if ([strAmount length] == 4)
            {
                [strAmount replaceCharactersInRange:NSMakeRange(1, 1) withString:@""];
            }
            else if ([strAmount length]==5)
            {
                [strAmount replaceCharactersInRange:NSMakeRange(2, 1) withString:@""];
                [strAmount insertString:@"," atIndex:1];
            }
        }
        else
        {
            strAmount = [[strAmount substringToIndex:[strAmount length] - 1] mutableCopy];
        }
    }
}

-(void)setCommString
{
}

#pragma mark -
#pragma mark - BUTTON 0

-(IBAction)ButtonZERO:(id)sender
{
    //btnCancel.userInteractionEnabled = NO;
    [self setAnimationOnButton:btn0];
    UIView *lastView = [[lblAmount subviews] lastObject];
    
    if([[lblAmount subviews] count] <= 1 &&  lastView.tag == 111 ){
        return;
    }
    if(lastView.tag== 111){
        CGRect frm =lblAmount.frame;
        frm.size.width = 2;
        lblAmount.frame = frm;
        [lastView removeFromSuperview];
    }
    int totalDigit =  (int) [[lblAmount subviews] count];
    
    UIFont *curFont ;
    int lblHeight;
    
    if([self isDotInAmount]){
        
        lblHeight = 60;
        curFont = FONT_MINI;
        if(totalDigit - [self getdotIndex] >2){
            return;
        }
    }else{
        
        lblHeight = lblAmount.frame.size.height;
        curFont = [UIFont fontWithName:@"GOTHAM-BOOK" size:105];
        
        if(totalDigit == 6){
            return;
        }
    }
    
    [self appendStringWithCharacter:@"0"];
    
    int subviews = (int)[[lblAmount subviews] count];
    
    BBCyclingLabel *lbl = [[BBCyclingLabel alloc]initWithFrame:CGRectMake([self getWidthOfAllSubView] , 0, CHAR_WIDTH , lblHeight)];
    lbl.transitionDuration = ANI_DUR;
    lbl.font =curFont;
    lbl.transitionEffect = BBCyclingLabelTransitionEffectScrollDown;
    lbl.textColor = [UIColor whiteColor];
    [lbl setText:@"0" animated:YES];
    lbl.frame = [self getDynamicFrm:[self getDynamicWidthOflbl:lbl] lblFrame:lbl.frame];
    
    [lblAmount addSubview:lbl];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    CGSize CGlblSize = [self getDynamicWidthOflbl:lbl];
    
    int newSubView = (int)[[lblAmount subviews] count];
    
    [UIView animateWithDuration:ANI_DUR animations:^{
        
        CGRect frm =lblAmount.frame;
        if(subviews ==0){
            frm.size.width = CGlblSize.width;
        }else{
            frm.size.width = [self getWidthOfAllSubView];
        }
        lblAmount.frame = frm;
        lblAmount.center = viewContraner.center;
        [self changeFrmOFDollor];
        NSLog(@"2");
        if(![self isDotInAmount]){
            if(newSubView == 4){
                [self addCommaAtIndex:1];
            }else if(newSubView ==6){
                
                [self removeCommaAtIndex:1];
                [self addCommaAtIndex:2];
            }
        }
    } completion:^(BOOL finished) {
        //btnCancel.userInteractionEnabled = YES;
    }];
}

#pragma mark -
#pragma mark - BUTTON 1

-(IBAction)ButtonONE:(id)sender
{
    //btnCancel.userInteractionEnabled = NO;
    [self setAnimationOnButton:btn1];
    
    UIView *lastView = [[lblAmount subviews] lastObject];
    if(lastView.tag== 111){
        CGRect frm =lblAmount.frame;
        frm.size.width = 2;
        lblAmount.frame = frm;
        [lastView removeFromSuperview];
    }
    int totalDigit =  (int) [[lblAmount subviews] count];
    
    UIFont *curFont ;
    int lblHeight;
    
    if([self isDotInAmount]){
        
        curFont = FONT_MINI;
        lblHeight = 60;
        
        if(totalDigit - [self getdotIndex] >2){
            return;
        }
    }else{
        
        lblHeight = lblAmount.frame.size.height;
        curFont = FONT_MEDIU;
        
        
        if(totalDigit == 6){
            return;
        }
    }
    
    [self appendStringWithCharacter:@"1"];
    
    int subviews = (int)[[lblAmount subviews] count];
    
    BBCyclingLabel *lbl = [[BBCyclingLabel alloc]initWithFrame:CGRectMake([self getWidthOfAllSubView] , 0, CHAR_WIDTH , lblHeight)];
    lbl.transitionDuration = ANI_DUR;
    lbl.font = curFont;
    lbl.transitionEffect = BBCyclingLabelTransitionEffectScrollDown;
    lbl.textColor = [UIColor whiteColor];
    [lbl setText:@"1" animated:YES];
    
    lbl.frame = [self getDynamicFrm:[self getDynamicWidthOflbl:lbl] lblFrame:lbl.frame];
    [lblAmount addSubview:lbl];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    int newSubView = (int)[[lblAmount subviews] count];
    [UIView animateWithDuration:ANI_DUR animations:^{
        
        CGSize CGlblSize = [self getDynamicWidthOflbl:lbl];
        
        CGRect frm =lblAmount.frame;
        if(subviews == 0){
            frm.size.width = CGlblSize.width;
        }else{
            frm.size.width = [self getWidthOfAllSubView];
        }
        lblAmount.frame = frm;
        lblAmount.center = viewContraner.center;
        [self changeFrmOFDollor];
        
        if(![self isDotInAmount]){
            if(newSubView == 4){
                [self addCommaAtIndex:1];
            }else if(newSubView ==6){
                
                [self removeCommaAtIndex:1];
                [self addCommaAtIndex:2];
            }
        }
    } completion:^(BOOL finished) {
        //btnCancel.userInteractionEnabled = YES;
    }];
}

#pragma mark -
#pragma mark - BUTTON 2

-(IBAction)ButtonTWO:(id)sender
{
    //btnCancel.userInteractionEnabled = NO;
    [self setAnimationOnButton:btn2];
    
    UIView *lastView = [[lblAmount subviews] lastObject];
    if(lastView.tag== 111){
        CGRect frm =lblAmount.frame;
        frm.size.width = 2;
        lblAmount.frame = frm;
        [lastView removeFromSuperview];
    }
    int totalDigit =  (int) [[lblAmount subviews] count];
    
    UIFont *curFont ;
    int lblHeight ;
    
    if([self isDotInAmount]){
        curFont = FONT_MINI;
        lblHeight = 60;
        if(totalDigit - [self getdotIndex] >2){
            return;
        }
    }else{
        
        lblHeight = lblAmount.frame.size.height;
        curFont = FONT_MEDIU;
        if(totalDigit == 6){
            return;
        }
    }
    
    [self appendStringWithCharacter:@"2"];
    
    int subviews = (int)[[lblAmount subviews] count];
    
    
    BBCyclingLabel *lbl = [[BBCyclingLabel alloc]initWithFrame:CGRectMake([self getWidthOfAllSubView] , 0, CHAR_WIDTH , lblHeight)];
    
    lbl.transitionDuration = ANI_DUR;
    lbl.font =curFont;
    lbl.transitionEffect = BBCyclingLabelTransitionEffectScrollDown;
    [lbl setText:@"2" animated:YES];
    lbl.textColor = [UIColor whiteColor];
    
    lbl.frame = [self getDynamicFrm:[self getDynamicWidthOflbl:lbl] lblFrame:lbl.frame];
    [lblAmount addSubview:lbl];
    lbl.backgroundColor = [UIColor clearColor];
    
    int newSubView = (int)[[lblAmount subviews] count];
    
    [UIView animateWithDuration:ANI_DUR animations:^{
        CGSize CGlblSize = [self getDynamicWidthOflbl:lbl];
        CGRect frm =lblAmount.frame;
        if(subviews ==0){
            frm.size.width = CGlblSize.width;
        }else{
            frm.size.width = [self getWidthOfAllSubView];
        }
        lblAmount.frame = frm;
        lblAmount.center = viewContraner.center;
        [self changeFrmOFDollor];
        if(![self isDotInAmount]){
            if(newSubView == 4){
                [self addCommaAtIndex:1];
            }else if(newSubView ==6){
                [self removeCommaAtIndex:1];
                [self addCommaAtIndex:2];
            }
        }
    } completion:^(BOOL finished) {
        //btnCancel.userInteractionEnabled = YES;
    }];
}

#pragma mark -
#pragma mark - BUTTON 3

-(IBAction)ButtonTHREE:(id)sender
{
    //btnCancel.userInteractionEnabled = NO;
    [self setAnimationOnButton:btn3];
    
    UIView *lastView = [[lblAmount subviews] lastObject];
    if(lastView.tag== 111){
        CGRect frm =lblAmount.frame;
        frm.size.width = 2;
        lblAmount.frame = frm;
        [lastView removeFromSuperview];
    }
    int totalDigit =  (int) [[lblAmount subviews] count];
    
    UIFont *curFont ;
    int lblHeight ;
    
    if([self isDotInAmount]){
        
        curFont = FONT_MINI;
        lblHeight = 60;
        
        if(totalDigit - [self getdotIndex] >2){
            return;
        }
    }else{
        
        lblHeight = lblAmount.frame.size.height;
        curFont = FONT_MEDIU;
        
        if(totalDigit == 6){
            return;
        }
    }
    
    [self appendStringWithCharacter:@"3"];
    
    int subviews = (int)[[lblAmount subviews] count];
    
    BBCyclingLabel *lbl = [[BBCyclingLabel alloc]initWithFrame:CGRectMake([self getWidthOfAllSubView], 0, CHAR_WIDTH , lblHeight)];
    lbl.transitionDuration = ANI_DUR;
    lbl.font = curFont;
    lbl.transitionEffect = BBCyclingLabelTransitionEffectScrollDown;
    lbl.textColor = [UIColor whiteColor];
    [lbl setText:@"3" animated:YES];
    
    
    lbl.frame = [self getDynamicFrm:[self getDynamicWidthOflbl:lbl] lblFrame:lbl.frame];
    [lblAmount addSubview:lbl];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    int newSubView = (int)[[lblAmount subviews] count];
    [UIView animateWithDuration:ANI_DUR animations:^{
        
        CGSize CGlblSize = [self getDynamicWidthOflbl:lbl];
        
        CGRect frm =lblAmount.frame;
        if(subviews ==0){
            frm.size.width = CGlblSize.width;
        }else{
            frm.size.width = [self getWidthOfAllSubView];
        }
        lblAmount.frame = frm;
        lblAmount.center = viewContraner.center;
        
        [self changeFrmOFDollor];
        if(![self isDotInAmount]){
            if(newSubView == 4){
                [self addCommaAtIndex:1];
            }else if(newSubView ==6){
                [self removeCommaAtIndex:1];
                [self addCommaAtIndex:2];
            }
        }
    } completion:^(BOOL finished) {
        //btnCancel.userInteractionEnabled = YES;
    }];
}

#pragma mark -
#pragma mark - BUTTON 4

-(IBAction)ButtonFOUR:(id)sender
{
    //btnCancel.userInteractionEnabled = NO;
    [self setAnimationOnButton:btn4];
    
    UIView *lastView = [[lblAmount subviews] lastObject];
    if(lastView.tag== 111){
        CGRect frm =lblAmount.frame;
        frm.size.width = 2;
        lblAmount.frame = frm;
        [lastView removeFromSuperview];
    }
    
    int totalDigit =  (int) [[lblAmount subviews] count];
    
    UIFont *curFont ;
    int lblHeight ;
    
    if([self isDotInAmount]){
        
        curFont = FONT_MINI;
        lblHeight = 60;
        
        if(totalDigit - [self getdotIndex] >2){
            return;
        }
    }else{
        lblHeight = lblAmount.frame.size.height;
        curFont = FONT_MEDIU;
        
        if(totalDigit == 6){
            return;
        }
    }
    [self appendStringWithCharacter:@"4"];
    int subviews = (int)[[lblAmount subviews] count];
    
    BBCyclingLabel *lbl = [[BBCyclingLabel alloc]initWithFrame:CGRectMake([self getWidthOfAllSubView] , 0, CHAR_WIDTH , lblHeight)];
    lbl.transitionDuration = ANI_DUR;
    lbl.font = curFont;
    lbl.transitionEffect = BBCyclingLabelTransitionEffectScrollDown;
    lbl.textColor = [UIColor whiteColor];
    [lbl setText:@"4" animated:YES];
    
    lbl.frame = [self getDynamicFrm:[self getDynamicWidthOflbl:lbl] lblFrame:lbl.frame];
    [lblAmount addSubview:lbl];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    int newSubView = (int)[[lblAmount subviews] count];
    [UIView animateWithDuration:ANI_DUR animations:^{
        
        CGSize CGlblSize = [self getDynamicWidthOflbl:lbl];
        CGRect frm =lblAmount.frame;
        if(subviews ==0){
            frm.size.width = CGlblSize.width;
        }else{
            frm.size.width = [self getWidthOfAllSubView];
        }
        lblAmount.frame = frm;
        lblAmount.center = viewContraner.center;
        [self changeFrmOFDollor];
        if(![self isDotInAmount]){
            if(newSubView == 4){
                [self addCommaAtIndex:1];
            }else if(newSubView ==6){
                [self removeCommaAtIndex:1];
                [self addCommaAtIndex:2];
            }
        }
    } completion:^(BOOL finished) {
        //btnCancel.userInteractionEnabled = YES;
    }];
}

#pragma mark -
#pragma mark - BUTTON 5

-(IBAction)ButtonFIVE:(id)sender
{
    //btnCancel.userInteractionEnabled = NO;
    [self setAnimationOnButton:btn5];
    UIView *lastView = [[lblAmount subviews] lastObject];
    
    if(lastView.tag== 111){
        CGRect frm =lblAmount.frame;
        frm.size.width = 2;
        lblAmount.frame = frm;
        [lastView removeFromSuperview];
    }
    int totalDigit =  (int) [[lblAmount subviews] count];
    
    UIFont *curFont ;
    int lblHeight ;
    
    if([self isDotInAmount]){
        
        curFont = FONT_MINI;
        lblHeight = 60;
        
        if(totalDigit - [self getdotIndex] >2){
            return;
        }
    }else{
        
        lblHeight = lblAmount.frame.size.height;
        curFont = FONT_MEDIU;
        
        if(totalDigit == 6){
            return;
        }
    }
    
    [self appendStringWithCharacter:@"5"];
    
    int subviews = (int)[[lblAmount subviews] count];
    
    BBCyclingLabel *lbl = [[BBCyclingLabel alloc]initWithFrame:CGRectMake([self getWidthOfAllSubView] , 0, CHAR_WIDTH , lblHeight)];
    lbl.transitionDuration = ANI_DUR;
    lbl.font = curFont;
    lbl.transitionEffect = BBCyclingLabelTransitionEffectScrollDown;
    lbl.textColor = [UIColor whiteColor];
    [lbl setText:@"5" animated:YES];
    
    lbl.frame = [self getDynamicFrm:[self getDynamicWidthOflbl:lbl] lblFrame:lbl.frame];
    [lblAmount addSubview:lbl];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    int newSubView = (int)[[lblAmount subviews] count];
    
    [UIView animateWithDuration:ANI_DUR animations:^{
        
        
        CGSize CGlblSize = [self getDynamicWidthOflbl:lbl];
        
        CGRect frm =lblAmount.frame;
        if(subviews ==0){
            frm.size.width = CGlblSize.width;
        }else{
            frm.size.width = [self getWidthOfAllSubView];
        }
        lblAmount.frame = frm;
        lblAmount.center = viewContraner.center;
        [self changeFrmOFDollor];
        if(![self isDotInAmount]){
            if(newSubView == 4){
                [self addCommaAtIndex:1];
            }else if(newSubView ==6){
                [self removeCommaAtIndex:1];
                [self addCommaAtIndex:2];
            }
        }
    } completion:^(BOOL finished) {
        //btnCancel.userInteractionEnabled = YES;
    }];
}
#pragma mark -
#pragma mark - BUTTON 6

-(IBAction)ButtonSIX:(id)sender
{
    //btnCancel.userInteractionEnabled = NO;
    [self setAnimationOnButton:btn6];
    UIView *lastView = [[lblAmount subviews] lastObject];
    
    if(lastView.tag== 111){
        CGRect frm =lblAmount.frame;
        frm.size.width = 2;
        lblAmount.frame = frm;
        [lastView removeFromSuperview];
    }
    int totalDigit =  (int) [[lblAmount subviews] count];
    
    UIFont *curFont ;
    int lblHeight ;
    
    if([self isDotInAmount]){
        
        curFont = FONT_MINI;
        lblHeight = 60;
        
        if(totalDigit - [self getdotIndex] >2){
            return;
        }
    }else{
        
        lblHeight = lblAmount.frame.size.height;
        curFont = FONT_MEDIU;
        
        if(totalDigit == 6){
            return;
        }
    }
    
    [self appendStringWithCharacter:@"6"];
    
    int subviews = (int)[[lblAmount subviews] count];
    
    BBCyclingLabel *lbl = [[BBCyclingLabel alloc]initWithFrame:CGRectMake([self getWidthOfAllSubView] , 0, CHAR_WIDTH , lblHeight)];
    lbl.transitionDuration = ANI_DUR;
    lbl.font = curFont;
    lbl.transitionEffect = BBCyclingLabelTransitionEffectScrollDown;
    [lbl setText:@"6" animated:YES];
    lbl.textColor = [UIColor whiteColor];
    lbl.frame = [self getDynamicFrm:[self getDynamicWidthOflbl:lbl] lblFrame:lbl.frame];
    [lblAmount addSubview:lbl];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    int newSubView = (int)[[lblAmount subviews] count];
    [UIView animateWithDuration:ANI_DUR animations:^{
        
        CGSize CGlblSize = [self getDynamicWidthOflbl:lbl];
        
        CGRect frm =lblAmount.frame;
        if(subviews ==0){
            frm.size.width = CGlblSize.width;
        }else{
            frm.size.width = [self getWidthOfAllSubView];
        }
        lblAmount.frame = frm;
        lblAmount.center = viewContraner.center;
        [self changeFrmOFDollor];
        if(![self isDotInAmount]){
            if(newSubView == 4){
                [self addCommaAtIndex:1];
            }else if(newSubView ==6){
                [self removeCommaAtIndex:1];
                [self addCommaAtIndex:2];
            }
        }
    } completion:^(BOOL finished) {
        //btnCancel.userInteractionEnabled = YES;
    }];
}

#pragma mark -
#pragma mark - BUTTON 7

-(IBAction)ButtonSEVEN:(id)sender
{
    //btnCancel.userInteractionEnabled= NO;
    [self setAnimationOnButton:btn7];
    
    UIView *lastView = [[lblAmount subviews] lastObject];
    if(lastView.tag== 111)
    {
        CGRect frm =lblAmount.frame;
        frm.size.width = 2;
        lblAmount.frame = frm;
        [lastView removeFromSuperview];
    }
    int totalDigit =  (int) [[lblAmount subviews] count];
    
    UIFont *curFont ;
    int lblHeight ;
    
    if([self isDotInAmount])
    {
        curFont = FONT_MINI;
        lblHeight = 60;
        
        if(totalDigit - [self getdotIndex] >2)
        {
            return;
        }
    }
    else
    {
        lblHeight = lblAmount.frame.size.height;
        curFont = FONT_MEDIU;
        
        if(totalDigit == 6)
        {
            return;
        }
    }
    
    [self appendStringWithCharacter:@"7"];
    
    int subviews = (int)[[lblAmount subviews] count];
    
    BBCyclingLabel *lbl = [[BBCyclingLabel alloc]initWithFrame:CGRectMake([self getWidthOfAllSubView] , 0, CHAR_WIDTH , lblHeight)];
    lbl.transitionDuration = ANI_DUR;
    lbl.font = curFont;
    lbl.transitionEffect = BBCyclingLabelTransitionEffectScrollDown;
    [lbl setText:@"7" animated:YES];
    lbl.textColor = [UIColor whiteColor];
    lbl.frame = [self getDynamicFrm:[self getDynamicWidthOflbl:lbl] lblFrame:lbl.frame];
    [lblAmount addSubview:lbl];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    int newSubView = (int)[[lblAmount subviews] count];
    
    [UIView animateWithDuration:ANI_DUR animations:^{
        
        CGSize CGlblSize = [self getDynamicWidthOflbl:lbl];
        
        CGRect frm =lblAmount.frame;
        if(subviews ==0){
            frm.size.width = CGlblSize.width;
        }else{
            frm.size.width = [self getWidthOfAllSubView];
        }
        lblAmount.frame = frm;
        lblAmount.center = viewContraner.center;
        [self changeFrmOFDollor];
        if(![self isDotInAmount]){
            if(newSubView == 4){
                [self addCommaAtIndex:1];
            }else if(newSubView ==6){
                [self removeCommaAtIndex:1];
                [self addCommaAtIndex:2];
            }
        }
        
    } completion:^(BOOL finished) {
        //btnCancel.userInteractionEnabled = YES;
    }];
}
#pragma mark -
#pragma mark - BUTTON 8

-(IBAction)ButtonEIGHT:(id)sender
{
    //btnCancel.userInteractionEnabled = NO;
    [self setAnimationOnButton:btn8];
    
    UIView *lastView = [[lblAmount subviews] lastObject];
    if(lastView.tag== 111){
        CGRect frm =lblAmount.frame;
        frm.size.width = 2;
        lblAmount.frame = frm;
        [lastView removeFromSuperview];
    }
    int totalDigit =  (int) [[lblAmount subviews] count];
    
    UIFont *curFont ;
    int lblHeight ;
    
    if([self isDotInAmount]){
        
        curFont = FONT_MINI;
        lblHeight = 60;
        
        if(totalDigit - [self getdotIndex] >2){
            return;
        }
    }else{
        
        lblHeight = lblAmount.frame.size.height;
        curFont = FONT_MEDIU;
        
        if(totalDigit == 6){
            return;
        }
    }
    
    [self appendStringWithCharacter:@"8"];
    
    int subviews = (int)[[lblAmount subviews] count];
    
    BBCyclingLabel *lbl = [[BBCyclingLabel alloc]initWithFrame:CGRectMake([self getWidthOfAllSubView] , 0, CHAR_WIDTH , lblHeight)];
    lbl.transitionDuration = ANI_DUR;
    lbl.font = curFont;
    lbl.transitionEffect = BBCyclingLabelTransitionEffectScrollDown;
    [lbl setText:@"8" animated:YES];
    lbl.textColor = [UIColor whiteColor];
    lbl.frame = [self getDynamicFrm:[self getDynamicWidthOflbl:lbl] lblFrame:lbl.frame];
    [lblAmount addSubview:lbl];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    int newSubView = (int)[[lblAmount subviews] count];
    
    [UIView animateWithDuration:ANI_DUR animations:^{
        
        CGSize CGlblSize = [self getDynamicWidthOflbl:lbl];
        CGRect frm =lblAmount.frame;
        if(subviews ==0){
            frm.size.width = CGlblSize.width;
        }else{
            frm.size.width = [self getWidthOfAllSubView];
        }
        lblAmount.frame = frm;
        lblAmount.center = viewContraner.center;
        [self changeFrmOFDollor];
        if(![self isDotInAmount]){
            if(newSubView == 4){
                [self addCommaAtIndex:1];
            }else if(newSubView ==6){
                [self removeCommaAtIndex:1];
                [self addCommaAtIndex:2];
            }
        }
    } completion:^(BOOL finished) {
        //btnCancel.userInteractionEnabled = YES;
    }];
}

#pragma mark -
#pragma mark - BUTTON 9

-(IBAction)ButtonNINE:(id)sender
{
    //btnCancel.userInteractionEnabled = NO;
    [self setAnimationOnButton:btn9];
    
    UIView *lastView = [[lblAmount subviews] lastObject];
    if(lastView.tag== 111){
        CGRect frm =lblAmount.frame;
        frm.size.width = 2;
        lblAmount.frame = frm;
        [lastView removeFromSuperview];
    }
    int totalDigit =  (int) [[lblAmount subviews] count];
    
    
    UIFont *curFont ;
    int lblHeight ;
    
    if([self isDotInAmount]){
        
        curFont = FONT_MINI;
        lblHeight = 60;
        
        if(totalDigit - [self getdotIndex] >2){
            return;
        }
    }else{
        
        lblHeight = lblAmount.frame.size.height;
        curFont = FONT_MEDIU;
        
        if(totalDigit == 6){
            return;
        }
    }
    
    [self appendStringWithCharacter:@"9"];
    
    int subviews = (int)[[lblAmount subviews] count];
    
    BBCyclingLabel *lbl = [[BBCyclingLabel alloc]initWithFrame:CGRectMake([self getWidthOfAllSubView] , 0, CHAR_WIDTH , lblHeight)];
    lbl.transitionDuration = ANI_DUR;
    lbl.font = curFont;
    lbl.transitionEffect = BBCyclingLabelTransitionEffectScrollDown;
    [lbl setText:@"9" animated:YES];
    lbl.textColor = [UIColor whiteColor];
    lbl.frame = [self getDynamicFrm:[self getDynamicWidthOflbl:lbl] lblFrame:lbl.frame];
    [lblAmount addSubview:lbl];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    int newSubView = (int)[[lblAmount subviews] count];
    [UIView animateWithDuration:ANI_DUR animations:^{
        
        CGSize CGlblSize = [self getDynamicWidthOflbl:lbl];
        CGRect frm =lblAmount.frame;
        if(subviews ==0){
            frm.size.width = CGlblSize.width;
        }else{
            frm.size.width = [self getWidthOfAllSubView];
        }
        lblAmount.frame = frm;
        lblAmount.center = viewContraner.center;
        [self changeFrmOFDollor];
        if(![self isDotInAmount]){
            if(newSubView == 4){
                [self addCommaAtIndex:1];
            }else if(newSubView ==6){
                [self removeCommaAtIndex:1];
                [self addCommaAtIndex:2];
            }
        }
    } completion:^(BOOL finished) {
        //btnCancel.userInteractionEnabled = YES;
    }];
}

#pragma mark -
#pragma mark - BUTTON .

-(IBAction)ButtonDOT:(id)sender
{
    //btnCancel.userInteractionEnabled = NO;
    [self setAnimationOnButton:btnDot];
    UIView *lastView = [[lblAmount subviews] lastObject];
    
    if([[lblAmount subviews] count] <= 1 &&  lastView.tag == 111 ){
        return;
    }
    
    UIFont *curFont ;
    
    if([self isDotInAmount])
    {
        curFont = FONT_MINI;
        return;
    }
    else
    {
        int totalDigit =  (int) [[lblAmount subviews] count];
        curFont  = FONT_MEDIU;
        if(totalDigit == 6)
        {
            return;
        }
    }
    
    if(lastView.tag== 111)
    {
        CGRect frm =lblAmount.frame;
        frm.size.width = 2;
        lblAmount.frame = frm;
        [lastView removeFromSuperview];
    }
    
    [self appendStringWithCharacter:@"."];
    
    int subviews = (int)[[lblAmount subviews] count];
    
    BBCyclingLabel *lbl = [[BBCyclingLabel alloc]initWithFrame:CGRectMake([self getWidthOfAllSubView] , 0, CHAR_WIDTH , lblAmount.frame.size.height)];
    lbl.transitionDuration = ANI_DUR;
    lbl.font = [UIFont fontWithName:@"GOTHAM-BOOK" size:110.0f];
    lbl.transitionEffect = BBCyclingLabelTransitionEffectScrollDown;
    lbl.textColor = [UIColor whiteColor];
    [lbl setText:@"." animated:YES];
    
    lbl.frame = [self getDynamicFrm:[self getDynamicWidthOflbl:lbl] lblFrame:lbl.frame];
    lbl.tag = 12321;
    [lblAmount addSubview:lbl];
    lbl.backgroundColor = [UIColor clearColor];
    
    int newSubView = (int)[[lblAmount subviews] count];
    [UIView animateWithDuration:ANI_DUR animations:^{
        
        CGSize CGlblSize = [self getDynamicWidthOflbl:lbl];
        CGRect frm =lblAmount.frame;
        if(subviews ==0){
            frm.size.width = CGlblSize.width;
        }else{
            frm.size.width = [self getWidthOfAllSubView];
        }
        lblAmount.frame = frm;
        lblAmount.center = viewContraner.center;
        [self changeFrmOFDollor];
        if(![self isDotInAmount]){
            if(newSubView == 4){
                [self addCommaAtIndex:1];
            }
        }
    } completion:^(BOOL finished) {
        //btnCancel.userInteractionEnabled = YES;
    }];
}

#pragma mark -
#pragma mark - BUTTON CANCEL


-(IBAction)ButtonCANCEL:(id)sender
{
    [self setAnimationOnButton:btnCancel];
    [self removeLastDigitFromAmount];
    
    UIView *view = [[lblAmount subviews]lastObject];
    if([self isDotInAmount])
    {
        [self animateViewHeight:view withAnimationType:kCATransitionFromBottom];
    }
    else
    {
        if([[lblAmount subviews] count] ==1)
        {
            if(view.tag != 111)
            {
                [self animateViewHeight:view withAnimationType:kCATransitionFromBottom];
                [self addDefaultValue:YES];
            }
        }
        else if([[lblAmount subviews] count] == 6)
        {
            [self removeCommaAtIndex:2];
            [self addCommaAtIndex:1];
            [self animateViewHeight:view withAnimationType:kCATransitionFromBottom];
        }
        else if([[lblAmount subviews] count] == 5)
        {
            [self removeCommaAtIndex:1];
            [self animateViewHeight:view withAnimationType:kCATransitionFromBottom];
        }
        else
        {
            [self animateViewHeight:view withAnimationType:kCATransitionFromBottom];
        }
    }
}

#pragma mark -
#pragma mark - COMMON METHODS

-(void)setAnimationOnButton:(UIButton *)btn
{
    [UIView animateWithDuration:.02 animations:^{
        btn.transform = CGAffineTransformMakeScale(1.3,1.3);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.05 animations:^{
            btn.transform = CGAffineTransformIdentity;
        }];
    }];
}

-(BOOL)isDotInAmount
{
    
    BOOL isDot = NO;
    for(int i=0 ; i<[[lblAmount subviews] count] ; i++){
        UIView *view = [[lblAmount subviews] objectAtIndex:i];
        if(view.tag == 12321){
            isDot = YES;
        }
    }
    return isDot;
}

-(int)getdotIndex
{
    int isDot = 0;
    for(int i=0 ; i<[[lblAmount subviews] count] ; i++){
        UIView *view = [[lblAmount subviews] objectAtIndex:i];
        if(view.tag == 12321){
            isDot = i;
        }
    }
    return isDot;
}

#pragma mark -
#pragma mark -  HELPER METHODS


-(void)addDefaultValue:(BOOL)isAnimated
{
    BBCyclingLabel *lbl1 = [[BBCyclingLabel alloc]initWithFrame:CGRectMake(0, 0, CHAR_WIDTH , lblAmount.frame.size.height)];
    lbl1.transitionDuration = ANI_DUR;
    [lbl1 sizeToFit];
    lbl1.font = [UIFont fontWithName:@"GOTHAM-BOOK" size:105];
    lbl1.transitionEffect = BBCyclingLabelTransitionEffectScrollDown;
    [lbl1 setText:@"0" animated:isAnimated];
    lbl1.textColor = [UIColor whiteColor];
    lbl1.frame = [self getDynamicFrm:[self getDynamicWidthOflbl:lbl1] lblFrame:lbl1.frame];
    
    lbl1.tag= 111;
    //lbl1.backgroundColor = [UIColor purpleColor];
    
    [lblAmount addSubview:lbl1];
    
    CGSize CGlblSize = [self getDynamicWidthOflbl:lbl1];
    
    if(isAnimated){
        [UIView animateWithDuration:ANI_DUR animations:^{
            
            CGRect frm =lblAmount.frame;
            frm.size.width = CGlblSize.width;
            frm.size.height = FONT_SIZE;
            lblAmount.frame = frm;
            lblAmount.center = viewContraner.center;
            [self changeFrmOFDollor];
        }];
        
    }else{
        CGRect frm =lblAmount.frame;
        frm.size.width = CGlblSize.width;
        frm.size.height = FONT_SIZE;
        lblAmount.frame = frm;
        lblAmount.center = viewContraner.center;
        [self changeFrmOFDollor];
    }
}

-(int)getWidthOfAllSubView
{
    int totalWidth = 0;
    for(UIView *view in [lblAmount subviews]){
        totalWidth = totalWidth + view.frame.size.width;
    }
    return totalWidth;
}

-(CGSize )getDynamicWidthOflbl:(BBCyclingLabel *)lbl
{
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:lbl.text attributes:@ {NSFontAttributeName:lbl.font }];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){CGFLOAT_MAX,lbl.frame.size.width }options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGSize size = rect.size;
    return size;
}

-(CGRect )getDynamicFrm:(CGSize)lblSize lblFrame:(CGRect )frm
{
    CGRect lblFrm = frm;
    lblFrm.size = lblSize;
    return lblFrm;
}

- (void)animateViewHeight:(UIView*)animateView withAnimationType:(NSString*)animType {
    
    [UIView animateWithDuration:ANI_DUR animations:^
     {
         [self AllButtonDisable];
         animateView.alpha = 0.0;
         [UIView animateWithDuration:ANI_DUR
                          animations:^{
                              CGRect frm = animateView.frame;
                              frm.origin.y = frm.origin.y - frm.size.height;
                              animateView.frame = frm;
                          }];
         
     }
                     completion:^(BOOL finished)
     {
         [animateView removeFromSuperview];
         CGRect frm1 =lblAmount.frame;
         frm1.size.width = [self getWidthOfAllSubView];
         lblAmount.frame = frm1;
         lblAmount.center = viewContraner.center;
         [self changeFrmOFDollor];
         [self AllButtonEnable];
     }];
}

-(void)removeView:(id)animateView
{
    [UIView animateWithDuration:ANI_DUR animations:^{
        
        [animateView removeFromSuperview];
        CGRect frm =lblAmount.frame;
        frm.size.width = [self getWidthOfAllSubView];
        lblAmount.frame = frm;
        lblAmount.center = viewContraner.center;
        [self changeFrmOFDollor];
    }];
}

-(void)removeCommaAtIndex:(int)index
{
    int width = 0;
    for(int i=0 ; i< [[lblAmount subviews] count] ; i++){
        if(i == index){
            UIView *view = [[lblAmount subviews] objectAtIndex:i];
            if(view.tag== 123){
                width = view.frame.size.width;
                [view removeFromSuperview];
            }
        }
    }
    [UIView animateWithDuration:ANI_DUR animations:^{
        [self AllButtonDisable];
        for(int i=0 ; i< [[lblAmount subviews] count] ; i++){
            if(i >= index){
                UIView *view = [[lblAmount subviews] objectAtIndex:i];
                
                CGRect frm = view.frame;
                frm.origin.x = view.frame.origin.x - width;
                view.frame = frm;
            }
        }
        [self changeFrmOFDollor];
    } completion:^(BOOL finished) {
        [self AllButtonEnable];
    }];
}

-(void)addCommaAtIndex:(int )index
{
    [UIView animateWithDuration:ANI_DUR animations:^{
        [self AllButtonDisable];
        BBCyclingLabel *lbl = [[BBCyclingLabel alloc]initWithFrame:CGRectMake([self getLengthOfsubViewUpto:index] , 0, CHAR_WIDTH , lblAmount.frame.size.height)];
        lbl.transitionDuration = ANI_DUR;
        lbl.font = [UIFont systemFontOfSize:80.0f];
        lbl.transitionEffect = BBCyclingLabelTransitionEffectScrollDown;
        [lbl setText:@"," animated:YES];
        lbl.textColor = [UIColor whiteColor];
        lbl.frame = [self getDynamicFrm:[self getDynamicWidthOflbl:lbl] lblFrame:lbl.frame];
        lbl.tag = 123;
        [lblAmount insertSubview:lbl atIndex:index];
        
        for(int i=0 ; i< [[lblAmount subviews] count] ; i++){
            if(i > index){
                UIView *view = [[lblAmount subviews] objectAtIndex:i];
                
                CGRect frm = view.frame;
                frm.origin.x = view.frame.origin.x + lbl.frame.size.width;
                view.frame = frm;
            }
        }
        [self changeFrmOFDollor];
    } completion:^(BOOL finished) {
        [self AllButtonEnable];
    }];
}

-(int)getLengthOfsubViewUpto:(int)limit
{
    int totalWidth = 0;
    for(int i=0 ; i<limit ; i++){
        UIView *view = [[lblAmount subviews] objectAtIndex:i];
        totalWidth = totalWidth + view.frame.size.width;
    }
    return totalWidth;
}

-(void)AllButtonEnable
{
    btn0.userInteractionEnabled = YES;
    btn1.userInteractionEnabled = YES;
    btn2.userInteractionEnabled = YES;
    btn3.userInteractionEnabled = YES;
    btn4.userInteractionEnabled = YES;
    btn5.userInteractionEnabled = YES;
    btn6.userInteractionEnabled = YES;
    btn7.userInteractionEnabled = YES;
    btn8.userInteractionEnabled = YES;
    btn9.userInteractionEnabled = YES;
    btnDot.userInteractionEnabled = YES;
}

-(void)AllButtonDisable
{
    btn0.userInteractionEnabled = NO;
    btn1.userInteractionEnabled = NO;
    btn2.userInteractionEnabled = NO;
    btn3.userInteractionEnabled = NO;
    btn4.userInteractionEnabled = NO;
    btn5.userInteractionEnabled = NO;
    btn6.userInteractionEnabled = NO;
    btn7.userInteractionEnabled = NO;
    btn8.userInteractionEnabled = NO;
    btn9.userInteractionEnabled = NO;
    btnDot.userInteractionEnabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

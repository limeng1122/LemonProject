//
//  ViewHelper.m
//  SchoolCool
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "ViewHelper.h"
#import "AppDelegate.h"
#import "UITouchToolBar.h"
#import "NSString+Size.h"
#import "OneLoadingAnimationView.h"
#import "LoadingHUD.h"

@implementation ViewHelper

+ (void)showPromptText:(NSString *)text
{
    if (!text || text.length == 0) {
        return;
    }
    
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIView *view = appDelegate.window;
    
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[UITouchToolBar class]]) {
            if (subview.superview) {
                [subview removeFromSuperview];
            }
        }
    }
    UIFont *font = [UIFont systemFontOfSize:15];
    
    CGFloat minWidth = appFrame.size.width / 2;
    CGFloat maxWidth = appFrame.size.width - 60;
    CGFloat width = [text textSizeWithFont:font constrainedToSize:CGSizeMake(0, 40)].width + 20;
    
    if (width < minWidth) {
        width = minWidth;
    } else if (width > maxWidth) {
        width = maxWidth;
    }
    
    CGFloat height = [text textSizeWithFont:font constrainedToSize:CGSizeMake(width - 10, 0)].height + 10;
    if (height < 40) {
        height = 40;
    }
    
    UITouchToolBar *tipView = [[UITouchToolBar alloc] initWithFrame:CGRectMake((appFrame.size.width - width) / 2, appFrame.size.height / 2 - 20, width, height)];
    tipView.barStyle = UIBarStyleBlack;
    tipView.layer.cornerRadius = 5;
    tipView.layer.masksToBounds = YES;
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 4, width - 10, height - 8)];
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.font = [UIFont systemFontOfSize:15];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.numberOfLines = 0;
    [tipView addSubview:tipLabel];
    tipLabel.text = text;
    
    [view addSubview:tipView];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:2.5];
        // 调用主线程更新UI
        dispatch_sync(dispatch_get_main_queue(), ^{
            [tipView removeFromSuperview];
        });
    });
}

+ (void)hideIndicator
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIView *view = appDelegate.window;
    [LoadingHUD hideHUDForView:view animated:YES];
}

+ (UIImage *)createImageWithColor:(UIColor *)color bounds:(CGRect)bounds
{
    CGRect rect = bounds;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIColor *)getRandomColor
{
    NSArray *colors = @[ UIColorFromRGB(0xF44336),
                         UIColorFromRGB(0xE91E63),
                         UIColorFromRGB(0x9C27B0),
                         UIColorFromRGB(0x673AB7),
                         UIColorFromRGB(0x3F51B5),
                         UIColorFromRGB(0x2196F3),
                         UIColorFromRGB(0x03A9F4),
                         UIColorFromRGB(0x00BCD4),
                         UIColorFromRGB(0x009688),
                         UIColorFromRGB(0x4CAF50),
                         UIColorFromRGB(0x8BC34A),
                         UIColorFromRGB(0xFDD835),
                         UIColorFromRGB(0xFFC107),
                         UIColorFromRGB(0xFF9800),
                         UIColorFromRGB(0xFF5722),
                         UIColorFromRGB(0x795548) ];
    
    int r = arc4random_uniform(16);
    
    return [colors objectAtIndex:r];
}

+(void)hideHUDWithComplition:(void(^)(void))complition
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIView *view = appDelegate.window;
    LoadingHUD *hud = [LoadingHUD HUDForView:view];
    [hud hideHUDAnimated:YES];
    if(complition){
        complition();
    }
}

+ (void)showIndicatorWithCover
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIView *view = appDelegate.window;
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
    
    OneLoadingAnimationView *loadingView = [[OneLoadingAnimationView alloc] initStyle:SmallStyle];
    loadingView.center = CGPointMake(CGRectGetMidX(customView.frame), CGRectGetMidY(customView.frame));
    loadingView.normalColor = BlackColor;
    [loadingView startAnimation];
    [customView addSubview:loadingView];
    
    LoadingHUD *hud = [LoadingHUD addHUDForView:view contentView:customView];
    [hud showHUDAnimated:YES];
}

+ (void)showIndicatorCoverWithMsg:(NSString *)msg
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIView *view = appDelegate.window;
    
    
    CGFloat width = [msg textSizeWithFont:SmallFont constrainedToSize:CGSizeMake(0, 16)].width+16;
    if(width < 80){
        width = 80;
    }
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 80)];
    OneLoadingAnimationView *loadingView = [[OneLoadingAnimationView alloc] initStyle:SmallStyle];
    loadingView.center = CGPointMake(CGRectGetMidX(customView.frame), 26);
    loadingView.normalColor = BlackColor;
    [loadingView startAnimation];
    [customView addSubview:loadingView];
    
    UILabel *textView = [[UILabel alloc] initWithFrame:CGRectMake(0, UIControlYLength(loadingView)+8, width, 16)];
    textView.font = SmallFont;
    textView.backgroundColor = [UIColor clearColor];
    textView.textAlignment = NSTextAlignmentCenter;
    textView.text = msg;
    [customView addSubview:textView];
    
    LoadingHUD *hud = [LoadingHUD addHUDForView:view contentView:customView];
    [hud showHUDAnimated:YES];
    
}


+(void)showFailedHUDWithMsg:(NSString*)msg complition:(void(^)(void))complition
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIView *view = appDelegate.window;
    LoadingHUD *hud = [LoadingHUD HUDForView:view];
    UIView *customView = hud.customView;
    if(customView && customView.subviews.count > 0){
        OneLoadingAnimationView *loadingView = (OneLoadingAnimationView*)[customView.subviews firstObject];
        [loadingView toFailedViewState];
        loadingView.loadingAnimFinishedHandler = ^{
            [hud hideHUDAnimated:YES];
            [ViewHelper showRichTextAlertViewWithText:msg buttonTitles:@[@"确定"]];
        };
    }
}

+(CustomIOSAlertView*)showRichTextAlertViewWithText:(NSString*)text buttonTitles:(NSArray*)buttonTitles
{
    if([Utils isEmpty:text]){
        return nil;
    }
    
    CGFloat height = [text textSizeWithFont:BigFont constrainedToSize:CGSizeMake([CustomIOSAlertView getDefaultWidth], 0)].height+16;
    if(height > 120){
        height = 120;
    }
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, [CustomIOSAlertView getDefaultWidth], height)];
    textView.font = BigFont;
    textView.backgroundColor = [UIColor clearColor];
    textView.textAlignment = NSTextAlignmentCenter;
    textView.editable = NO;
    textView.text = text;
    textView.selectable = YES;
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] initWithTitle:@"提示"];
    [alertView setContainerView:textView];
    alertView.buttonTitles = buttonTitles;
    [alertView show];
    return alertView;
}

+(void)showSuccessHUDWithComplition:(void(^)(void))complition
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIView *view = appDelegate.window;
    LoadingHUD *hud = [LoadingHUD HUDForView:view];
    UIView *customView = hud.customView;
    if(customView && customView.subviews.count > 0){
        OneLoadingAnimationView *loadingView = (OneLoadingAnimationView*)[customView.subviews firstObject];
        [loadingView toSuccessViewState];
        loadingView.loadingAnimFinishedHandler = ^{
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [hud hideHUDAnimated:YES];
                if(complition){
                    complition();
                }
            });
        };
    }
}

+ (void)setUserInteractionEnabled:(BOOL)enabled
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.window setUserInteractionEnabled:enabled];
}

@end

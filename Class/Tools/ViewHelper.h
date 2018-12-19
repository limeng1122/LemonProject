//
//  ViewHelper.h
//  SchoolCool
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macro.h"
#import "PrefixHeader.pch"
#import "CustomIOSAlertView.h"

@interface ViewHelper : NSObject


//在屏幕中央显示一个黑色背景的提示消息，如用户填写的数据不正确
+ (void)showPromptText:(NSString *)text;

//隐藏屏幕中央的黑色方块背景的加载View
+ (void)hideIndicator;

//将像素转换为Image
+ (UIImage *)createImageWithColor:(UIColor *)color bounds:(CGRect)bounds;

//随机颜色
+ (UIColor *)getRandomColor;

//弹出一个支持富文本显示的对话框
+(CustomIOSAlertView*)showRichTextAlertViewWithText:(NSString*)text buttonTitles:(NSArray*)buttonTitles;

//在屏幕中央显示一个黑色方块背景的加载View和提示消息
+ (void)showIndicatorCoverWithMsg:(NSString *)msg;
//在屏幕中央显示一个黑色方块背景的加载View
+ (void)showIndicatorWithCover;

//显示加载成功的HUD
+(void)showSuccessHUDWithComplition:(void(^)(void))complition;
+(void)hideHUDWithComplition:(void(^)(void))complition;
+(void)showFailedHUDWithMsg:(NSString*)msg complition:(void(^)(void))complition;

//是否显示状态栏的loading
+ (void)setUserInteractionEnabled:(BOOL)enabled;
@end

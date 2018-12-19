//
//  UIAlertController+JBAlertViewController.h
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/12/7.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (JBAlertViewController)

/**
 UIAlertControllerStyleAlert

 @param title 主标题
 @param destructive 确定
 @param cancel 取消
 @param des 确定点击事件
 @param cal 取消点击事件
 @return UIAlertControllerStyleAlert
 */
+ (UIAlertController *)alertTitle:(NSString *)title destructiveTitle:(NSString *)destructive cancelTitle:(NSString *)cancel desEvent:(void (^)())des cancelEvent:(void (^)())cal;

/**
 UIAlertControllerStyleActionSheet

 @param title 标题
 @param top 第1个action
 @param midst 第2个aciton
 @param bottom 第3个action
 @param topev 第1个action 事件
 @param midstev 第2个aciton 事件
 @param bottomev 第3个action 事件
 @return JBAlertViewController
 */
+ (UIAlertController *)actionTitle:(NSString *)title topTitle:(NSString *)top midstTitle:(NSString *)midst bottomTitle:(NSString *)bottom topEvent:(void (^)())topev midstEvent:(void (^)())midstev bottomEvent:(void (^)())bottomev;
@end

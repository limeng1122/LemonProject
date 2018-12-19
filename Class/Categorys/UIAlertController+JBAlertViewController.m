//
//  UIAlertController+JBAlertViewController.m
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/12/7.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "UIAlertController+JBAlertViewController.h"

@implementation UIAlertController (JBAlertViewController)
+ (UIAlertController *)alertTitle:(NSString *)title destructiveTitle:(NSString *)destructive cancelTitle:(NSString *)cancel desEvent:(void (^)(void))des cancelEvent:(void (^)(void))cal
{
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:destructive style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        des();
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        cal();
    }];

    [alertDialog addAction:sureAction];
    [alertDialog addAction:cancelAction];
    
    return alertDialog;
}

+ (UIAlertController *)actionTitle:(NSString *)title topTitle:(NSString *)top midstTitle:(NSString *)midst bottomTitle:(NSString *)bottom topEvent:(void (^)(void))topev midstEvent:(void (^)(void))midstev bottomEvent:(void (^)(void))bottomev
{
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:top style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        topev();
    }];
    
    UIAlertAction *pictureAction = [UIAlertAction actionWithTitle:midst style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        midstev();
    }];
    UIAlertAction *finishAction = [UIAlertAction actionWithTitle:bottom style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        bottomev();
    }];
    
    [alertDialog addAction:photoAction];
    [alertDialog addAction:pictureAction];
    [alertDialog addAction:finishAction];
    
    return alertDialog;
}
@end

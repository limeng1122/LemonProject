//
//  BaseScrollView.m
//  SchoolCool
//
//  Created by 李檬 on 2018/8/22.
//  Copyright © 2018年 interviewContent. All rights reserved.
//

#import "BaseScrollView.h"

@interface BaseScrollView ()

@end


@implementation BaseScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
 //   NSLog(@"%@",NSStringFromClass([touch.view class]));
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    else if([NSStringFromClass([touch.view class]) isEqualToString:@"UIControl"]){
        return NO;
    }
    return  YES;
}

@end

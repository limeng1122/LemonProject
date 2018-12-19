//
//  UIView+Custom.h
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/3/22.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Custom)
// 创建line的方法,参数可为UIColor或者UIImage(image需要自己进行拉伸操作)
- (UIView *)createLineWithColor:(UIColor *)color frame:(CGRect)frame;

//设置阴影
- (void)setShadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius;

-(void)setDefaultShadow;

//设置边框颜色
- (void)setBorderColor:(UIColor *)color width:(CGFloat)width;

// 设置圆角
- (void)setCornerRadius:(CGFloat)radius;

//缩放
- (void)setScaleX:(CGFloat)sx scaleY:(CGFloat)sy;

- (UIView *)findFirstResponder;
@end

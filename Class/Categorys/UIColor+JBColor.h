//
//  UIColor+JBColor.h
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/6/6.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JBColor)
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

// UIColor 转UIImage
+ (UIImage *)imageWithColor:(UIColor *)color;
@end

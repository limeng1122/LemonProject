//
//  UIImageView+JBImageView.h
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/12/8.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (JBImageView)

/**
 贝塞尔曲线切割圆角

 @param cornerRadius 圆角
 */
- (UIImageView *)roundedRectImageViewWithCornerRadius:(CGFloat)cornerRadius;
@end

//
//  UIImageView+JBImageView.m
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/12/8.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "UIImageView+JBImageView.h"

@implementation UIImageView (JBImageView)
- (UIImageView *)roundedRectImageViewWithCornerRadius:(CGFloat)cornerRadius
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    self.layer.mask = layer;
    
    return self;
}
@end

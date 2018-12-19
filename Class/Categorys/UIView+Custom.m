//
//  UIView+Custom.m
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/3/22.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "UIView+Custom.h"

@implementation UIView (Custom)
- (UIView *)createLineWithColor:(UIColor *)color frame:(CGRect)frame
{
    UIView *line = [[UIView alloc] initWithFrame:frame];
    [line setBackgroundColor:color];
    [self addSubview:line];
    return line;
}

- (void)setShadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius
{
//    self.layer.shadowPath = [[UIBezierPath bezierPathWithRect:self.bounds] CGPath];
    [self.layer setShadowColor:color.CGColor];
    [self.layer setShadowOffset:offset];
    [self.layer setShadowOpacity:opacity];
    [self.layer setShadowRadius:radius];
}

- (void)setCornerRadius:(CGFloat)radius
{
    if (radius > 0) {
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:radius];
    } else {
        [self.layer setMasksToBounds:NO];
        [self.layer setCornerRadius:radius];
    }
}

-(void)setDefaultShadow
{
    [self setShadowColor:LightGrayColor offset:CGSizeMake(0, 2) opacity:0.3 radius:2];
}

- (void)setBorderColor:(UIColor *)color width:(CGFloat)width
{
    [self.layer setBorderColor:color.CGColor];
    [self.layer setBorderWidth:width];
}

- (void)setScaleX:(CGFloat)sx scaleY:(CGFloat)sy
{
    CGAffineTransform currentTransform = self.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, sx, sy);
    [self setTransform:newTransform];
}

- (UIView *)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    return nil;
} 
@end

//
//  UIView+Frame.m
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/5/15.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setJb_size:(CGSize)jb_size
{
    CGRect frame = self.frame;
    frame.size = jb_size;
    self.frame = frame;
}

- (CGSize)jb_size
{
    return self.frame.size;
}

- (void)setJb_bottom:(CGFloat)jb_bottom
{
    //设置这个值一般是为了求y得坐标
    self.jb_y = jb_bottom -self.jb_height;
}

- (CGFloat)jb_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setJb_right:(CGFloat)jb_right
{
    //设置这个值,一般是为了求x得坐标
    self.jb_x = jb_right - self.jb_width;
}

- (CGFloat)jb_right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setJb_width:(CGFloat)jb_width
{
    CGRect frame = self.frame;
    frame.size.width = jb_width;
    self.frame = frame;
}

- (CGFloat)jb_width
{
    return self.frame.size.width;
}

- (void)setJb_height:(CGFloat)jb_height
{
    CGRect frame = self.frame;
    frame.size.height = jb_height;
    self.frame = frame;
}

- (CGFloat)jb_height
{
    return self.frame.size.height;
}

- (void)setJb_x:(CGFloat)jb_x
{
    CGRect frame = self.frame;
    frame.origin.x = jb_x;
    self.frame = frame;
}

- (CGFloat)jb_x
{
    return self.frame.origin.x;
}

- (void)setJb_y:(CGFloat)jb_y
{
    CGRect frame = self.frame;
    frame.origin.y = jb_y;
    self.frame = frame;
}

- (CGFloat)jb_y
{
    return self.frame.origin.y;
}

- (void)setJb_centerX:(CGFloat)jb_centerX
{
    CGPoint center = self.center;
    center.x = jb_centerX;
    self.center = center;
}

- (CGFloat)jb_centerX
{
    return self.center.x;
}

- (void)setJb_centerY:(CGFloat)jb_centerY
{
    CGPoint center = self.center;
    center.y = jb_centerY;
    self.center = center;
}

- (CGFloat)jb_centerY
{
    return self.center.y;
}

@end

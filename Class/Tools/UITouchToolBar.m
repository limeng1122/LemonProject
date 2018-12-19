//
//  UITouchToolBar.m
//  SchoolCool
//
//  Created by apple on 2017/2/24.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "UITouchToolBar.h"

@implementation UITouchToolBar

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (touches) {
        if (self.superview) {
            [self removeFromSuperview];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

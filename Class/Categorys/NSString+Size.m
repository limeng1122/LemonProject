//
//  NSString+Size.m
//  SchoolCool
//
//  Created by apple on 2017/2/24.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize textSize;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        textSize = [self sizeWithAttributes:attributes];
    } else {
        NSStringDrawingOptions option = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        CGRect rect = [self boundingRectWithSize:size
                                         options:option
                                      attributes:attributes
                                         context:nil];
        
        textSize = rect.size;
    }
    return textSize;
}

- (NSString *)substringFromAppiontStr:(NSString *)appointStr
{
    NSString  *  result;
    if ([self  rangeOfString:appointStr].length>=1) {
        NSRange range = [self  rangeOfString:appointStr];
        result = [self substringFromIndex:range.location];
        return result;
    }
    return nil;
}

@end

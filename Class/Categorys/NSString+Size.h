//
//  NSString+Size.h
//  SchoolCool
//
//  Created by apple on 2017/2/24.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)

- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 *  获取一个字符串指定字符后的字符串(包括指定字符)
 *
 *  @param appointStr 指定的某个字符（一个）
 *
 *  @return 该字符后的字符串（包含该字符）
 */
- (NSString *)substringFromAppiontStr:(NSString *)appointStr;
@end

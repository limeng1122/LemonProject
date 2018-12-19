//
//  NSDate+Format.h
//  SchoolCool
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Format)


/**
 按照某种格式格式化日期

 @param style 日期格式
 @return 格式化的日期
 */
- (NSString *)formatWithStyle:(NSString *)style;

//获得日期与当前时间的时间间隔描述
- (NSString *)getTimeIntervalDescSinceNow;

//清除日期的时分秒
- (NSDate *)clearTime;
@end

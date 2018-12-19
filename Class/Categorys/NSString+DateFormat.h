//
//  NSString+DateFormat.h
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/5/3.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DateFormat)
//将字符串转换为对应格式的NSDate对象
- (NSDate *)toDateWithFormat:(NSString *)formatType;

//获取改日期字符串与当前时间的间隔的描述
- (NSString *)getTimeIntervalDescSinceNow;

//将\(74989892813)格式的时间转换为对应格式的时间字符串
- (NSString *)formatLongTimeWithFormat:(NSString *)format;

//时间转换为NSDate
- (NSDate *)convertLongTimeToDate;
@end

//
//  NSDate+Format.m
//  SchoolCool
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "NSDate+Format.h"

@implementation NSDate (Format)
//按照某种格式格式化日期
- (NSString *)formatWithStyle:(NSString *)style
{
    if (!self) {
        return nil;
    }
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
    [dateFormate setDateFormat:style];
    NSTimeZone *GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [dateFormate setTimeZone:GTMzone];
    NSString *string = [dateFormate stringFromDate:self];
    return string;
}

//获得日期与当前时间的时间间隔
- (NSString *)getTimeIntervalDescSinceNow
{
    if (!self) {
        return nil;
    }
    NSTimeInterval timeInterval = [[Utils now] timeIntervalSinceDate:self];
    timeInterval = fabs(timeInterval);
    NSString *dateDesc = nil;
    if ((timeInterval / (365 * 24 * 60 * 60)) > 1||(timeInterval / (365 * 24 * 60 * 60)) == 1) {
        dateDesc = [NSString stringWithFormat:@"%.0lf年前", timeInterval / (365 * 24 * 60 * 60)];
    } else if ((timeInterval / (30 * 24 * 60 * 60)) > 1||(timeInterval / (30 * 24 * 60 * 60)) == 1) {
        dateDesc = [NSString stringWithFormat:@"%.0lf个月前", timeInterval / (30 * 24 * 60 * 60)];
    } else if ((timeInterval / (24 * 60 * 60)) > 1||(timeInterval / (24 * 60 * 60)) == 1) {
        dateDesc = [NSString stringWithFormat:@"%.0lf天前", timeInterval / (24 * 60 * 60)];
    } else if ((timeInterval / (60 * 60)) > 1||(timeInterval / (60 * 60)) == 1) {
        dateDesc = [NSString stringWithFormat:@"%.0lf小时前", timeInterval / (60 * 60)];
    } else if ((timeInterval / 60) > 1||(timeInterval / 60) == 1) {
        dateDesc = [NSString stringWithFormat:@"%.0lf分钟前", timeInterval / 60];
    } else if (timeInterval <= 5) {
        dateDesc = @"刚刚";
    } else {
        dateDesc = [NSString stringWithFormat:@"%.0lf秒前", timeInterval];
    }
    return dateDesc;
}

// 清除时分秒
- (NSDate *)clearTime
{
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
    NSTimeZone *GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [dateFormate setTimeZone:GTMzone];
    [dateFormate setDateFormat:DATEFORMAT_YYYY_MM_DD];
    NSString *dateDesc = [dateFormate stringFromDate:self];
    NSDate *goalDate = [dateFormate dateFromString:dateDesc];
    return goalDate;
}

@end

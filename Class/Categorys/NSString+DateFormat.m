//
//  NSString+DateFormat.m
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/5/3.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "NSString+DateFormat.h"

@implementation NSString (DateFormat)
- (NSDate *)toDateWithFormat:(NSString *)formatType
{
    if ([Utils isEmpty:self]) {
        return nil;
    }
    
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
    [dateFormate setDateFormat:formatType];
    [dateFormate setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *date = [dateFormate dateFromString:self];
    return date;
}

- (NSString *)getTimeIntervalDescSinceNow
{
    if ([Utils isEmpty:self]) {
        return @"";
    }
    NSString *timeDescription = nil;
    NSMutableString *timeValueString = [[NSMutableString alloc] initWithString:self];
    while (timeValueString.length > 10 && [timeValueString hasSuffix:@"0"]) {
        [timeValueString deleteCharactersInRange:NSMakeRange(timeValueString.length - 1, 1)];
    }
    NSTimeInterval targetTimeValue = [timeValueString doubleValue];
    
    NSTimeInterval currentTimeValue = [[NSDate date] timeIntervalSince1970];
    
    NSTimeInterval offsetTime = currentTimeValue - targetTimeValue;
    
    if (offsetTime < 60 * 60) {
        timeDescription = [NSString stringWithFormat:@"%.0f分钟前", offsetTime / 60 > 1 ? offsetTime / 60 : 1.0];
    } else if (offsetTime >= 60 * 60 && offsetTime < 24 * 60 * 60) {
        int hour = offsetTime / (60 * 60);
        timeDescription = [NSString stringWithFormat:@"%d小时前", hour];
    } else if (offsetTime >= 24 * 60 * 60 && offsetTime < 30 * 24 * 60 * 60) {
        int day = offsetTime / (24 * 60 * 60);
        timeDescription = [NSString stringWithFormat:@"%d天前", day];
    } else if (offsetTime >= 30 * 24 * 60 * 60 && offsetTime < 365 * 24 * 60 * 60) {
        int month = offsetTime / (30 * 24 * 60 * 60);
        timeDescription = [NSString stringWithFormat:@"%d月前", month];
    } else if (offsetTime >= 365 * 24 * 60 * 60) {
        int year = offsetTime / (365 * 24 * 60 * 60);
        timeDescription = [NSString stringWithFormat:@"%d年前", year];
    }
    return timeDescription;
}

- (NSString *)formatLongTimeWithFormat:(NSString *)format
{
    if ([Utils isEmpty:self]) {
        return @"";
    }
    
    NSTimeInterval timeInterval = [[self substringWithRange:NSMakeRange(6, 10)] longLongValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    date = [date dateByAddingTimeInterval:interval];
    
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
    [dateFormate setDateFormat:format];
    [dateFormate setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    return [dateFormate stringFromDate:date];
}

- (NSDate *)convertLongTimeToDate
{
    if ([Utils isEmpty:self]) {
        return nil;
    }
    
    NSTimeInterval timeInterval = [[self substringWithRange:NSMakeRange(6, 10)] longLongValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    return [date dateByAddingTimeInterval:interval];
    
}

@end

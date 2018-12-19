//
//  GetUserInfoResponse.m
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/3/15.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "GetUserInfoResponse.h"

@implementation GetUserInfoResponse

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation UserCenterInfo

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

- (NSString *)gradeDetailWithData:(NSNumber *)data
{
    NSArray *gradeArray = [GradeArrayString componentsSeparatedByString:@","];
    if (![data integerValue]) return @"";
    if (gradeArray.count < ([data integerValue] - 1)) return @"";
    return [gradeArray objectAtIndex:[data integerValue] - 1];
}

- (NSString *)emotionDetailWithData:(NSNumber *)data
{
    NSString *emotionStr;
    switch ([data integerValue]) {
        case 0:
            emotionStr = @"保密";
            break;
        case 1:
            emotionStr = @"单身";
            break;
        case 2:
            emotionStr = @"恋爱";
            break;
    }
    return emotionStr;
}

@end

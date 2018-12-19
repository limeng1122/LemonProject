//
//  URLHelper.m
//  SchoolCool
//
//  Created by apple on 2017/2/24.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "URLHelper.h"

static NSString *schoolCoolUrl = nil;

@implementation URLHelper

+ (void)setSchoolCoolUrl:(NSString *)url
{
    schoolCoolUrl = url;
}

+ (NSString *)getSchoolCoolUrl
{
    if([Utils isEmpty:schoolCoolUrl]){
        schoolCoolUrl = SchoolCoolTestURL;
    }

    return schoolCoolUrl;
}

+ (NSString *)getRequestURLWidthMethodName:(NSString *)methodName
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:schoolCoolUrl];
    [string appendString:methodName];
    if ([methodName isEqualToString:API_GET_DISCOVER_BANNER_LIST]) {
//        [string appendString:methodName];
        NSRange r2 = [string rangeOfString:@"api/v2/"];
        [string deleteCharactersInRange:r2];
    }
    return [string description];
}

@end

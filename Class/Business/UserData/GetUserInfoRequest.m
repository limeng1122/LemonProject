//
//  GetUserInfoRequest.m
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/3/15.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "GetUserInfoRequest.h"

@implementation GetUserInfoRequest

- (NSString *)getMethodName
{
    return API_USER_LOGIN;
}

- (BOOL)isCacheabled
{
    return NO;
}

@end

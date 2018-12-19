//
//  SchoolCoolAccountTools.m
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/3/21.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#define AccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#import "SchoolCoolAccountTools.h"
#import "SchoolCoolAccount.h"

@implementation SchoolCoolAccountTools
+ (void)save:(SchoolCoolAccount  *)account
{
    // 归档
    [NSKeyedArchiver archiveRootObject:account toFile:AccountFilepath];
}

+ (SchoolCoolAccount *)account
{
    // 读取帐号
    SchoolCoolAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountFilepath];
    
    // 判断帐号是否已经过期
    NSDate *now = [NSDate date];
    
    if ([now compare:account.expires_time] != NSOrderedAscending) { // 过期
        account = nil;
    }
    return account;
}
@end

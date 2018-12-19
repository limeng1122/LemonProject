//
//  GeneralDataCache.m
//  SchoolCool
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "GeneralDataCache.h"

@implementation GeneralDataCache
SYNTHESIZE_SINGLETON_FOR_CLASS(GeneralDataCache);
- (void)setUserID:(NSNumber *)userID
{
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:@"userID"];
}

- (NSNumber *)userID
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
}

- (void)setRegFrom:(NSString *)regFrom
{
    [[NSUserDefaults standardUserDefaults] setObject:regFrom forKey:@"regFrom"];
}

- (NSString *)regFrom
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"regFrom"];
}

- (void)setRykey:(NSString *)rykey
{
    [[NSUserDefaults standardUserDefaults] setObject:rykey forKey:@"ryKey"];
}

- (NSString *)rykey
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"ryKey"];
}

- (void)setAccountName:(NSString *)accountName
{
    [[NSUserDefaults standardUserDefaults] setObject:accountName forKey:@"accountName"];
}

- (NSString *)accountName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"accountName"];
}

- (void)setAuthTkn:(NSString *)authTkn
{
    [[NSUserDefaults standardUserDefaults] setObject:authTkn forKey:@"authTkn"];
    // 立即同步
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)authTkn
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"authTkn"];
}

- (void)setUserInfo:(UserCenterInfo *)userInfo
{
    if (!userInfo) {
        return;
    }
    
    _userCenterInfo = userInfo;
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[userInfo toDictionary] options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString *result = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (writeError) {
    }
    [[NSUserDefaults standardUserDefaults] setObject:result forKey:@"userInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (UserCenterInfo *)userCenterInfo
{
    if (!_userCenterInfo) {
        NSString *josn = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        NSDictionary *dic = [Utils parshJsonString:josn];
        NSError *writeError = nil;
        _userCenterInfo = [[UserCenterInfo alloc] initWithDictionary:dic error:&writeError];
        if(writeError){
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return _userCenterInfo;
}

- (void)reloadUserInfoFromCache
{
    NSString *josn = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSDictionary *dic = [Utils parshJsonString:josn];
    NSError *writeError = nil;
    _userCenterInfo = [[UserCenterInfo alloc] initWithDictionary:dic error:&writeError];
    if(writeError){
        NSLog(@"writeError:%@",writeError);
    }
    
}

- (void)clearUserInfo
{
    self.authTkn = nil;
//    self.login = nil;
}

@end

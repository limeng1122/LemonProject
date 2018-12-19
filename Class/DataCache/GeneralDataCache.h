//
//  GeneralDataCache.h
//  SchoolCool
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARCSingleTemplate.h"
#import "GetUserInfoResponse.h"

@interface GeneralDataCache : NSObject

SYNTHESIZE_SINGLETON_FOR_HEADER(GeneralDataCache);

@property (strong, nonatomic) NSString *authTkn;
@property (nonatomic, assign) BOOL login;

//@property (retain, nonatomic) GuideInfo *launchInfo;                            // 登录信息

@property (retain, nonatomic) UserCenterInfo *userCenterInfo;                   // 用户信息

- (void)setUserInfo:(UserCenterInfo *)userInfo;
//- (void)setUserLaunchInfo:(GuideInfo *)launchInfo;

/*
 * 重新从userdata中读取用户信息
 */
- (void)reloadUserInfoFromCache;

- (void)clearUserInfo;

@end

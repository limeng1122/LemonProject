//
//  GetUserInfoResponse.h
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/3/15.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "BaseResponseModel.h"

@interface UserCenterInfo : BaseResponseModel
@property (nonatomic, strong) NSNumber *myPointCount;         // 访客量
@property (nonatomic, strong) NSNumber *visitCount;         // 访客量
@property (nonatomic, strong) NSNumber *pointCount;         // 点赞量
@property (nonatomic, strong) NSString *account;            // 账号
@property (nonatomic, strong) NSString *avatar;             // 头像
@property (nonatomic, strong) NSString *createDate;         // 创建时间
@property (nonatomic, strong) NSNumber *emotion;            // 情感状态
@property (nonatomic, strong) NSNumber *fansNum;            // 粉丝数
@property (nonatomic, strong) NSNumber *followNum;          // 用户关注
@property (nonatomic, strong) NSNumber *grade;              // 年级
@property (nonatomic, strong) NSNumber *id;                 // 编号
@property (nonatomic, strong) NSString *label;              // 标签
@property (nonatomic, strong) NSString *signature;          // 个性签名
@property (nonatomic, strong) NSString *lastLoginTime;      // 上次登录时间
@property (nonatomic, strong) NSString *nickname;           // 昵称
@property (nonatomic, strong) NSString *os;                 // 系统标识
@property (nonatomic, strong) NSNumber *schoolId;           // 学校ID
@property (nonatomic, strong) NSString *schoolName;         // 学校名称
@property (nonatomic, strong) NSNumber *sex;                // 性别 0：男 1：女
@property (nonatomic, strong) NSString *star;               // 星座
@property (nonatomic, strong) NSString *updateDate;         // 更新时间
@property (nonatomic, strong) NSString *background;         // 个人背景图
@property (nonatomic, strong) NSNumber *userId;             // 用户编号
@property (nonatomic, strong) NSString *fletter;            // 昵称首字母
@property (nonatomic, strong) NSString *clinetID;           // 用户推送标识
@property (nonatomic, strong) NSNumber *friendSign;         // 好友标识 0：非好友 1：好友 2：黑名单
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *rykey;              // 融云key
@property (nonatomic, strong) NSString *regFrom;            // 注册来源 游客 "visitor";后台开通 "adminReg";
@property (nonatomic, strong) NSString *remark;            // 备注
@property (nonatomic, strong) NSString *major;            // 专业
@property (nonatomic, strong) NSString *userType;            // 用户类型:(运营:operate) 新增解决匹配聊天两个人
@property (nonatomic, strong) NSNumber *leaguerType;               // 用户会员类型 0:普通用户1:会员用 2:超级用户
@property (nonatomic, assign) BOOL authentication;//用户认证 true认证 false 未认证

- (NSString *)gradeDetailWithData:(NSNumber *)data;
- (NSString *)emotionDetailWithData:(NSNumber *)data;

@end

@interface GetUserInfoResponse : BaseResponseModel

@property (nonatomic, strong) UserCenterInfo *entity;

@end

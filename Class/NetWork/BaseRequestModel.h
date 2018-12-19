//
//  BaseRequestModel.h
//  SchoolCool
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "API.h"

@interface BaseRequestModel : JSONModel

@property (nonatomic, assign) NSInteger retriesCount; //重试次数
//基本参数
@property (nonatomic, copy) NSString *processTime; //请求时间
@property (nonatomic, strong) NSString *os;     //平台号 0 IOS 1 Android
@property (nonatomic, copy) NSString *imei;    //设备号码
@property (nonatomic, copy) NSString *token;     //token


- (instancetype)init;

- (NSString *)getRequestURL;

- (NSString *)getMethodName;

@end

//
//  SchoolCoolAccountTools.h
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/3/21.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SchoolCoolAccount;

@interface SchoolCoolAccountTools : NSObject

/**
 *  存储帐号
 */
+ (void)save:(SchoolCoolAccount *)account;

/**
 *  读取帐号
 */
+ (SchoolCoolAccount *)account;

@end

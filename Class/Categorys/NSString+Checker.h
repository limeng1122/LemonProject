//
//  NSString+Checker.h
//  SchoolCool
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Checker)

//是否为nil或空
- (BOOL)isEmptyString;

//trim
- (NSString *)trim;

//是否全是数字
- (BOOL)isNumber;

//是否是电子邮件地址
- (BOOL)isEmail;

//是否是手机号码
- (BOOL)isPhoneNumber;

//是否只包含英文字符和数字
- (BOOL)isOnlyEnCharAndNumber;

//是否全是中文字符
- (BOOL)isAllChineseChar;


@end

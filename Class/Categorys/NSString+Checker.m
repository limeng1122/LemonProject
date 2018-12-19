//
//  NSString+Checker.m
//  SchoolCool
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "NSString+Checker.h"

@implementation NSString (Checker)

- (BOOL)isEmptyString
{
    if ([self isKindOfClass:[NSNull class]] || self.length == 0) {
        return YES;
    }
    if ([[self trim] length]==0) {
        return YES;
    }
    return NO;
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (BOOL)isPhoneNumber
{
    NSString *phoneNumRegex = @"(\\+\\d+)?1[345678]\\d{9}$";
    NSPredicate *phoneNumTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", phoneNumRegex];
    return [phoneNumTest evaluateWithObject:self];
}

- (BOOL)isNumber
{
    NSString *regex = @"^\\d+$";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    return [numTest evaluateWithObject:self];
}

- (BOOL)isEmail
{
    if (!self) {
        return NO;
    }
    NSString *regex = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    return [test evaluateWithObject:self];
}

- (BOOL)isOnlyEnCharAndNumber
{
    if ([Utils isEmpty:self]) {
        return NO;
    }
    
    NSString *regex = @"^[A-Za-z0-9]+$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    return [test evaluateWithObject:self];
}

- (BOOL)isAllChineseChar
{
    if (!self) {
        return NO;
    }
    
    NSString *regex = @"[\\u4e00-\\u9fa5]+";
    NSPredicate *phoneNumTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    BOOL isValid = YES;
    for (int i = 0; i < self.length; i++) {
        NSString *subString = [self substringWithRange:NSMakeRange(i, 1)];
        isValid = [phoneNumTest evaluateWithObject:subString];
        if (!isValid) {
            isValid = NO;
            break;
        }
    }
    return isValid;
}
@end

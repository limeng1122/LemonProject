//
//  Logger.h
//  SchoolCool
//
//  Created by apple on 2017/2/24.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Logger : NSObject

+(void)log:(NSString*)string;

+(void)log:(NSString*)tag string:(NSString*)value;
//截取字符串，最大1024
+(void)log:(NSString*)tag shortString:(NSString*)value;

+(void)log:(NSString*)tag integer:(NSInteger)value;

+(void)log:(NSString*)tag float:(float)value;

@end

//
//  URLHelper.h
//  SchoolCool
//
//  Created by apple on 2017/2/24.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLHelper : NSObject

+ (NSString *)getRequestURLWidthMethodName:(NSString *)methodName;

+ (void)setSchoolCoolUrl:(NSString *)url;

+ (NSString *)getSchoolCoolUrl;


@end

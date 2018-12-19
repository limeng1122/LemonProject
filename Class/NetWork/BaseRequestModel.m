//
//  BaseRequestModel.m
//  SchoolCool
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "BaseRequestModel.h"
#import "NSDate+Format.h"
#import "GeneralDataCache.h"
#import "Utils.h"
#import "URLHelper.h"
#import <AdSupport/ASIdentifierManager.h>

@implementation BaseRequestModel

+ (BOOL)propertyIsIgnored:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"retriesCount"]) {
        return YES;
    }
    return NO;
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _processTime = [[Utils now] formatWithStyle:DATEFORMAT_YMD_HMS];
        _os = @"ios";
        
        NSString *uuid=[[NSUserDefaults standardUserDefaults]objectForKey:@"imei"];
        if (uuid.length>0) {
            _imei=uuid;
        }
        else{
            _imei = DeviceUUID;
            if ([NSString stringWithFormat:@"%@",_imei].length==0) {
                NSString *identifierForAdvertising = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
                _imei = identifierForAdvertising;
            }
        }
        
        _token = [GeneralDataCache sharedGeneralDataCache].authTkn;
        _retriesCount = 0;
    }
    
    return self;
}

- (NSString *)getRequestURL
{
    NSString *URL = [URLHelper getRequestURLWidthMethodName:[self getMethodName]];
    return URL;
}

- (NSString *)getMethodName
{
    return @"";
}

@end

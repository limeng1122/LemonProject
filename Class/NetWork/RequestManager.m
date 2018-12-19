
//
//  RequestManager.m
//  MiuTrip
//
//  Created by apple on 13-11-27.
//  Copyright (c) 2013年 michael. All rights reserved.
//

#import "RequestManager.h"
#import "AppDelegate.h"
#import "HttpErrorMacro.h"
#import "ViewHelper.h"
#import "NSString+Checker.h"
#import "AFNetworkReachabilityManager.h"
#import "AFHTTPSessionManager.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "Logger.h"
#import "GeneralDataCache.h"

static const NSInteger MAX_RETRIES_COUNT = 1;   //接口失败后最大重试次数，默认重试一次

@interface RequestManager ()
{
    BOOL        _hasPushLoginVC;
    NSString    *_carrierName;
}

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSString    *networkType;
@end


@implementation RequestManager


SYNTHESIZE_SINGLETON_FOR_CLASS(RequestManager);

- (id)init
{
    self = [super init];
    if (self) {
        LXWS(weakSelf);
        _hasPushLoginVC = NO;
        self.manager = [[AFHTTPSessionManager manager]initWithBaseURL:[NSURL URLWithString:SchoolCoolURL]];
        self.manager.responseSerializer = [AFHTTPResponseSerializer new];
        self.manager.requestSerializer.timeoutInterval = 60.0f;
        self.manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"POST", @"GET", @"HEAD"]];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    weakSelf.networkType = @"Unknown";
//                    if ([self currentViewController]) {
//                        [[NSNotificationCenter defaultCenter]postNotificationName:@"RefreshIndexGetData" object:nil userInfo:nil];
//                    }
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    weakSelf.networkType = @"NoNetwork";
//                    [[NSUserDefaults standardUserDefaults]setValue:@"0" forKey:@"isFirst"];
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    weakSelf.networkType = @"WWAN";
                    
//                    if ([self currentViewController]) {
//                        [[NSNotificationCenter defaultCenter]postNotificationName:@"RefreshIndexGetData" object:nil userInfo:nil];
//                    }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    weakSelf.networkType = @"WIFI";
//                    if ([self currentViewController]) {
//                        [[NSNotificationCenter defaultCenter]postNotificationName:@"RefreshIndexGetData" object:nil userInfo:nil];
//                    }
                    break;
                default:
                    weakSelf.networkType = @"Unknown";
                    
//                    if ([self currentViewController]) {
//                        [[NSNotificationCenter defaultCenter]postNotificationName:@"RefreshIndexGetData" object:nil userInfo:nil];
//                    }
                    break;
            }
        }];
        [self getCarrierName];
    }
    return self;
}

-(void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

-(void)getCarrierName{
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    NSString *currentCountry= [carrier carrierName];
    _carrierName = currentCountry;
}

- (void)sendRequest:(BaseRequestModel *)request successed:(RequestSuccessedHandler)successedHandler failed:(RequestFailedHandler)failedHandler
{
    if (request == nil) {
        return;
    }
    if (![RequestManager isNetWorkReachable]) {
        if (failedHandler) {
            failedHandler(CODE_NO_NETWORK, MSG_NO_NETWORK);
        };
        return;
    }
    NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
    NSString *URLString = [request getRequestURL];
    NSDictionary *jsonDictionary = [request toDictionary];
    
    NSMutableDictionary *currentDic=[[NSMutableDictionary alloc]initWithDictionary:jsonDictionary];
    currentDic[@"token"] = [GeneralDataCache sharedGeneralDataCache].authTkn;
//    NSString *jsonString = [request toJSONString];
//    NSDictionary *body = [[NSDictionary alloc] initWithObjectsAndKeys:jsonString,@"Json", nil];

    /*
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    policy.allowInvalidCertificates = YES;
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO
    //主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    policy.validatesDomainName = NO;
    //validatesCertificateChain 是否验证整个证书链，默认为YES
    //设置为YES，会将服务器返回的Trust Object上的证书链与本地导入的证书进行对比，这就意味着，假如你的证书链是这样的：
    //那么，除了导入*.google.com之外，还需要导入证书链上所有的CA证书（GeoTrust Global CA, Google Internet Authority G2）；
    //如是自建证书的时候，可以设置为YES，增强安全性；假如是信任的CA所签发的证书，则建议关闭该验证；
    */
//
    AFSecurityPolicy * policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    [policy setAllowInvalidCertificates:YES];
    [policy setValidatesDomainName:NO];
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"tongquwangluo" ofType:@"cer"];
    NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
    NSSet *set = [NSSet setWithObject:cerData];
    policy.pinnedCertificates = set;
    self.manager.securityPolicy = policy;

    [self.manager POST:URLString parameters:currentDic progress:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970] - startTime;
        NSData *data = (NSData *)responseObject;
//        NSString *json = [[NSString alloc] initWithData:data encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
        
        NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [Logger log:URLString shortString:json];
        [Logger log:URLString string:[NSString stringWithFormat:@"interface_loading_time:%f",time]];
        [self handleResponseWithData:json withRequest:request successed:successedHandler failed:failedHandler];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [Logger log:URLString string:[error description]];
//        [MobClick event:@"connect_error" label:[NSString stringWithFormat:@"business:%@,errorCode:%d,errorMags:%@,carrier:%@,type:%@",URLString,(int)error.code,error.domain,_carrierName,_networkType]];
        
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970] - startTime;
        if(time > 20){
            if (failedHandler) {
                failedHandler(CODE_CAN_NOT_CONNECT, MSG_CAN_NOT_CONNECT);
            }
            return;
        }
        //重试
        if(request.retriesCount < MAX_RETRIES_COUNT){
            [self sendRequest:request successed:successedHandler failed:failedHandler];
            request.retriesCount ++;
        }else{
            if (failedHandler) {
                failedHandler(CODE_CAN_NOT_CONNECT, MSG_CAN_NOT_CONNECT);
            }
        }
    }];
}

- (void)sendGetRequest:(BaseRequestModel *)request successed:(RequestSuccessedHandler)successedHandler failed:(RequestFailedHandler)failedHandler{
    if (request == nil) {
        return;
    }
    if (![RequestManager isNetWorkReachable]) {
        if (failedHandler) {
            failedHandler(CODE_NO_NETWORK, MSG_NO_NETWORK);
        };
        return;
    }
    NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
    NSString *URLString = [request getRequestURL];
    NSDictionary *jsonDictionary = [request toDictionary];
    
    NSMutableDictionary *currentDic=[[NSMutableDictionary alloc]initWithDictionary:jsonDictionary];
    currentDic[@"token"] = [GeneralDataCache sharedGeneralDataCache].authTkn;
    //    NSString *jsonString = [request toJSONString];
    //    NSDictionary *body = [[NSDictionary alloc] initWithObjectsAndKeys:jsonString,@"Json", nil];
    
    /*
     //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
     //如果是需要验证自建证书，需要设置为YES
     policy.allowInvalidCertificates = YES;
     //validatesDomainName 是否需要验证域名，默认为YES；
     //假如证书的域名与你请求的域名不一致，需把该项设置为NO
     //主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
     policy.validatesDomainName = NO;
     //validatesCertificateChain 是否验证整个证书链，默认为YES
     //设置为YES，会将服务器返回的Trust Object上的证书链与本地导入的证书进行对比，这就意味着，假如你的证书链是这样的：
     //那么，除了导入*.google.com之外，还需要导入证书链上所有的CA证书（GeoTrust Global CA, Google Internet Authority G2）；
     //如是自建证书的时候，可以设置为YES，增强安全性；假如是信任的CA所签发的证书，则建议关闭该验证；
     */
    //
    AFSecurityPolicy * policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    [policy setAllowInvalidCertificates:YES];
    [policy setValidatesDomainName:NO];
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"tongquwangluo" ofType:@"cer"];
    NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
    NSSet *set = [NSSet setWithObject:cerData];
    policy.pinnedCertificates = set;
    self.manager.securityPolicy = policy;
    
    [self.manager GET:URLString parameters:currentDic progress:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970] - startTime;
        NSData *data = (NSData *)responseObject;
        //        NSString *json = [[NSString alloc] initWithData:data encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
        
        NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [Logger log:URLString shortString:json];
        [Logger log:URLString string:[NSString stringWithFormat:@"interface_loading_time:%f",time]];
        [self handleResponseWithData:json withRequest:request successed:successedHandler failed:failedHandler];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [Logger log:URLString string:[error description]];

        NSTimeInterval time = [[NSDate date] timeIntervalSince1970] - startTime;
        if(time > 20){
            if (failedHandler) {
                failedHandler(CODE_CAN_NOT_CONNECT, MSG_CAN_NOT_CONNECT);
            }
            return;
        }
        //重试
        if(request.retriesCount < MAX_RETRIES_COUNT){
            [self sendRequest:request successed:successedHandler failed:failedHandler];
            request.retriesCount ++;
        }else{
            if (failedHandler) {
                failedHandler(CODE_CAN_NOT_CONNECT, MSG_CAN_NOT_CONNECT);
            }
        }
    }];
}

- (void)handleResponseWithData:(NSString *)json withRequest:(BaseRequestModel *)request successed:(RequestSuccessedHandler)successedHandler failed:(RequestFailedHandler)failedHandler
{
    NSDictionary *data = [Utils parshJsonString:json];
    BOOL SuccessCode = [[data  objectForKey:@"success"] boolValue];
    if (!SuccessCode) {
        int code = 1;
        NSNumber *value = [data objectForKey:@"code"];
        if (value && ![value isKindOfClass:[NSNull class]]) {
            code = [value intValue];
        }
        NSString *errorMsg = [data objectForKey:@"message"];
        failedHandler(code, errorMsg);
        return;
    }
    
    BaseResponseModel *response = [self getResponseFromRequest:request withData:data];
    if (!response) {
        failedHandler(CODE_CAN_NOT_FOUND_RESPONSE, MSG_CAN_NOT_FOUND_RESPONSE);
        return;
    }
    successedHandler(response);
}

- (BaseResponseModel *)getResponseFromRequest:(JSONModel *)request withData:(NSDictionary *)data
{
    if (request == nil || data == nil) {
        return nil;
    }

    NSString *requestClassName = [NSString stringWithUTF8String:object_getClassName(request)];
    if (!requestClassName) {
        return nil;
    }
    if ([requestClassName hasSuffix:@"Request"]) {
        //替换字符串生成对应的RESPONSE类名称
        NSString *responseClassName = [requestClassName stringByReplacingOccurrencesOfString:@"Request" withString:@"Response"];
        //反射出对应的类
        Class responseClass = NSClassFromString(responseClassName);
        //没找到该类，或出错
        if (!responseClass) {
            return nil;
        }
        //生成对应的对象并返回
        NSError *error;
        
        BaseResponseModel *response = [[responseClass alloc] initWithDictionary:data error:&error];
        
        if (error) {
            [Logger log:@"error" string:[error description]];
            return nil;
        }
        return response;
    }

    return nil;
}
//
//-(int)currentViewController{
//
//    // Find best view controller
//    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
//    UIViewController * viewControllerNow = [self findBestViewController:viewController];
//    if ([viewControllerNow  isKindOfClass:[IndexViewController class]]) {
//
//        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"isFirst"]) {
//            return 1;
//        }
//        else{
//            return 0;
//        }
//    }
//    else
//        return 0;
//}
//
//-(UIViewController*)findBestViewController:(UIViewController*)vc {
//
//    if (vc.presentedViewController) {
//
//        // Return presented view controller
//        return [self findBestViewController:vc.presentedViewController];
//
//    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
//
//        // Return right hand side
//        UISplitViewController* svc = (UISplitViewController*) vc;
//        if (svc.viewControllers.count > 0)
//            return [self findBestViewController:svc.viewControllers.lastObject];
//        else
//            return vc;
//
//    } else if ([vc isKindOfClass:[UINavigationController class]]) {
//
//        // Return top view
//        UINavigationController* svc = (UINavigationController*) vc;
//        if (svc.viewControllers.count > 0)
//            return [self findBestViewController:svc.topViewController];
//        else
//            return vc;
//
//    } else if ([vc isKindOfClass:[UITabBarController class]]) {
//        UITabBarController* svc = (UITabBarController*) vc;
//        if (svc.viewControllers.count > 0)
//            return [self findBestViewController:svc.selectedViewController];
//        else
//            return vc;
//    } else {
//        return vc;
//    }
//}

#pragma mark - 网络状态是否可用；
+ (BOOL)isNetWorkReachable
{
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus != AFNetworkReachabilityStatusNotReachable;
}

@end

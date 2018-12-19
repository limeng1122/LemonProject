//
//  Macro.h
//  SchoolCool
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define DeviceUUID [[UIDevice currentDevice].identifierForVendor UUIDString]


const static CGFloat iPhone5Width = 320;
const static CGFloat iPhone6Width = 375;
const static CGFloat iPhone6PlusWidth = 414;

typedef NS_ENUM(NSInteger, ActivityType) {
    ActivityTypeAll = 0,
    ActivityTypeAsk = 1,
    ActivityTypeTeam = 2,
    ActivityTypeShare = 3,
    ActivityTypeGroup = 4,
    ActivityTypeQuestion = 5,
};

#define SchoolCoolURL @"https://www.tongquwangluo.com"

//// 测试配置
//#define SchoolCoolIsPro NO
//#define SchoolCoolTestURL @"http://47.93.89.159/api/"                  // 测试
//#define SchoolCoolTestShareURL @"http://47.93.89.159"                  // 分享测试
////#define SchoolCoolTestURL @"http://169.254.149.208:82/api/"                  // 测试
////#define SchoolCoolTestShareURL @"169.254.149.208:82"                  // 分享测试
//#define SchoolCoolRCIMAppKey @"8brlm7ufrryj3"                          // 融云开发key
//#define SchoolCoolViderConfig @"f-test"                         // 阿里云视频测试地址

// 生产配置
#define SchoolCoolIsPro YES
#define SchoolCoolTestURL @"https://www.tongquwangluo.com/api/"          // 发布 推送配置
#define SchoolCoolTestShareURL @"https://www.tongquwangluo.com"          // 分享发布
#define SchoolCoolRCIMAppKey @"lmxuhwagxxocd"                            // 融云生产key
#define SchoolCoolViderConfig @"s-videos-prod"

#define SchoolCoolQQAppID @"1106835129"
#define SchoolCoolQQAppKey @"NLml44jc48c7FRxH"
#define SchoolCoolWeiboAppKey @"1806919833"
#define SchoolCoolWeiboAppScheme @"wb1806919833"
#define SchoolCoolWeiboAppSecret @"b155a4e13c84a1bbb6010d8953074535"
#define SchoolCoolWeiboRedirectURI @"http://sns.whalecloud.com/sina2/callback"
#define SchoolCoolWechatAppID @"wx0bcbcb1f08ff744e"
#define SchoolCoolWechatAppSecret @"304d73f75ac5089b2eaa2a7c7477642d"

//#define SchoolCoolAliYunKey @"jn6nkwvce3ix52us9hx395u92poh6bhsdgyruaf84hd4a8t5qasvghcoz2ptshsw"
#define SchoolCoolAliYunKeyId @"k5LEZbHJZZN8JGus"
#define SchoolCoolAliYunKeySecret @"PSLsFGaytfuHDFq5DuDc1iyl6ggzxQ"

#define SchoolCoolPushKEY @"09595a8c5fb73508d0c9ab87"

#define SchoolCoolUMAPPKEY @"5816dd1a7f2c744618000731"

#define DefaultAnimationDuration 0.25
#define GlobalContentSpacing 8

#define DefaultLineHeight 0.5

#define deviceVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define isGreatThanIOS9       [[UIDevice currentDevice].systemVersion doubleValue]>=9.0

//#define avatarImg       @"avatarImage"
#define launchImg       @"launchImage"
#define CommentUserKey  @"CommentUserKey"
#define CommentTextKey  @"CommentTextKey"

#define  AdjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)

//接口请求成功代码
#define CODE_REQUEST_SUCCEED 666666

//获取某控件最大值
#define UIControlXLength(control) CGRectGetMaxX(control.frame)
#define UIControlYLength(control) CGRectGetMaxY(control.frame)

#define UIViewOriginX(control) (control.frame.origin.x)
#define UIViewOriginY(control) (control.frame.origin.y)

#define UIViewWidth(view) CGRectGetWidth(view.frame)
#define UIViewHeight(view) CGRectGetHeight(view.frame)

#define LXWS(weakSelf)  __weak __typeof(&*self)weakSelf = self

// 屏幕高度
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
// 屏幕宽度
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

#define appFrame [[UIScreen mainScreen] bounds]

//判断是否是iphoneX
//#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

//判断iPhoneX序列（iPhoneX，iPhoneXs，iPhoneXs Max）
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXr
#define IsiPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size) && !isPad: NO)

//导航栏高度
//#define iNavgationH [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height
#define iNavgationH iNavgationHFit(IS_IPHONE_X,IsiPhoneXr)

static inline float iNavgationHFit(BOOL is_x,BOOL is_xr)
{
    if (is_x||is_xr) {
        return 88;
    }
    return 64;
}

#define iNavgationSub iNavgationSubFit(IS_IPHONE_X,IsiPhoneXr)

static inline float iNavgationSubFit(BOOL is_x,BOOL is_xr)
{
    if (is_x||is_xr) {
        return 25;
    }
    return 0;
}

#define iphoneTabbarH iNavgationTFit(IS_IPHONE_X,IsiPhoneXr)
#define iphoneXTabbarH 83
static inline float iNavgationTFit(BOOL is_x,BOOL is_xr)
{
    if (is_x||is_xr) {
        return 83;
    }
    return 49;
}

#define kDevice_Is_iPhoneX isIPhoneXSeries(IS_IPHONE_X,IsiPhoneXr)

static inline BOOL isIPhoneXSeries(BOOL is_x,BOOL is_xr) {
    if (is_x||is_xr) {
        return YES;
    }
    return NO;
}

#define iNavgationTag 20

//#define PATH_Y_ADJUST_os7 (deviceVersion >= 7.0 ? 0.0 : 20.0)
//少状态栏的20
// [[UIScreen mainScreen] applicationFrame]

// 颜色macro
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0  \
                                    green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0    \
                                    blue:((float)(rgbValue & 0xFF)) / 255.0             \
                                    alpha:1.0]
// 颜色+透明度
#define UIColorAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define UIColorRandom [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];

#define LightBlueColor2 [UIColor colorWithRed:0.0 green:122.0 / 255.0 blue:1.0 alpha:0.1]
#define LightBlueColor UIColorFromRGB(0x03A9F4)
#define BlueColor UIColorFromRGB(0x1da1f2)
#define DarkBlueColor [UIColor colorWithRed:0.0 green:122.0 / 255.0 blue:1.0 alpha:1.0]
#define GreenColor [UIColor colorWithRed:65.0 / 255.0 green:205.0 / 255.0 blue:0.0 / 255.0 alpha:1] 
#define OrangeColor [UIColor colorWithRed:255.0 / 255.0 green:160.0 / 255.0 blue:145.0 / 255.0 alpha:1]
#define LightOrangeColor [UIColor colorWithRed:255.0 / 255.0 green:105.0 / 255.0 blue:30.0 / 255.0 alpha:1]
#define YellowColor [UIColor colorWithRed:250.0 / 255.0 green:200.0 / 255.0 blue:0.0 / 255.0 alpha:1]
#define LightYellowColor [UIColor colorWithRed:253.0 / 255.0 green:243.0 / 255.0 blue:192 / 255.0 alpha:1]
#define TopBarColor UIColorFromRGB(0x0672e9)

#define RedColor UIColorFromRGB(0xF44336)
#define LightRedColor UIColorFromRGB(0xEF5350)
#define GrayBGColor UIColorFromRGB(0xEfEff4)
#define BlackColor UIColorFromRGB(0x14171a)
#define WhiteColor UIColorFromRGB(0xffffff)
#define LightGrayColor UIColorFromRGB(0xCCCCCC)
#define GrayColor UIColorFromRGB(0x999999)
#define DarkGrayColor UIColorFromRGB(0x657786)
#define LightBlackColor UIColorFromRGB(0x333333)
#define ColorBgE UIColorFromRGB(0xEEEEEE)
#define LineColor UIColorFromRGB(0xCCCCCC)
#define ClearColor [UIColor clearColor]
#define HeaderFooterViewColor UIColorFromRGB(0xEFEFF4)
#define BluishGrey UIColorFromRGB(0x808f9b)
#define FateColor UIColorFromRGB(0x76A0FF)
#define ViewBgColor UIColorFromRGB(0xe6ecf0)

#define GradientColorArray @[UIColorFromRGB(0xFF1857),UIColorFromRGB(0xE320DC),UIColorFromRGB(0x5E2FF9)]

// 字体
#define SmallFont [UIFont systemFontOfSize:14.0f]
#define BoldSmallFont [UIFont boldSystemFontOfSize:14]

#define QuestionFont [UIFont systemFontOfSize:15.0f]

#define MediumFont [UIFont systemFontOfSize:16.0f]
#define BoldMediumFont [UIFont boldSystemFontOfSize:16.0f]

#define BigFont [UIFont systemFontOfSize:18.0f]
#define BoldBigFont [UIFont boldSystemFontOfSize:18.0f]

//时间格式化
#define DATEFORMAT_YYYY_MM_DD @"yyyy-MM-dd"
#define DATEFORMAT_YMD_CHINESE @"yyyy年MM月dd日"
#define DATEFORMAT_YM_CHINESE @"yyyy年MM月"
#define DATEFORMAT_YMD_HMS @"yyyy-MM-dd HH:mm:ss"
#define DATEFORMAT_YMD_HMS_SITCOM @"yyyyMMddHHmmss"
#define DATEFORMAT_YMD_HM @"yyyy-MM-dd HH:mm"
#define DATEFORMAT_YMD_H @"yyyy-MM-dd HH"
#define DATEFORMAT_YMD_M_H @"yyyy-MM-dd"
#define DATEFORMAT_MD @"MM-dd"
#define DATEFORMAT_MD_CHINESE @"MM月dd日"
#define DATEFORMAT_MD_CHINESE_YMD @"yyyy年MM月dd日 HH:mm"

#define DATEFORMAT_MD_HM_CHINESE @"MM月dd日 HH:mm"
#define DATEFORMAT_MD_HM @"MM-dd HH:mm"
#define DATEFORMAT_HM @"HH:mm"
#define DATEFORMAT_HM_CHINESE @"HH小时mm分"
#define DATEFORMAT_MD_WEEK @"MM月dd日 EEEE"
#define DATEFORMAT_MD_WEEK_SHORT @"M月d日 EEEE"
#define DATEFORMAT_YYYY_MM @"yyyy-MM"
#define DATEFORMAT_YMD_HMS_ZZZ @"yyyy-MM-dd'T'HHmmssZZZ"
#define DATEFORMAT_MD_TODAY_CHINESE @"M月d日 今天"
#define DATEFORMAT_MMDD_TODAY_CHINESE @"MM月dd日 今天"
#define DATEFORMAT_MMDD_YESTERDAY_CHINESE @"MM月dd日 昨天"
#define DATEFORMAT_MMDD_TOMORROW_CHINESE @"MM月dd日 明天"

// 刷新提示
#define RefreshHintTextForLeftPull @"左拉刷新..."
#define RefreshHintTextForLeftRelease @"松开刷新数据..."
#define RefreshHintTextForLeftReleaseDone @"正在载入..."

#define GradeArrayString @"大一,大二,大三,大四,研一,研二,研三,博士,毕业"
#define StarArrayString @"白羊座,金牛座,双子座,巨蟹座,狮子座,处女座,天秤座,天蝎座,射手座,摩羯座,水瓶座,双鱼座"
#define StarArrayDetailString @"白羊座  （3月21日-4月19日）,金牛座 （4月20日-5月20日）,双子座 （5月21日-6月21日）,巨蟹座 （6月22日-7月22日）,狮子座 （7月23日-8月22日）,处女座 （8月23日-9月22日）,天秤座 （9月23日-10月23日）,天蝎座 （10月24日-11月22日）,射手座 （11月23日-12月21日）,摩羯座 （12月22日-1月19日）,水瓶座 （1月20日-2月18日）,双鱼座 （2月19日-3月20日）"

#define ScrollViewTag 2

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

/**
 *  全局默认图片
 */

#define GlobalDefaultAvatarImage_70 [UIImage imageNamed:@"icon_avatar_70"]
#define GlobalDefaultAvatarImage_100 [UIImage imageNamed:@"icon_avatar_100"]


#define PAN_DISTANCE 120
#define CARD_WIDTH lengthFit(333)
#define CARD_HEIGHT lengthFit(400)
#define iPhone5AndEarlyDevice (([[UIScreen mainScreen] bounds].size.height*[[UIScreen mainScreen] bounds].size.width <= 320*568)?YES:NO)
#define Iphone6 (([[UIScreen mainScreen] bounds].size.height*[[UIScreen mainScreen] bounds].size.width <= 375*667)?YES:NO)
#define IOS7  [[[UIDevice currentDevice] systemVersion] floatValue]

static inline float lengthFit(float iphone6PlusLength)
{
    if (iPhone5AndEarlyDevice) {
        return iphone6PlusLength *320.0f/414.0f;
    }
    if (Iphone6) {
        return iphone6PlusLength *375.0f/414.0f;
    }
    return iphone6PlusLength;
}

#endif /* Macro_h */

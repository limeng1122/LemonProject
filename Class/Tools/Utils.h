//
//  Utils.h
//  SchoolCool
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

// 获取现在的时间
+ (NSDate *)now;

//是否为空
+ (BOOL)isEmpty:(NSObject *)object;

//将json字符串转为对象
+ (id)parshJsonString:(NSString *)json;


/** 保存图片到本地 */
+ (void)saveImage: (UIImage*)image Name:(NSString *)name;

/** 从本地获取图片 */
+ (UIImage*)loadImageWithName:(NSString *)name;

//判断字符串是否为浮点数
+ (BOOL)isPureFloat:(NSString*)string;

//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string;

+ (NSArray *)getLinesArrayOfStringInLabel:(UILabel *)label;

//获取高度
+(CGFloat)strReturnHeight:(UILabel *)label strWidth:(CGFloat)strWidth;
+(CGFloat)strReturnHeight:(NSString *)strContent fonSize:(CGFloat)fonSize strWidth:(CGFloat)strWidth;
//获取宽度
+(CGFloat)sizeFixWidth:(NSString *)text maxWidth:(CGFloat)maxWidth fonSize:(CGFloat)fonSize;
+(CGFloat)sizeFixLabel:(UILabel *)label maxWidth:(CGFloat)maxWidth;
    
//压缩图片到指定大小
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;

+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage;

//获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)URL;

+(UIImage *)thumbnailWithImageWithoutScale:(UIImage *)originalImage size:(CGSize)size;

+ (void)replacePasteboardText;
@end

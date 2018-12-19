//
//  UIImage+JBImage.h
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/6/6.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JBImage)
/**
 *  修改图片size
 *
 *  @param image      原图片
 *  @param targetSize 要修改的size
 *
 *  @return 修改后的图片
 */
+ (UIImage *)image:(UIImage *)image byScalingToSize:(CGSize)targetSize;

/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
+ (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;

////切割图片
//+ (UIImage *)cutImage:(UIImage*)image;

//图片压缩并且转成base64字符串
+ (NSString *) image2DataURL: (UIImage *) image;

//图片压缩
+(UIImage *)compress:(UIImage *)oriImage;

//转base64 所需
+ (BOOL)imageHasAlpha:(UIImage *) image;
@end

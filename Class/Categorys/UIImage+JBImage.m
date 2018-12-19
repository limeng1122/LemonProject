//
//  UIImage+JBImage.m
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/6/6.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "UIImage+JBImage.h"

@implementation UIImage (JBImage)

/**
 *  修改图片size
 *
 *  @param image      原图片
 *  @param targetSize 要修改的size
 *
 *  @return 修改后的图片
 */
+ (UIImage *)image:(UIImage *)image byScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
+ (UIImage*)GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

//+ (UIImage *)cutImage:(UIImage*)image
//{
//    CGSize newSize;
//    CGImageRef imageRef = nil;
//
//    if ((image.size.width / image.size.height) < (390 / 272.32)) {
//        newSize.width = image.size.width;
//        newSize.height = image.size.width * 272.32 / 390;
//
//        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
//
//    } else {
//        newSize.height = image.size.height;
//        newSize.width = image.size.height * 390 / 272.32;
//
//        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
//    }
//
//    return [UIImage imageWithCGImage:imageRef];
//}

static NSData *data;
+ (NSString *) image2DataURL: (UIImage *) image{
    
    data = UIImageJPEGRepresentation(image, 1);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(image, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(image, 0.2);
        }else if (data.length>200*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(image, 0.5);
        }
    }
    
    NSString *mimeType = nil;
    
    if ([self imageHasAlpha: image]) {
        mimeType = @"image/png";
    } else {
        mimeType = @"image/jpg";
    }
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [data base64EncodedStringWithOptions: 0]];
    
}

static NSData *imagedata;
+(UIImage *)compress:(UIImage *)oriImage{
    
    data=UIImageJPEGRepresentation(oriImage, 1);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(oriImage, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(oriImage, 0.3);
        }else if (data.length>200*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(oriImage, 0.7);
        }
    }
    UIImage *xin = [UIImage imageWithData:data];
    return xin;
}

+ (BOOL)imageHasAlpha:(UIImage *) image
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

@end

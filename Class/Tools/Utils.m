//
//  Utils.m
//  SchoolCool
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "Utils.h"
#import "NSString+Checker.h"

@implementation Utils

+ (NSDate *)now
{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    return [date dateByAddingTimeInterval:interval];
}

+ (BOOL)isEmpty:(NSObject *)object
{
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([object isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)object;
        return [string isEmptyString];
    }
    
    return NO;
}

+ (id)parshJsonString:(NSString *)json
{
    if ([Utils isEmpty:json]) {
        return NULL;
    }
    
    NSError *error;
    id data = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        
    }
    return data;
}

+ (void)saveImage: (UIImage*)image Name:(NSString *)name
{
    if (image != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", name]];
        NSData *data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
    }
}

+ (UIImage*)loadImageWithName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", name]];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    return image;
}

+ (BOOL)isPureFloat:(NSString *)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+ (NSArray *)getLinesArrayOfStringInLabel:(UILabel *)label
{
    NSString *text = [label text];
    UIFont *font = [label font];
    CGRect rect = [label frame];
    
    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge  id)myFont range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithInt:0.0]));
        [linesArray addObject:lineString];
    }
    
    CGPathRelease(path);
    CFRelease( frame );
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}

+(CGFloat)strReturnHeight:(UILabel *)label strWidth:(CGFloat)strWidth
{
    CGSize size;
    if (label.font.fontName == nil)
    {
        size = [label.text sizeWithFont:[UIFont systemFontOfSize:label.font.pointSize] constrainedToSize:CGSizeMake(strWidth, MAXFLOAT)];
    }
    else
    {
        size = [label.text sizeWithFont:[UIFont fontWithName:label.font.fontName size:label.font.pointSize] constrainedToSize:CGSizeMake(strWidth, MAXFLOAT)];
    }
    return size.height;
}

+(CGFloat)strReturnHeight:(NSString *)strContent fonSize:(CGFloat)fonSize strWidth:(CGFloat)strWidth
{
    CGSize size;
    size = [strContent sizeWithFont:[UIFont systemFontOfSize:fonSize] constrainedToSize:CGSizeMake(strWidth, MAXFLOAT)];
    return size.height;
}

+(CGFloat)sizeFixWidth:(NSString *)text maxWidth:(CGFloat)maxWidth fonSize:(CGFloat)fonSize{
    
    CGSize titleSize1 = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Ultralight" size:fonSize]}];
    titleSize1.width += 3;
    if (titleSize1.width>maxWidth) {
        titleSize1.width=maxWidth;
    }
    return titleSize1.width;
}

+(CGFloat)sizeFixLabel:(UILabel *)label maxWidth:(CGFloat)maxWidth{
    
    CGSize titleSize1 = [label.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:label.font.fontName size:label.font.pointSize]}];
    titleSize1.width += 3;
    if (titleSize1.width>maxWidth) {
        titleSize1.width=maxWidth;
    }
    return titleSize1.width;
}

+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}


+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < SCREEN_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = SCREEN_WIDTH;
        btWidth = sourceImage.size.width * (SCREEN_WIDTH / sourceImage.size.height);
    } else {
        btWidth = SCREEN_WIDTH;
        btHeight = sourceImage.size.height * (SCREEN_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

+ (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

+(CGSize)getImageSizeWithURL:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef =     CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    if (imageSourceRef) {
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        if (imageProperties != NULL) {
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}


+(UIImage *)thumbnailWithImageWithoutScale:(UIImage *)originalImage size:(CGSize)size
{
    CGSize originalsize = [originalImage size];
    //原图长宽均小于标准长宽的，不作处理返回原图
    if (originalsize.width<size.width && originalsize.height<size.height)
    {
        return originalImage;
    }
    //原图长宽均大于标准长宽的，按比例缩小至最大适应值
    else if(originalsize.width>size.width && originalsize.height>size.height)
    {
        CGFloat rate = 1.0;
        CGFloat widthRate = originalsize.width/size.width;
        CGFloat heightRate = originalsize.height/size.height;
        rate = widthRate>heightRate?heightRate:widthRate;
        CGImageRef imageRef = nil;
        if (heightRate>widthRate)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height*rate/2, originalsize.width, size.height*rate));//获取图片整体部分
        }
        else
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width*rate/2, 0, size.width*rate, originalsize.height));//获取图片整体部分
        }
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        return standardImage;
        
    }
    //原图长宽有一项大于标准长宽的，对大于标准的那一项进行裁剪，另一项保持不变
    else if(originalsize.height>size.height || originalsize.width>size.width)
    {
        CGImageRef imageRef = nil;
        if(originalsize.height>size.height)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height/2, originalsize.width, size.height));//获取图片整体部分
        }
        else if (originalsize.width>size.width)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width/2, 0, size.width, originalsize.height));//获取图片整体部分
        }
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        //      NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        return standardImage;
    }
    //原图为标准长宽的，不做处理
    else
    {
        return originalImage;
    }
}

+ (void)replacePasteboardText{
    //去掉粘贴文字中的换行（适配安卓）
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    NSString *originStr =  board.string;
    
    if ([self isEmpty:originStr] ) {//不做这个判断app可能崩溃
        return;
    }
    
    NSMutableString *resultStr00 = [NSMutableString stringWithString:originStr];
    if ([originStr containsString:@" "]) {
        resultStr00 = (NSMutableString *)[originStr stringByReplacingOccurrencesOfString: @" " withString: @""];
    }
    
    if ([resultStr00 containsString:@"\n"]) {
        NSLog(@"包含n换行");
        resultStr00 = (NSMutableString *)[resultStr00 stringByReplacingOccurrencesOfString: @"\n" withString: @""];
    }
    
    if ([resultStr00 containsString:@"\r"]) {
        NSLog(@"包含r回车");
        resultStr00 = (NSMutableString *)[resultStr00 stringByReplacingOccurrencesOfString: @"\r" withString: @""];
    }
    
    if ([resultStr00 containsString:@"\t"]) {
        NSLog(@"包含t水平制表符");
        resultStr00 = (NSMutableString *)[resultStr00 stringByReplacingOccurrencesOfString: @"\t" withString: @""];
    }
    
    if ([resultStr00 containsString:@"\v"]) {
        NSLog(@"包含v垂直制表符");
        resultStr00 = (NSMutableString *)[resultStr00 stringByReplacingOccurrencesOfString: @"\v" withString: @""];
    }
    
    board.string = resultStr00;
    NSLog(@"origin : %@  \n result : %@",originStr,board.string);
}

@end

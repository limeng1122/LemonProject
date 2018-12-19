//
//  Logger.m
//  SchoolCool
//
//  Created by apple on 2017/2/24.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "Logger.h"

@implementation Logger

+(void)log:(NSString*)string
{
#ifdef DEBUG
    NSLog(@"%@",string);
#endif
}

+(void)log:(NSString*)tag string:(NSString*)value
{
#ifdef DEBUG
    if(tag.length+value.length < 1000){
        NSLog(@"----->%@<-----:%@",tag,value);
        return;
    }
#endif
}

+(void)log:(NSString*)tag integer:(NSInteger)value
{
#ifdef DEBUG
    NSLog(@"----->%@:%d",tag,(int)value);
#endif
}

+(void)log:(NSString*)tag float:(float)value
{
#ifdef DEBUG
    NSLog(@"----->%@:%f",tag,value);
#endif
}

+(void)log:(NSString*)tag shortString:(NSString*)value
{
#ifdef DEBUG
    if(tag.length+value.length < 120){
        NSLog(@"----->%@:%@",tag,value);
        return;
    }
    if(value.length > 3000){
        value = [NSString stringWithFormat:@"%@...",[value substringToIndex:2997]];
    }
    [Logger logHeaderWithStr:tag];
    [Logger logContentWithStr:value];
    [Logger logFooter];
#endif
}

+(void)logHeaderWithStr:(NSString*)tag
{
    NSMutableString *str = [[NSMutableString alloc] initWithString:@"||"];
    int r = 152 - (int)tag.length;
    int s = r/2;
    for(int i=0;i<s;i++){
        [str appendString:@">"];
    }
    [str appendString:tag];
    int e = r%2 == 0 ? r/2 : r/2+1;
    for(int i=0;i<e;i++){
        [str appendString:@">"];
    }
    [str appendString:@"||\n"];
    printf("%s",[str UTF8String]);
}

+(void)logContentWithStr:(NSString*)str
{
    NSMutableString *string = [[NSMutableString alloc] init];
    [string appendString:str];
    [string appendString:@"\n"];
    printf("%s",[string UTF8String]);
}

+(void)logFooter
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:@"||"];
    for(int i=0;i<152;i++){
        [string appendString:@"<"];
    }
    [string appendString:@"||\n"];
    printf("%s",[string UTF8String]);
}

@end

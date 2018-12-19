//
//  ARCSingleTemplate.h
//  SchoolCool
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

//#ifndef ARCSingleTemplate_h
//#define ARCSingleTemplate_h
//
//
//#endif /* ARCSingleTemplate_h */

#define SYNTHESIZE_SINGLETON_FOR_HEADER(className) \
\
    +(className *)shared##className;

#define SYNTHESIZE_SINGLETON_FOR_CLASS(className)    \
\
    +(className *)shared##className                  \
    {                                                \
        static className *shared##className = nil;   \
        static dispatch_once_t onceToken;            \
        dispatch_once(&onceToken, ^{                 \
        shared##className = [[self alloc] init]; \
        });                                          \
    return shared##className;                    \
}

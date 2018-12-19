//
//  BaseResponseModel.h
//  SchoolCool
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BaseResponseModel : JSONModel
@property (nonatomic, copy) NSString *message;     //message
@end

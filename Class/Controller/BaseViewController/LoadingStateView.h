//
//  LoadingStateView.h
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/5/23.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_OPTIONS(NSInteger, LoadingViewState) {
    STATE_LOADING = 1,
    STATE_ERROR = 2,
    STATE_EMPTY
};

@interface LoadingStateView : UIView

@property (nonatomic) BOOL isLightStyle;
- (id)initWithFrame:(CGRect)frame isLightStyle:(BOOL)isLightStyle;
- (void)toLoadingState;
- (void)toEmptyState:(NSString *)emptyMsg;
- (void)toErrorStateWitherrorCode:(NSInteger)code errorMsg:(NSString *)msg reloadHandle:(void (^)(void))reloadHandle;
- (void)removeSelf;
@end

//
//  XKBaseViewController.h
//  SchoolCool
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingStateView.h"

typedef enum {
    LightStyle,
    GrayStyle
} IndicatorStyle;

@protocol BaseViewDelegate<NSObject>
//完成此委托指定导航条是否隐藏
-(BOOL)isHideNavigation;
//隐藏返回按钮
- (BOOL)isHideBackButton;
//隐藏右侧按钮
- (BOOL)isHideRightButton;
//设置右按钮图片
//-(UIImage*)setRightButtonImg;
////设置返回图片
//-(UIImage*)setBackButtonImg;

@end
typedef void(^DidRightButton)(UIButton *button);

@interface XKBaseViewController : UIViewController <BaseViewDelegate>
@property (strong, nonatomic) LoadingStateView *stateView;

//- (void)showHUDWithText:(NSString *)text;
//
///**
// *  隐藏当前显示的提示框
// */
//- (void)hideHud;

@property (nonatomic, retain) id<BaseViewDelegate>  _delegate;
@property (nonatomic, strong)   UIButton                   *backButton;
@property (nonatomic,strong)    UILabel                   *titelLabel;
@property (nonatomic ,strong)   UIView                    *navigationView;
@property (nonatomic ,strong)   UIView                    *lineView;
@property (nonatomic, strong)   UIButton                 *rightButton;
//左侧按钮的图片
@property (nonatomic ,strong)   UIImageView               *LeftBtnImv;

@property (nonatomic ,copy)    DidRightButton        didRightButton;
/**
 *  导航返回事件
 */
- (void)backAction:(id)sender;

/**
 *  设置navigation 右按钮
 *  @param image 图片
 */
- (void)setNavigationBarRightItemWithImage:(NSString *)image;

/**
 *  设置navigation右按钮（文字）
 *  @param title 按钮文字
 */
- (void)setNavigationBarRightItemWithButttonTitle:(NSString *)title;

- (BOOL)checkoutRegistered;

/**
 *  在ViewController.view内显示一个loading的IndicatorView。
 *  该view分两个状态，loading状态和请求失败或空数据状态。根据不同的状态显示不同的视图。
 *  IndicatorStyle:指定IndicatorView的样式，LightStyle 白色，GrayStyle 灰色。
 */
- (void)addLoadingStateViewWithStyle:(IndicatorStyle)style;

- (void)addLoadingStateViewWithStyle:(IndicatorStyle)style frame:(CGRect)frame;

// 从ViewController.view 中移除IndicatorView
- (void)removeLoadingStateView;

/**
 * 找到当前弹出的键盘
 */
- (UIView *)findKeyboard;
- (void)keyBoardWillShow:(NSNotification *)notification;
- (void)keyBoardWillHide:(NSNotification *)notification;
- (void)keyBoardChangeFrame:(NSNotification *)notification;

@end

#define DURATION_TRANSITION_SCALE 0.4f


@interface XKBaseViewController (BaseUIViewControllerSubjoinMethod)

//
- (void)transitionScalePushTo:(UIViewController *)toViewController tempView:(UIView *)tempView completion:(void (^)(void))completion;
- (UIViewController *)transitionScalePopCompletion:(void (^)(void))completion;

@end

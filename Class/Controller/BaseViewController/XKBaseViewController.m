  //
//  XKBaseViewController.m
//  SchoolCool
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "XKBaseViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "TransitionHelper.h"
#import "UIView+Custom.h"
//#import "LoginViewController.h"
#import "JJException.h"

@interface XKBaseViewController () <MBProgressHUDDelegate,JJExceptionHandle>
{
    MBProgressHUD *HUD;
}

@end

@implementation XKBaseViewController
{
    BOOL                      isHideBackButton;
    BOOL                      isHideNavigation;
    UIImage                   *backImg;
    UILabel                   *shujutishi;
}
@synthesize titelLabel,LeftBtnImv,backButton;
@synthesize navigationView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self._delegate = self;
        isHideBackButton = NO;
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    isHideNavigation = [self._delegate isHideNavigation];
    isHideBackButton = [self._delegate isHideBackButton];
    [self initNavigation];
    
    [self.view addSubview:navigationView];//添加自定义的导航条
    
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor clearColor];
    
    [JJException registerExceptionHandle:self];
}

- (void)handleCrashException:(NSString*)exceptionMessage exceptionCategory:(JJExceptionGuardCategory)exceptionCategory extraInfo:(nullable NSDictionary*)info{
    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:exceptionMessage preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//    [alertController addAction:OKAction];
//
//    [self presentViewController:alertController animated:YES completion:nil];
}


/*
 @param  navitationview  导航条
 @param  tag             获取导航条的标识
 */

//创建导航条及导航标题
-(UIView *)CreateNavigation
{
    
    id NavigationView;
    
    if (IOS7)
    {
        NavigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,iNavgationH)];
        [NavigationView setTag:iNavgationTag];
        [NavigationView setBackgroundColor:WhiteColor];
        [self.view addSubview:NavigationView];
    }
    else
    {
        NavigationView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.frame.size.width,iNavgationH)];
        [NavigationView setTag:iNavgationTag];
        [(UIView *)NavigationView setBackgroundColor:WhiteColor];
    }
    titelLabel = [[UILabel alloc] initWithFrame:CGRectMake(55,15+iNavgationSub, [(UIView *)NavigationView frame].size.width-55-55, iNavgationH-5-5-iNavgationSub)];
    [titelLabel setTextAlignment:NSTextAlignmentCenter];
    [titelLabel setTextColor:BlackColor];
    [titelLabel setFont:[UIFont boldSystemFontOfSize:17.f]];
    [titelLabel setBackgroundColor:[UIColor clearColor]];
    [titelLabel setTag:102];
    [NavigationView addSubview:titelLabel];
    
    _lineView=[[UIView alloc]initWithFrame:CGRectMake(0, iNavgationH-1, SCREEN_WIDTH, 1)];
    _lineView.backgroundColor=UIColorFromRGB(0xccd6dd);
    [NavigationView addSubview:_lineView];
    
    return NavigationView;
}

-(UIButton *)CreateNavigationBackButton
{
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setFrame:CGRectMake(0, 20+iNavgationSub, 50, iNavgationH-20-iNavgationSub)];
    [btnBack setBackgroundColor:[UIColor clearColor]];
    [btnBack setImage:[UIImage imageNamed:@"navbar_return_black"] forState:UIControlStateNormal];
    
    if ([self._delegate isHideNavigation])
    {
        [btnBack setBackgroundColor:[UIColor colorWithRed:155.0f/255.0f green:155.0f/255.0f blue:155.0f/255.0f alpha:0.75]];
        [[btnBack layer] setCornerRadius:5];
    }
    return btnBack;
}
-(void)initNavigation
{
    navigationView = [self CreateNavigation];
    [navigationView setHidden:[self._delegate isHideNavigation]];
    backButton = [self CreateNavigationBackButton];
    [backButton setHidden:[self._delegate isHideBackButton]];
    [navigationView addSubview:backButton];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setNavigationBarRightItemWithImage:(NSString *)image{
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(self.view.frame.size.width-45, 20+iNavgationSub, 40 , iNavgationH-20-iNavgationSub);
    [_rightButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:_rightButton];
    
}

- (void)setNavigationBarRightItemWithButttonTitle:(NSString *)title{
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(self.view.frame.size.width-45, 20+iNavgationSub, 40 , iNavgationH-20-iNavgationSub);
    _rightButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [_rightButton setTitle:title forState:UIControlStateNormal];
    [_rightButton setTitleColor:BlackColor forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:_rightButton];
}

-(void)rightAction:(UIButton *)sender{
    
    if (_didRightButton) {
        _didRightButton(sender);
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark back
- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark  QJQW_BaseViewDelegate
-(BOOL)isHideNavigation
{
    return isHideNavigation;
}
//隐藏返回按钮
- (BOOL)isHideBackButton
{
    
    return isHideBackButton;
}

//- (void)showHUDWithText:(NSString *)text {
//    [self hideHud];
//    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//    // Configure for text only and offset down
//    HUD.mode = MBProgressHUDModeIndeterminate;
//    HUD.labelText = text;
//    HUD.margin = 10.f;
//    // Regiser for HUD callbacks so we can remove it from the window at the right time
//    HUD.delegate = self;
//    HUD.removeFromSuperViewOnHide = YES;
//}
//
//- (void)hideHud {
//    if (!HUD.isHidden) {
//        [HUD hide:NO];
//    }
//}

//#pragma mark  检测是否登陆
//- (BOOL)checkoutRegistered
//{
//    if ([Utils isEmpty:[GeneralDataCache sharedGeneralDataCache].userCenterInfo.regFrom]) {
//        [ViewHelper showPromptText:@"请求数据失败"];
//        return NO;
//    }
//    if ([[GeneralDataCache sharedGeneralDataCache].userCenterInfo.regFrom isEqualToString:@"visitor"]) {
//        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
//        nav.navigationBar.tintColor = WhiteColor;
//        [self presentViewController:nav animated:YES completion:nil];
//        return NO;
//    }
//    return YES;
//}

#pragma mark  LoadingState
- (void)addLoadingStateViewWithStyle:(IndicatorStyle)style
{
    if (_stateView && _stateView.superview) {
        [_stateView removeSelf];
        _stateView = nil;
    }
    
    BOOL isLightStyle = YES;
    if (style == GrayStyle) {
        isLightStyle = NO;
    }
    
    if (!_stateView || _stateView.isLightStyle != isLightStyle) {
        _stateView = [[LoadingStateView alloc] initWithFrame:self.view.bounds isLightStyle:isLightStyle];
    }
    
    [_stateView toLoadingState];
    [self.view addSubview:_stateView];
    [self.view bringSubviewToFront:_stateView];
}

- (void)addLoadingStateViewWithStyle:(IndicatorStyle)style frame:(CGRect)frame
{
    if (_stateView && _stateView.superview) {
        [_stateView removeSelf];
    }
    
    BOOL isLightStyle = YES;
    if (style == GrayStyle) {
        isLightStyle = NO;
    }
    
    if (!_stateView || _stateView.isLightStyle != isLightStyle) {
        _stateView = [[LoadingStateView alloc] initWithFrame:frame isLightStyle:isLightStyle];
    }
    
    [_stateView toLoadingState];
    [self.view addSubview:_stateView];
    [self.view bringSubviewToFront:_stateView];
}

- (void)removeLoadingStateView
{
    if (_stateView) {
        [_stateView removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - key board handle
- (void)keyBoardShow:(CGRect)frame animationDuration:(NSTimeInterval)duration
{
    //subview rewrite
}

- (void)keyBoardHide:(CGRect)frame animationDuration:(NSTimeInterval)duration
{
    //subview rewrite
}

- (UIView *)findKeyboard
{
    UIView *keyboardView = nil;
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in [windows reverseObjectEnumerator]) //逆序效率更高，因为键盘总在上方
    {
        keyboardView = [self findKeyboardInView:window];
        if (keyboardView) {
            return keyboardView;
        }
    }
    return nil;
}

- (UIView *)findKeyboardInView:(UIView *)view
{
    for (UIView *subView in [view subviews]) {
        if (strstr(object_getClassName(subView), "UIKeyboard")) {
            return subView;
        } else {
            UIView *tempView = [self findKeyboardInView:subView];
            if (tempView) {
                return tempView;
            }
        }
    }
    return nil;
}

- (void)keyBoardWillShow:(NSNotification *)notification
{
    UIView *keyBoard = [self findKeyboard];
    if (!keyBoard) {
        CGRect keyboardFrames = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        NSTimeInterval animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        [self keyBoardShow:keyboardFrames animationDuration:animationDuration];
    }
}

- (void)keyBoardWillHide:(NSNotification *)notification
{
    UIView *keyBoard = [self findKeyboard];
    if (keyBoard) {
        CGRect keyboardFrames = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        NSTimeInterval animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        [self keyBoardHide:keyboardFrames animationDuration:animationDuration];
    }
}

- (void)keyBoardChangeFrame:(NSNotification *)notification
{
    UIView *keyBoard = [self findKeyboard];
    if (keyBoard) {
        CGRect keyboardFrames = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        [self keyBoardShow:keyboardFrames animationDuration:0.35f];
    }
}

@end

#define KEY_TEMP_VIEW @"KEY_TEMP_VIEW"
#define KEY_FROM_VC @"KEY_FROM_VC"
#define KEY_TO_VC @"KEY_TO_VC"

#define KeyForViewController(vc) [NSString stringWithFormat:@"%p", vc]


@implementation UIView (ConvertToImage)

- (UIImage *)convertToImage
{
    UIImage *returnImage;
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ctx];
    returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImage;
}

@end

@implementation XKBaseViewController (BaseUIViewControllerSubjoinMethod)

- (void)transitionScalePushTo:(UIViewController *)toViewController tempView:(UIView *)tempView completion:(void (^)(void))completion
{
    if (self.navigationController) {
        [ViewHelper setUserInteractionEnabled:NO];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:self forKey:KEY_FROM_VC];
        [dict setObject:toViewController forKey:KEY_TO_VC];
        [dict setObject:tempView forKey:KEY_TEMP_VIEW];
        [[TransitionHelper shareInstance].params setObject:dict forKey:KeyForViewController(toViewController)];
        
        UIImage *baseImage = [self.view convertToImage];
        UIImage *scaleImage = [toViewController.view convertToImage];
        UIView *baseView = [[UIImageView alloc] initWithImage:baseImage];
        UIView *scaleView = [[UIImageView alloc] initWithImage:scaleImage];
         
        convertPushRect(baseView, scaleView, tempView);
        [scaleView setAlpha:0.0f];
        [self.view addSubview:baseView];
        
        [UIView animateWithDuration:DefaultAnimationDuration
                         animations:^{
                             convertPushDoneRect(baseView, scaleView);
                             [scaleView setAlpha:1.0f];
                         }
                         completion:^(BOOL finished) {
                             if (completion) {
                                 completion();
                             }
                             [self.navigationController pushViewController:toViewController animated:NO];
                             [baseView removeFromSuperview];
                             
                             [ViewHelper setUserInteractionEnabled:YES];
                         }];
    }
}

- (UIViewController *)transitionScalePopCompletion:(void (^)(void))completion
{
    if (self.navigationController) {
        [ViewHelper setUserInteractionEnabled:NO];
        UIViewController *topViewController = [self.navigationController topViewController];
        NSMutableDictionary *dict = [[TransitionHelper shareInstance].params objectForKey:KeyForViewController(topViewController)];
        if (dict) {
            UIViewController *fromViewController = [dict objectForKey:KEY_FROM_VC];
            UIViewController *toViewController = [dict objectForKey:KEY_TO_VC];
            UIView *tempView = [dict objectForKey:KEY_TEMP_VIEW];
            
            UIImage *baseImage = [fromViewController.view convertToImage];
            UIImage *scaleImage = [toViewController.view convertToImage];
            UIView *baseView = [[UIImageView alloc] initWithImage:baseImage];
            UIView *scaleView = [[UIImageView alloc] initWithImage:scaleImage];
            
            convertPopRect(baseView, scaleView, tempView);
            [scaleView setAlpha:1.0f];
            [fromViewController.view addSubview:baseView];
            [UIView animateWithDuration:DefaultAnimationDuration
                             animations:^{
                                 convertPopDoneRect(baseView, scaleView);
                                 [scaleView setAlpha:0.0f];
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                                 [baseView removeFromSuperview];
                                 
                                 [[TransitionHelper shareInstance].params removeObjectForKey:KeyForViewController(self)];
                                 [ViewHelper setUserInteractionEnabled:YES];
                             }];
            return [self.navigationController popViewControllerAnimated:NO];
        } else {
            [ViewHelper setUserInteractionEnabled:YES];
            return [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        return nil;
    }
}

void convertPushRect(UIView *baseView, UIView *scaleView, UIView *tempView)
{
    CGFloat scaleRate = tempView.frame.size.width / scaleView.frame.size.width;
    
    [scaleView setScaleX:scaleRate scaleY:scaleRate];
    [scaleView setFrame:CGRectMake(tempView.frame.origin.x, tempView.frame.origin.y, scaleView.frame.size.width, scaleView.frame.size.height)];
    
    if (scaleView.superview != baseView) {
        [scaleView removeFromSuperview];
        [baseView addSubview:scaleView];
    }
}

void convertPushDoneRect(UIView *baseView, UIView *scaleView)
{
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGFloat scaleRate = screenBounds.size.width / scaleView.frame.size.width;
    
    CGFloat rateX = scaleView.frame.origin.x / baseView.frame.size.width;
    CGFloat rateY = scaleView.frame.origin.y / baseView.frame.size.height;
    
    [baseView setScaleX:scaleRate scaleY:scaleRate];
    
    CGPoint basePath = CGPointMake(-baseView.frame.size.width * rateX, -baseView.frame.size.height * rateY);
    [baseView setFrame:CGRectMake(basePath.x, basePath.y, baseView.frame.size.width, baseView.frame.size.height)];
}

void convertPopRect(UIView *baseView, UIView *scaleView, UIView *tempView)
{
    convertPushRect(baseView, scaleView, tempView);
    
    convertPushDoneRect(baseView, scaleView);
}

void convertPopDoneRect(UIView *baseView, UIView *scaleView)
{
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGFloat scaleRate = screenBounds.size.width / baseView.frame.size.width;
    
    [baseView setScaleX:scaleRate scaleY:scaleRate];
    
    [baseView setFrame:baseView.bounds];
}

@end

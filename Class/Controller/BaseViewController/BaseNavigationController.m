//
//  BaseNavigationController.m
//  SchoolCool
//
//  Created by 李檬 on 2018/8/3.
//  Copyright © 2018年 interviewContent. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    __weak BaseNavigationController *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    if (self.navigationController.viewControllers.count == 1) {
//        return NO;
//    }else{
//        return YES;
//    }
    if ([gestureRecognizer isEqual:self.interactivePopGestureRecognizer] && self.viewControllers.count > 1 &&
        [self.visibleViewController isEqual:[self.viewControllers lastObject]]) {
        //判断当导航堆栈中存在页面，并且可见视图如果不是导航堆栈中的最后一个视图时，就会屏蔽掉滑动返回的手势。此设置是为了避免页面滑动返回时因动画存在延迟所导致的卡死。
        return YES;
    } else {
        return NO;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self)
    {
        [self.view setBackgroundColor:WhiteColor];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
//        if ([self currentViewController]) {
//            navigationController.interactivePopGestureRecognizer.enabled = NO;
//            navigationController.interactivePopGestureRecognizer.delegate = nil;
//        }
//        else{
            navigationController.interactivePopGestureRecognizer.enabled = YES;
//        }
    }
    //使navigationcontroller中第一个控制器不响应右滑pop手势
    if (navigationController.viewControllers.count == 1) {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
        navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }

    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return [super popToRootViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return [super popToViewController:viewController animated:animated];
}

//-(int)currentViewController{
//    // Find best view controller
//    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
//    UIViewController * viewControllerNow = [self findBestViewController:viewController];
//    if ([viewControllerNow  isKindOfClass:[MeetFaceScoreViewController class]]) {
//        return 1;
//    }
//    else
//        return 0;
//}
//
//-(UIViewController*)findBestViewController:(UIViewController*)vc {
//    
//    if (vc.presentedViewController) {
//        
//        // Return presented view controller
//        return [self findBestViewController:vc.presentedViewController];
//        
//    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
//        
//        // Return right hand side
//        UISplitViewController* svc = (UISplitViewController*) vc;
//        if (svc.viewControllers.count > 0)
//            return [self findBestViewController:svc.viewControllers.lastObject];
//        else
//            return vc;
//        
//    } else if ([vc isKindOfClass:[UINavigationController class]]) {
//        
//        // Return top view
//        UINavigationController* svc = (UINavigationController*) vc;
//        if (svc.viewControllers.count > 0)
//            return [self findBestViewController:svc.topViewController];
//        else
//            return vc;
//        
//    } else if ([vc isKindOfClass:[UITabBarController class]]) {
//        UITabBarController* svc = (UITabBarController*) vc;
//        if (svc.viewControllers.count > 0)
//            return [self findBestViewController:svc.selectedViewController];
//        else
//            return vc;
//    } else {
//        return vc;
//    }
//}

@end

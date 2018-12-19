//
//  HomeIndexViewController.m
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/3/17.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "HomeIndexViewController.h"
#import "IndexViewController.h"
//#import "WZLBadgeImport.h"
#import "UITabBar+badge.h"

@interface HomeIndexViewController ()<UITabBarControllerDelegate>

@end

@implementation HomeIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.delegate = self;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = WhiteColor;
    self.delegate=self;
    [self initTabbar];
}

-(void)initTabbar{
    
    [self.tabBar setFrame:CGRectMake(self.tabBar.frame.origin.x,
                                     self.tabBar.frame.origin.y,
                                     self.tabBar.frame.size.width,
                                     self.tabBar.frame.size.height)];
    
    [self.tabBar.layer setBorderColor:[[UIColor clearColor] CGColor]];
    [self.tabBar.layer setBorderWidth:0];
    
    //设置tabbar的背景颜色
    CGSize imageSize = CGSizeMake(self.view.frame.size.width, self.tabBar.frame.size.height);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [[UIColor whiteColor] set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setBackgroundImage:pressedColorImg];
    
    IndexViewController *homeVC = [[IndexViewController alloc] init];
    NSArray* controllers  = @[homeVC];
    [self setViewControllers:controllers animated:YES];
    [self setSelectedIndex:0];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self.tabBar.layer setBorderColor:[[UIColor clearColor] CGColor]];
    [self.tabBar.layer setBorderWidth:0];
    
    UITabBarItem *tabBarItem1 = [self.tabBar.items objectAtIndex:0];
//    UITabBarItem *tabBarItem2 = [self.tabBar.items objectAtIndex:1];
//    UITabBarItem *tabBarItem3 = [self.tabBar.items objectAtIndex:2];
//    UITabBarItem *tabBarItem4 = [self.tabBar.items objectAtIndex:3];
    
    [tabBarItem1 setTag:0];
//    [tabBarItem2 setTag:0];
//    [tabBarItem3 setTag:0];
//    [tabBarItem4 setTag:0];
    tabBarItem1.title = @"新鲜事";
//    tabBarItem2.title = @"新同学";
//    tabBarItem3.title = @"聊天";
//    tabBarItem4.title = @"我的";
    
    tabBarItem1.image = [[UIImage imageNamed:@"tabbar_release_deault"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [tabBarItem1 setSelectedImage:[[UIImage imageNamed:@"tabBar_Release"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
//    tabBarItem2.image = [[UIImage imageNamed:@"tabbar_chat_default"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [tabBarItem2 setSelectedImage:[[UIImage imageNamed:@"tabbar_chat_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//
//    tabBarItem3.image = [[UIImage imageNamed:@"tabbar_find_deault"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [tabBarItem3 setSelectedImage:[[UIImage imageNamed:@"tabbar_find_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//
//    tabBarItem4.image = [[UIImage imageNamed:@"tabbar_mine_deault"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [tabBarItem4 setSelectedImage:[[UIImage imageNamed:@"tabbar_mine_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//
    [self.tabBar setTintColor:BlueColor];
    [self.tabBar setBarTintColor:WhiteColor];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (viewController == tabBarController.viewControllers[0]) {
//        UINavigationController *nav = (UINavigationController *)viewController;
//        if ([[IndexViewController class] isEqual:[[nav.viewControllers firstObject] class]]) {
//            IndexViewController *vc = (IndexViewController *)[[nav.viewControllers firstObject] class];
//            if ( vc.previousClickedTag ==  (int)self.selectedIndex ) {//进行了第二次点击
//                [vc.tableView.mj_header beginRefreshing];
//            }
//            vc.previousClickedTag = 0;//记录上一次按钮的点击
            
           __strong NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            [dic setValue:@"0" forKey:@"index"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"tabBarRefreshHomeViewController" object:nil userInfo:dic];
//        }
    }
    else if (viewController == self.viewControllers[2]) {
//        MessageStatusDataCache *dataCache = [MessageStatusDataCache sharedMessageStatusDataCache];
//        int count = [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE),
//                                                                    @(ConversationType_GROUP),
//                                                                    @(ConversationType_SYSTEM)]];
//
//        UINavigationController *nav = (UINavigationController *)viewController;
//        if ([[MessageViewController class] isEqual:[[nav.viewControllers firstObject] class]]) {
//            MessageViewController *vc = (MessageViewController *)[[nav.viewControllers firstObject] class];
//            if (count) {
//                [vc.btnArray[1] showBadgeWithStyle:WBadgeStyleNumber value:count animationType:WBadgeAnimTypeBreathe];
//            } else {
//                [vc.btnArray[1] clearBadge];
//            }
//            if ([dataCache.messageNum integerValue]) {
//                [vc.btnArray[0] showBadgeWithStyle:WBadgeStyleNumber value:[dataCache.messageNum integerValue] animationType:WBadgeAnimTypeBreathe];
//            } else {
//                [vc.btnArray[0] clearBadge];
//            }
//
//            //选中第一个控制器
//            if ([dataCache.messageNum integerValue] && !count) {
//                [vc buttonClick:vc.btnArray[0]];
//            } else {
//                [vc buttonClick:vc.btnArray[1]];
//            }
//        }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"tabBarRefreshMessageViewController" object:nil userInfo:nil];
    }
    return YES;
}
//
//- (BOOL)checkoutRegistered
//{
//    if ([Utils isEmpty:[GeneralDataCache sharedGeneralDataCache].userCenterInfo.regFrom]) {
//        [ViewHelper showPromptText:@"数据获取失败请重新登录"];
//        return NO;
//    }
//    if ([[GeneralDataCache sharedGeneralDataCache].userCenterInfo.regFrom isEqualToString:@"visitor"] || [Utils isEmpty:[GeneralDataCache sharedGeneralDataCache].userCenterInfo.regFrom]) {
//        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
//        nav.navigationBar.tintColor = WhiteColor;
//        [self presentViewController:nav animated:YES completion:nil];
//        return NO;
//    }
//    return YES;
//}

@end

//
//  JBTabBarBtn.h
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/8/2.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JBTabBarBtn : UIButton
/** 大圆脱离小圆的最大距离 */
@property (nonatomic, assign) CGFloat maxDistance;

/** 小圆 */
@property (nonatomic, strong) UIView *samllCircleView;

/** 按钮消失的动画图片组 */
@property (nonatomic, strong) NSMutableArray *images;

/** 未读数 */
@property (nonatomic, strong) NSString *unreadCount;

@property (nonatomic, strong) UIImage *unreadCountImage;

/** 绘制不规则图形 */
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@end

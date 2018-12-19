//
//  BaseButton.h
//  Lemon
//
//  Created by 李檬 on 2018/11/23.
//  Copyright © 2018年 Lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseButton : UIButton
/**
 *  为按钮添加点击间隔 eventTimeInterval秒
 */
@property (nonatomic, assign) NSTimeInterval eventTimeInterval;
@end

NS_ASSUME_NONNULL_END

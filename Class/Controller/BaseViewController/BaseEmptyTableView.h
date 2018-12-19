//
//  BaseTableView.h
//  BaseTableView
//

#import <UIKit/UIKit.h>

@protocol BaseEmptyTableViewDelegate <NSObject>
@optional
- (void)requestDataByDelegate;

- (void)requestMoreDataByDelegate;

- (void)requestDataByClickButton;

@end


@interface BaseEmptyTableView : UITableView

@property(nonatomic, copy) NSString * descriptionString;

@property(nonatomic, copy) NSString * emptyString;

@property(nonatomic, copy) NSString * emptyImageName;

@property(nonatomic, copy) NSString * imageNameWhenLoading;

@property(nonatomic, copy) NSString * buttomTitle;

@property(nonatomic, copy) NSString * buttonBgImageName;

@property(nonatomic, copy) UIColor * buttonTextColor;

@property(nonatomic, copy) UIColor * viewBackColor;

// 是否显示按钮图片 default NO;
@property(nonatomic, assign) BOOL isDisplayButtonImage;
// 点击按钮跳转事件 default Yes-重新加载 NO-其他事件;
@property(nonatomic, assign) BOOL isClickButtonImage;
// 是否显示加载图片 default YES;
@property (nonatomic,assign)BOOL isLoading;
// 显示暂位图时，是否允许滑动 default YES
@property(nonatomic, assign) BOOL isAllowScroll;
// 是否允许点击暂位信息，重新获取数据 default NO;
@property(nonatomic, assign) BOOL isAllowRequestDataByTap;
//是否显示占位文本信息 default YES;
@property(nonatomic, assign) BOOL isAllowDisplayPlaceholder;
//是否显示占位按钮信息 default YES;
@property(nonatomic, assign) BOOL isAllowDisplayButton;
//是否显示占位按钮信息 default YES;
@property(nonatomic, assign) BOOL isTableViewEditing;
//偏移量;
@property(nonatomic, assign) CGFloat offset;

@property(nonatomic,weak)id<BaseEmptyTableViewDelegate>iDelegate;

- (void)setConfigure;

@end

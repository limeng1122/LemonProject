//
//  BaseRefreshTableView.h
//  BaseTableView
//

#import "BaseTableView.h"



@interface BaseRefreshTableView : BaseTableView

@property (nonatomic) BOOL  supportRefreshDown;//是否支持下拉刷新
@property (nonatomic) BOOL  supportRefreshUp;//是否支持上拉加载
@property (nonatomic) BOOL  isRefresh;

/**
 *  自动刷新
 */
- (void)autoRefresh;
/**
 *  下拉刷新事件
 */
- (void)tableViewDidTriggerDownRefresh;
/**
 *  上拉加载事件
 */
- (void)tableViewDidTriggerUpRefresh;
/**
 *  停止刷新
 */
- (void)tableViewDidFinishRefreshByDragDown:(BOOL)isDragDown;

@end

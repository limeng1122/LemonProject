//
//  BaseTableView.h
//  LYFBaseTableView
//


#import "BaseEmptyTableView.h"

//渲染cell
typedef UITableViewCell *(^CallbackCell)(NSIndexPath * indexPath);

//点击cell
typedef void(^CallbackDidSelectedCell)(UITableViewCell * cell,NSIndexPath * indexPath);

//取消点击cell
typedef void(^CallbackDidDeselectCell)(NSIndexPath * indexPath);

//渲染header
typedef UIView *(^CallbackHeader)(UIView * header,NSInteger section);

//header高度
typedef CGFloat (^CallbackHeaderHeight)(CGFloat height,NSInteger section);

//cell高度
typedef CGFloat (^CallbackCellHeight)(CGFloat height,NSIndexPath *indexPath);

//删除cell
typedef void(^CallbackDidDeleteCell)(NSIndexPath * indexPath);

//偏移量
typedef void(^CallbackOffset)(UIScrollView * scrollView);

//
typedef void (^CallbackScrollViewMove)(void);

@interface BaseTableView : BaseEmptyTableView
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger sectionNumber;
@property(nonatomic,strong)CallbackCell callbackCell;
@property(nonatomic,strong)CallbackDidSelectedCell callbackDidSelectedCell;
@property(nonatomic,strong)CallbackHeader callbackHeader;
@property(nonatomic,strong)CallbackHeaderHeight callbackHeaderHeight;
@property(nonatomic,strong)CallbackCellHeight callbackCellHeight;
@property(nonatomic,assign)BOOL canDelete;
@property(nonatomic,strong)CallbackDidDeleteCell callbackDidDeleteCell;
@property(nonatomic,strong)CallbackOffset callbackOffset;
@property(nonatomic,strong)CallbackDidDeselectCell callbackDidDeselectCell;
@property(nonatomic,strong)CallbackScrollViewMove callbackScrollViewMove;

/**
 NOTE:
 初始化tableview的时候，一定要记得调用这个block 把cell的重用标识符回传给BaseTableview，否则重用会出现问题
 */
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style callbackIdentifier:(NSString *(^)(void))callbackIdentifier;

/**
 设置空白页面的配置
 */
-(void)setConfigEmptySource:(NSMutableDictionary *)dic;

-(void)setConfigEmptyOffset:(CGFloat)offset;

-(void)setConfigViewBgColor:(UIColor *)color;

-(void)setTableViewEditing;

-(void)setConfigEmptyButtonImage:(NSString *)imageName ButtonTitle:(NSString *)title ButtonTextColor:(UIColor *)color jumpFlag:(BOOL)isJump;
@end


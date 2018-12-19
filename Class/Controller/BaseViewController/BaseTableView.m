//
//  BaseEmptyTableView.m
//  BaseTableView
//

#import "BaseTableView.h"

@interface BaseTableView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign) BOOL rate;
@end

@implementation BaseTableView

static NSString * identifier = nil;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style callbackIdentifier:(NSString *(^)(void))callbackIdentifier {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setConfigure];
        identifier = callbackIdentifier();
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setConfigure];
    }
    return self;
}

- (void)setConfigure {
    [super setConfigure];
    
    self.dataSource = self;
    self.delegate = self;
    
    if (@available(iOS 11.0, *)){
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

#pragma mark UITableViewDataSource - Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  _sectionNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_dataArray.count>0) {
        return [[_dataArray objectAtIndex:section] integerValue];
    }
    else if(_dataArray.count==0){
        return _dataArray.count;
    }
    else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(identifier != nil,@"must invok  - (instancetype) initWithFrame: callbackIdentifier: Method to init current Tableview and callback a valid parameter for identifer");

    if (_callbackCell) {
        UITableViewCell * cell = self.callbackCell(indexPath);
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_callbackDidSelectedCell) {
        //TODO some code
        self.callbackDidSelectedCell(nil, indexPath);
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_callbackDidDeselectCell) {
        //TODO some code
        self.callbackDidDeselectCell(indexPath);
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[UIView new];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[UIView new];
    view.backgroundColor = [UIColor clearColor];
    if (_callbackHeader) {
        view = _callbackHeader(view,section);
    }
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 0;
    if (_callbackHeaderHeight) {
        height = _callbackHeaderHeight(height,section);
    }
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = 0;
    if (_callbackCellHeight) {
        height = _callbackCellHeight(height,indexPath);
    }
    return height;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_canDelete) {
        return YES;
    }
    return NO;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (_callbackDidDeleteCell) {
            _callbackDidDeleteCell(indexPath);
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_callbackOffset) {
        _callbackOffset(scrollView);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(decelerate == NO){
        if (_callbackScrollViewMove) {
            _callbackScrollViewMove();
        }
    }
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if (velocity.y >0 || velocity.y < 0) {
        _rate = YES;
    }else{
        _rate = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (_rate == YES) {
        if (_callbackScrollViewMove) {
            _callbackScrollViewMove();
        }
    }
}

-(void)setTableViewEditing{
    
    self.isTableViewEditing=YES;
    self.allowsSelectionDuringEditing = YES;
    self.allowsMultipleSelection = YES;
    self.allowsMultipleSelectionDuringEditing = YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

-(void)setConfigEmptySource:(NSMutableDictionary *)dic{

    self.descriptionString = [dic objectForKey:@"descriptionString"];
    self.emptyString = [dic objectForKey:@"emptyString"];
    self.isAllowDisplayButton = [[dic objectForKey:@"isAllowDisplayButton"] boolValue];
    self.isAllowRequestDataByTap = [[dic objectForKey:@"isAllowRequestDataByTap"] boolValue];
}

-(void)setConfigEmptyButtonImage:(NSString *)imageName ButtonTitle:(NSString *)title ButtonTextColor:(UIColor *)color jumpFlag:(BOOL)isJump{
    self.isDisplayButtonImage=NO;
    self.isAllowRequestDataByTap=YES;
    self.buttonBgImageName=imageName;
    self.buttomTitle=title;
    self.buttonTextColor=color;
    self.isClickButtonImage=isJump;
}

-(void)setConfigEmptyOffset:(CGFloat)offset{
    self.offset=offset;
}

-(void)setConfigViewBgColor:(UIColor *)color{
    
    self.viewBackColor=color;
}
@end

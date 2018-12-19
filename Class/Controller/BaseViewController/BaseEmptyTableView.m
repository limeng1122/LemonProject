//
//  BaseTableView.m
//  BaseTableView
//

#import "BaseTableView.h"
#import "UIScrollView+EmptyDataSet.h"

@interface BaseEmptyTableView()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end


@implementation BaseEmptyTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setConfigure];
    }
    return self;
}

- (void)setConfigure {

    //默认属性，如果每个界面需要不同的信息，单独设置，重新赋值
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
    
    self.isAllowScroll = NO;
    self.isAllowRequestDataByTap = NO;
    self.isAllowDisplayPlaceholder = YES;
    self.imageNameWhenLoading = @"loading_imgBlue_78x78";
    self.buttomTitle = @"点击重连";
    self.descriptionString = @"";
    self.emptyString = @"";
    self.isAllowDisplayButton = NO;
    self.offset=-iNavgationH;
    self.isDisplayButtonImage = NO;
    self.buttonBgImageName=@"live_add";
    self.isClickButtonImage=YES;
    self.buttonTextColor=BlueColor;
    self.viewBackColor=ViewBgColor;
    self.isTableViewEditing=NO;
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    
    [self setEditing:_isTableViewEditing animated:YES];
    
    [self addObserver:self forKeyPath:@"isLoading" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    [self hideUselessCutLine];
    
}

#pragma mark 隐藏多余的分割线
- (void)hideUselessCutLine {
    UIView *footerView = [[UIView alloc]init];
    self.tableFooterView = footerView;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc]init];
    text = _emptyString;
    font = [UIFont systemFontOfSize:20.0];
    textColor = UIColorAlpha(20, 23, 26, 1.0);
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];

    return attributedString;
}

#pragma mark 刷新按钮的本文信息
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    if (self.isAllowDisplayButton) {
        NSString *text = nil;
        UIFont *font = nil;
        UIColor *textColor = nil;
        text = _buttomTitle;
        font = [UIFont systemFontOfSize:20.0];
        textColor = self.buttonTextColor;
        NSMutableDictionary *attributes = [NSMutableDictionary new];
        if (font) [attributes setObject:font forKey:NSFontAttributeName];
        if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
        
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
    else{
        return nil;
    }
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if (_isDisplayButtonImage) {
        return [UIImage imageNamed:_buttonBgImageName];
    }
    else{
        return nil;
    }
}

#pragma mark 无数据时的描述信息
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = [NSString stringWithFormat:@"%@", _descriptionString] ;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    paragraph.lineSpacing = 5.0;
    
    textColor=UIColorAlpha(128, 143, 155, 1.0);
    font=[UIFont systemFontOfSize:14];
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    if (paragraph) [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];

    return attributedString;
}

-(CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 40;
}

-(UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    
    return self.viewBackColor;
}

#pragma mark - DZNEmptyDataSetDelegate Methods

//是否显示暂位文本信息
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return _isAllowDisplayPlaceholder;
}
// 显示暂位图时，点击提示信息是否刷新
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return _isAllowRequestDataByTap;
}
// 显示暂位图时，是否允许滑动
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return _isAllowScroll;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return _isLoading;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    [self requestData];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    if (self.isClickButtonImage) {
        [self requestData];
    }
    else{
        if (_iDelegate && [_iDelegate respondsToSelector:@selector(requestDataByClickButton)]) {
            [_iDelegate requestDataByClickButton];
        }
        
    }
}

- (void)requestData {
    if (_iDelegate && [_iDelegate respondsToSelector:@selector(requestDataByDelegate)]) {
        [_iDelegate requestDataByDelegate];
    }
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.isLoading) {
        return [UIImage imageNamed:self.imageNameWhenLoading];
    }
    else {
        return nil;
    }
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"isLoading"]) {
        [self reloadEmptyDataSet];
    }
    //    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.offset;
}
@end

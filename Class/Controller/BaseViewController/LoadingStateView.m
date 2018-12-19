//
//  LoadingStateView.m
//  SchoolCool
//
//  Created by Jiabin_apple on 2017/5/23.
//  Copyright © 2017年 interviewContent. All rights reserved.
//

#import "LoadingStateView.h"
#import "NSString+Size.h"
#import "HttpErrorMacro.h"
#import "OneLoadingAnimationView.h"

typedef void(^ReloadHandle)(void);

@interface LoadingStateView () <UIAlertViewDelegate>
//    UIControl *_servicePhoneView;
//    NSString *_telString;
@property(nonatomic,strong)OneLoadingAnimationView *loadingView;
@property(nonatomic,strong)UILabel *errorLabel;
@property(nonatomic,strong)UILabel *tipLB;
@property(nonatomic,assign)BOOL hasTouchMoved;
@property(nonatomic,copy)ReloadHandle reloadHandle;
@property(nonatomic,assign)int delayTime;
@property(nonatomic,strong)UIColor *textColor;

@end

@implementation LoadingStateView
- (instancetype)initWithFrame:(CGRect)frame isLightStyle:(BOOL)isLightStyle
{
    self = [super initWithFrame:frame];
    if (self) {
        _isLightStyle = isLightStyle;
        _delayTime = 1;
        _textColor = BlueColor;
        [self initViews];
        [self toLoadingState];
    }
    return self;
}

- (void)initViews
{
    _loadingView = [[OneLoadingAnimationView alloc] initStyle:LargeStyle];
    if (_isLightStyle) {
        _loadingView.normalColor = WhiteColor;
    } else {
        _loadingView.normalColor = DarkGrayColor;
    }
    [_loadingView setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2-56)];
    [self addSubview:_loadingView];
    
    _errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, UIControlYLength(_loadingView)+10, UIViewWidth(self), 20)];
    _errorLabel.font = MediumFont;
    _errorLabel.backgroundColor = [UIColor clearColor];
    _errorLabel.textAlignment = NSTextAlignmentCenter;
    //    _errorLabel.editable = NO;
    //    _errorLabel.selectable = YES;
    //    _errorLabel.dataDetectorTypes = UIDataDetectorTypeAll;
    if (_isLightStyle) {
        _errorLabel.textColor = [UIColor whiteColor];
    } else {
        _errorLabel.textColor = DarkGrayColor;
    }
    _errorLabel.layer.opacity = 0;
    [self addSubview:_errorLabel];
    
    _tipLB = [[UILabel alloc] initWithFrame:CGRectMake(0, UIControlYLength(_errorLabel) + 5, 180, 32)];
    _tipLB.textColor = _textColor;
    _tipLB.font = BigFont;
    _tipLB.textAlignment = NSTextAlignmentCenter;
    _tipLB.text = @"点击重试";
    _tipLB.layer.opacity = 0;
    [self addSubview:_tipLB];
    
//    _servicePhoneView = [[UIControl alloc] initWithFrame:CGRectMake(0, UIControlYLength(_tipLB) + 5, 180, 60)];
//    _servicePhoneView.center = CGPointMake(self.frame.size.width/2, UIControlYLength(_tipLB) + 30);
//    _servicePhoneView.backgroundColor = [UIColor clearColor];
//    [_servicePhoneView addTarget:self action:@selector(showCallServiceView) forControlEvents:UIControlEventTouchUpInside];
//    _servicePhoneView.layer.opacity = 0;
//    [self addSubview:_servicePhoneView];
//    
//    UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, 9.8, UIViewWidth(_servicePhoneView)/2 - 20, 0.5)];
//    leftLine.backgroundColor = GrayColor;
//    [_servicePhoneView addSubview:leftLine];
//    
//    UILabel *midView = [[UILabel alloc] initWithFrame:CGRectMake(UIControlXLength(leftLine), 0, 40, 20)];
//    midView.text = @"或";
//    midView.textColor = GrayColor;
//    midView.font = [UIFont systemFontOfSize:14];
//    midView.textAlignment = NSTextAlignmentCenter;
//    [_servicePhoneView addSubview:midView];
//    
//    UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(UIViewWidth(_servicePhoneView)/2 + 20, 9.8, UIViewWidth(_servicePhoneView)/2 - 20, 0.5)];
//    rightLine.backgroundColor = GrayColor;
//    [_servicePhoneView addSubview:rightLine];
//    
//    UILabel *callService = [[UILabel alloc] initWithFrame:CGRectMake(0, UIControlYLength(midView) + 8, UIViewWidth(_servicePhoneView), 32)];
//    callService.text = @"联系客服";
//    callService.font = BigFont;
//    callService.textColor = textColor;
//    callService.textAlignment = NSTextAlignmentCenter;
//    [_servicePhoneView addSubview:callService];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _hasTouchMoved = NO;
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{ 
    _hasTouchMoved = YES;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(!_hasTouchMoved && _reloadHandle && _loadingView.state >= 2){
        _delayTime = 1.5;
        [self hideFailedMsg];   
        [self toLoadingState];
        _reloadHandle();
    }
}

- (void)toLoadingState
{
    [_loadingView startAnimation];
}

- (void)toErrorStateWitherrorCode:(NSInteger)code errorMsg:(NSString *)msg reloadHandle:(void (^)(void))reloadHandle
{
    LXWS(weakSelf);
    _reloadHandle = reloadHandle;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, _delayTime * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.loadingView toFailedViewState];
        [self showFailedViewWithCode:code errorMsg:msg];
    });
}

-(void)showFailedViewWithCode:(NSInteger)code errorMsg:(NSString *)msg
{
    
    CGFloat height = [msg textSizeWithFont:_errorLabel.font constrainedToSize:CGSizeMake(_errorLabel.frame.size.width, 0)].height + 10;
    switch (code) {
        case CODE_NO_NETWORK:
            _errorLabel.text = @"无网络连接，请打开网络或检查连接";
            break;
        case CODE_CAN_NOT_CONNECT:
            _errorLabel.text = @"连接超时，请检查网络连接或重试";
            break;
        case CODE_PARSH_FAILED:
            _errorLabel.text = @"获取数据失败，请稍后重试";
            break;
        case CODE_CAN_NOT_FOUND_RESPONSE:
            _errorLabel.text = @"获取数据失败，请稍后重试";
            break;
        default: {
            _errorLabel.text = msg;
        }
            break;
    }
    _errorLabel.frame = CGRectMake(_errorLabel.frame.origin.x, _errorLabel.frame.origin.y, _errorLabel.frame.size.width, height);
    _tipLB.frame = CGRectMake(_errorLabel.frame.origin.x, UIControlYLength(_errorLabel) + 8, _errorLabel.frame.size.width, 32);
    [self showFailedMsgWithCode:code];
    _delayTime = 1;
}

-(void)showFailedMsgWithCode:(NSInteger)code
{
    LXWS(weakSelf);
    [UIView animateWithDuration:1 animations:^{
        weakSelf.errorLabel.layer.opacity = 1;
        if(code != -1)weakSelf.tipLB.layer.opacity = 1;
    }];
}

- (void)toEmptyState:(NSString *)emptyMsg
{
    LXWS(weakSelf);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.loadingView toEmptyViewState];
        [self showFailedViewWithCode:-1 errorMsg:emptyMsg];
    });
}

-(void)hideFailedMsg
{
    LXWS(weakSelf);
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.errorLabel.layer.opacity = 0;
        weakSelf.tipLB.layer.opacity = 0;
    }];
}

- (void)removeSelf
{
    if (self.superview) {
        [self removeFromSuperview];
    }
}


@end

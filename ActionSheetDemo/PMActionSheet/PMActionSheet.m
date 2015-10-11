//
//  PMActionSheet.m
//  ActionSheetDemo
//
//  Created by majian on 15/10/10.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "PMActionSheet.h"

#define kPMContainerViewWidthRatio 0.95
#define kPMAnimationDuration 0.5
#define kPMContainerViewCornerRadius 5
#define kPMSpaceBetweenContentViewAndCancelButton 10
#define kPMCancelButtonHeight 44
#define kPMTitleLabelHeight 20

@interface PMActionSheet (PrivateMethod)

- (void)initSubviews;
- (void)initCustomView;
- (void)initTitleLabel;
- (void)initCancelButton;
- (void)deallocSubvies;
- (void)backgroundViewTapGesAction:(UITapGestureRecognizer *)tapGes;
- (void)showAnimation;
- (void)hideAnimation;
- (void)cancelButtonAction:(UIButton *)button;

@end

@interface PMActionSheet () {
    CGFloat _containerWidth;
    CGFloat _containerHeight;
    CGFloat _titleHeight;
}

@property (nonatomic, strong) UIView * backgroundView;
@property (nonatomic, strong) UIView * containerView;
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) UIView * customView;
@property (nonatomic, strong) UIButton * cancelButton;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, copy) NSString * title;

@end

@implementation PMActionSheet
#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleHeight = 0;
        _containerHeight = 0;
        
        _containerWidth = CGRectGetWidth(self.frame) * kPMContainerViewWidthRatio;
    }
    return self;
}

- (void)dealloc {
    [self deallocSubvies];
}

#pragma mark - Public Method
- (id)initWithButtonCount:(NSUInteger)buttonCount withTitle:(NSString *)title{
    if (self = [self initWithFrame:[UIScreen mainScreen].bounds]) {
        
    }
    
    return self;
}

- (void)show {
    [self initSubviews];
    UIWindow * keyWindow = [[UIApplication sharedApplication].windows firstObject];
    [keyWindow addSubview:self];
    [self showAnimation];
}

- (void)hide {
    [self hideAnimation];
}

- (void)cancel {
    [self hideAnimation];
    if ([self.delegate respondsToSelector:@selector(actionSheetDidCancelled:)]) {
        [self.delegate actionSheetDidCancelled:self];
    }
}

#pragma mark - Lazy Initializatoin
- (UIView *)backgroundView {
    if (_backgroundView) {
        return _backgroundView;
    }
    
    _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    _backgroundView.backgroundColor = [UIColor grayColor];
    _backgroundView.alpha = 0;
    
    UITapGestureRecognizer * backgroundViewTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTapGesAction:)];
    [_backgroundView addGestureRecognizer:backgroundViewTapGes];
    
    return _backgroundView;
}

- (UIView *)containerView {
    if (_containerView) {
        return _containerView;
    }
    
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = [UIColor clearColor];
    _containerView.layer.masksToBounds = YES;
    _containerView.layer.cornerRadius = kPMContainerViewCornerRadius;
    
    return _containerView;
}

- (UIButton *)cancelButton {
    if (_cancelButton) {
        return _cancelButton;
    }
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    _cancelButton.backgroundColor = [UIColor whiteColor];
    [_cancelButton setTitle:@"Cancel"
                   forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor redColor]
                        forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelButtonAction:)
            forControlEvents:UIControlEventTouchUpInside];
    
    return _cancelButton;
}

- (UIView *)contentView {
    if (_contentView) {
        return _contentView;
    }
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    
    return _contentView;
}

- (UILabel *)titleLabel {
    if (_titleLabel) {
        return _titleLabel;
    }
    
    _titleLabel = [[UILabel alloc] init];
    
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.backgroundColor = [UIColor orangeColor];
    _titleLabel.text = self.title;
    
    return _titleLabel;
}

@end

@implementation PMActionSheet (PrivateMethod)

- (void)deallocSubvies {
    _containerHeight = 0;
    _titleHeight = 0;
    _backgroundView = nil;
    _containerView = nil;
    _contentView = nil;
    _cancelButton = nil;
    _titleLabel = nil;
    _title = nil;
}

- (void)initSubviews {
//    初始化过程：
//    1、初始化backgroundView
        [self addSubview:self.backgroundView];
//    2、初始化customView
        [self initCustomView];
//    3、初始化cancelButton
        [self initCancelButton];
//    4、初始化titleLabel
        [self initTitleLabel];
//    5、初始化containerView
//    6、设置frame
        self.containerView.frame = CGRectMake((CGRectGetWidth(self.bounds) - _containerWidth) / 2, CGRectGetHeight(self.bounds) - _containerHeight, _containerWidth, _containerHeight);
        self.cancelButton.frame = CGRectMake(0, _containerHeight - kPMCancelButtonHeight, _containerWidth, kPMCancelButtonHeight);
    
        self.contentView.frame = CGRectMake(0, 0, _containerWidth, _containerHeight - kPMCancelButtonHeight - kPMSpaceBetweenContentViewAndCancelButton);
        self.titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), _titleHeight);
        self.customView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.customView.frame));
//    7、将titleLabel、customView添加到contentView
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.customView];
//    8、将cancelButton、contentView添加到containerView上
    [self.containerView addSubview:self.cancelButton];
    [self.containerView addSubview:self.contentView];
//    9、将containerView添加到self上
    [self addSubview:self.containerView];
}

- (void)initCustomView {
    if ([self.delegate respondsToSelector:@selector(customViewForActionSheet:width:)]) {
        self.customView = [self.delegate customViewForActionSheet:self
                                                            width:_containerWidth];
        _containerHeight += CGRectGetHeight(self.customView.bounds);
        [self.contentView addSubview:self.customView];
    }
}

- (void)initTitleLabel {
    if ([self.delegate respondsToSelector:@selector(titleForActionSheet:)]) {
        self.title = [self.delegate titleForActionSheet:self];
        _titleHeight = self.title == nil ? 0 : kPMCancelButtonHeight;
        _containerHeight += _titleHeight;
    }
}

- (void)initCancelButton {
    _containerHeight += kPMCancelButtonHeight + kPMSpaceBetweenContentViewAndCancelButton;
}

- (void)cancelButtonAction:(UIButton *)button {
    [self cancel];
}

- (void)showAnimation {
    [UIView animateWithDuration:kPMAnimationDuration animations:^{
        
        CGFloat y = CGRectGetHeight(self.bounds) - _containerHeight;
        CGRect tempRect = self.containerView.frame;
        tempRect.origin.y = y;
        self.containerView.frame = tempRect;
        
        self.backgroundView.alpha = 0.5;
    } completion:nil];
}

- (void)hideAnimation {
    [UIView animateWithDuration:kPMAnimationDuration animations:^{

        CGRect tempRect = self.containerView.frame;
        tempRect.origin.y = CGRectGetHeight(self.bounds);
        self.containerView.frame = tempRect;
        
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        [self deallocSubvies];
    }];
}

- (void)backgroundViewTapGesAction:(UITapGestureRecognizer *)tapGes {
    [self cancel];
}

@end







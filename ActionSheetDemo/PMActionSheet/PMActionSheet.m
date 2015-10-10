//
//  PMActionSheet.m
//  ActionSheetDemo
//
//  Created by majian on 15/10/10.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "PMActionSheet.h"

#define kPMContainerViewHeight 400
#define kPMContainerViewWidthRatio 0.95
#define kPMAnimationDuration 0.5
#define kPMContainerViewCornerRadius 5
#define kPMSpaceBetweenContentViewAndCancelButton 10
#define kPMCancelButtonHeight 44
#define kPMTitleLabelHeight 30

@interface PMActionSheet (PrivateMethod)

- (void)initCustomView;
- (void)initSubviews;
- (void)deallocSubvies;
- (void)backgroundViewTapGesAction:(UITapGestureRecognizer *)tapGes;
- (void)showAnimation;
- (void)hideAnimation;
- (void)cancelButtonAction:(UIButton *)button;

@end

@interface PMActionSheet () {
    CGFloat _containerWidth;
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

- (void)dealloc {
    [self deallocSubvies];
    NSLog(@"dealloc");
}

#pragma mark - Public Method
- (id)initWithButtonCount:(NSUInteger)buttonCount withTitle:(NSString *)title{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        
        _containerWidth = CGRectGetWidth(self.frame) * kPMContainerViewWidthRatio;
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
    
    CGFloat x = (CGRectGetWidth(self.bounds) * (1 - kPMContainerViewWidthRatio)) / 2;

    _containerView = [[UIView alloc] initWithFrame:CGRectMake(x, CGRectGetHeight(self.bounds), _containerWidth, kPMContainerViewHeight)];
    _containerView.backgroundColor = [UIColor clearColor];
    _containerView.layer.masksToBounds = YES;
    _containerView.layer.cornerRadius = kPMContainerViewCornerRadius;

    [_containerView addSubview:self.contentView];
    [_containerView addSubview:self.cancelButton];
    
    return _containerView;
}

- (UIButton *)cancelButton {
    if (_cancelButton) {
        return _cancelButton;
    }
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    CGRect frame = CGRectMake(0,  kPMContainerViewHeight - kPMCancelButtonHeight, _containerWidth, kPMCancelButtonHeight);
    _cancelButton.frame = frame;
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
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _containerWidth, kPMContainerViewHeight - kPMCancelButtonHeight - kPMSpaceBetweenContentViewAndCancelButton)];
    _contentView.backgroundColor = [UIColor whiteColor];
    
    [_contentView addSubview:self.titleLabel];
    
    return _contentView;
}

- (UILabel *)titleLabel {
    if (_titleLabel) {
        return _titleLabel;
    }
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _containerWidth, kPMTitleLabelHeight)];
    
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.backgroundColor = [UIColor orangeColor];
    _titleLabel.text = self.title;
    
    return _titleLabel;
}

@end

@implementation PMActionSheet (PrivateMethod)

- (void)deallocSubvies {
    _backgroundView = nil;
    _containerView = nil;
    _contentView = nil;
    _cancelButton = nil;
    _titleLabel = nil;
    _title = nil;
}

- (void)initSubviews {
    if ([self.delegate respondsToSelector:@selector(titleForActionSheet:)]) {
        self.title = [self.delegate titleForActionSheet:self];
    }
    
    [self addSubview:self.backgroundView];
    [self initCustomView];
    [self addSubview:self.containerView];
}

- (void)initCustomView {
    if ([self.delegate respondsToSelector:@selector(customViewForActionSheet:bounds:)]) {
        CGFloat height = kPMContainerViewHeight - CGRectGetHeight(self.titleLabel.bounds) - kPMCancelButtonHeight - kPMSpaceBetweenContentViewAndCancelButton;
        self.customView = [self.delegate customViewForActionSheet:self bounds:CGRectMake(0, 0, _containerWidth, height)];
        CGRect frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), _containerWidth, height);
        self.customView.frame = frame;
        [self.contentView addSubview:self.customView];
    }
}

- (void)cancelButtonAction:(UIButton *)button {
    [self hide];
}

- (void)showAnimation {
    [UIView animateWithDuration:kPMAnimationDuration animations:^{
        
        CGFloat y = CGRectGetHeight(self.bounds) - kPMContainerViewHeight;
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
        
        if ([self.delegate respondsToSelector:@selector(actionSheetDidCancelled:)]) {
            [self.delegate actionSheetDidCancelled:self];
        }
        
        [self deallocSubvies];
    }];
}

- (void)backgroundViewTapGesAction:(UITapGestureRecognizer *)tapGes {
    [self hide];
}

@end







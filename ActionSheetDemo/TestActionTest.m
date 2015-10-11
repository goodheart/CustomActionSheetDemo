//
//  TestActionTest.m
//  ActionSheetDemo
//
//  Created by majian on 15/10/11.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "TestActionTest.h"

@interface TestActionTest ()<PMActionSheetConfigurationDelegate>

@end

@implementation TestActionTest
@dynamic delegate;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.configurationDelegate = self;
    }
    return self;
}

//新浪 QQ空间 QQ 微信 微信朋友圈
- (UIView *)customViewForActionSheet:(PMActionSheet *)actionSheet width:(CGFloat)width {
    UIView * view = [[UIView alloc] init];
    //    CGFloat space = 10;
    NSUInteger totalCount = 10;
    NSUInteger everyRowCount = 3;
    CGFloat btnWidth = 60;
    CGFloat columnSpace = 15;
    CGFloat rowSpace = (width - everyRowCount * btnWidth) / (everyRowCount + 1);
    UIButton * lastButton = nil;
    for (NSUInteger index = 0; index < totalCount; index++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0
                                              green:arc4random() % 255 / 255.0
                                               blue:arc4random() % 255 / 255.0
                                              alpha:1.0];
        
        NSUInteger row = index / everyRowCount;
        NSUInteger column = index % everyRowCount;
        btn.frame = CGRectMake(rowSpace + column * (btnWidth + rowSpace), columnSpace + row * (btnWidth + columnSpace), btnWidth, btnWidth);
        btn.tag = index;
        [btn addTarget:self
                action:@selector(btnAction:)
      forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
        lastButton = btn;
    }
    
    view.frame = CGRectMake(0, 0, width, CGRectGetMaxY(lastButton.frame) + columnSpace);
    
    return view;
}

- (void)btnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(actionSheet:didSelectItemAtIndex:)]) {
        [self.delegate actionSheet:self
              didSelectItemAtIndex:sender.tag];
    }
    [self hide];
}

- (NSString *)titleForActionSheet:(PMActionSheet *)actionSheet {
    return nil;
}

@end

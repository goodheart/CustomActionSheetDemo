//
//  ShareActionSheet.m
//  ActionSheetDemo
//
//  Created by majian on 15/10/11.
//  Copyright © 2015年 majian. All rights reserved.
//

#import <ShareSDK/ShareSDK.h>
#import "PMShareActionSheet.h"
#import "PMImageTextButton.h"

@interface PMShareActionSheet ()<PMActionSheetConfigurationDelegate>

@end

@implementation PMShareActionSheet
@synthesize delegate;
#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.configurationDelegate = self;
        self.sharePlatformType = PMSharePlatformTypeAll;
    }
    return self;
}

#pragma mark - PMActionSheetConfigurationDelegate
- (UIView *)customViewForActionSheet:(PMActionSheet *)actionSheet width:(CGFloat)width {
    UIView * customView = [[UIView alloc] init];

    NSUInteger totalCount = self.sharePlatformType == PMSharePlatformTypeAll ? PMSharePlatformTypeAll : 1;
    NSUInteger everyRowCount = 3;
    CGFloat btnWidth = 80;
    CGFloat btnHeight = 120;
    CGFloat columnSpace = 15;
    CGFloat rowSpace = (width - everyRowCount * btnWidth) / (everyRowCount + 1);
    PMImageTextButton * lastButton = nil;
    for (NSUInteger index = 0; index < totalCount; index++) {
        NSUInteger curIndex = self.sharePlatformType == PMSharePlatformTypeAll ? index : self.sharePlatformType;
        
        PMImageTextButton * btn = [PMImageTextButton buttonWithType:UIButtonTypeCustom];
        
        btn.tag = curIndex;
        
        NSUInteger row = index / everyRowCount;
        NSUInteger column = index % everyRowCount;
        btn.frame = CGRectMake(rowSpace + column * (btnWidth + rowSpace), columnSpace + row * (btnHeight + columnSpace), btnWidth, btnHeight);
        
        static char * shareImageArr[5] = {"mine_qq","share_icon_kongjian","mine_weibo","mine_weixin",
            "share_icon_pengyouquan"};

        NSString * imgName = [NSString stringWithCString:shareImageArr[curIndex]
                                                encoding:NSUTF8StringEncoding];
        UIImage * image = [UIImage imageNamed:imgName];
        [btn setImage:image
             forState:UIControlStateNormal];
        
        static char * shareNameArr[5] = {"QQ","QQ空间","新浪微博","微信好友","微信朋友圈"};

        [btn setTitle:[NSString stringWithCString:shareNameArr[curIndex]
                                         encoding:NSUTF8StringEncoding]
             forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        [btn addTarget:self
                action:@selector(shareButtonAction:)
      forControlEvents:UIControlEventTouchUpInside];
        
        [customView addSubview:btn];
        
        lastButton = btn;
    }
    
    customView.frame = CGRectMake(0, 0, width, CGRectGetMaxY(lastButton.frame) + columnSpace);
    
    return customView;
}

- (void)shareButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(actionSheet:didSelectSharePlatForm:)]) {
        static int shareSDKPlatFormTypeArr[5] = {ShareTypeQQ,ShareTypeQQSpace,ShareTypeSinaWeibo,ShareTypeWeixiSession,ShareTypeWeixiTimeline};
        [self.delegate actionSheet:self
            didSelectSharePlatForm:shareSDKPlatFormTypeArr[sender.tag]];
    }
}


@end

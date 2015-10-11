//
//  PMActionSheet.h
//  ActionSheetDemo
//
//  Created by majian on 15/10/10.
//  Copyright © 2015年 majian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PMActionSheet;

@protocol PMActionSheetConfigurationDelegate <NSObject>

@required
- (UIView *)customViewForActionSheet:(PMActionSheet *)actionSheet
                               width:(CGFloat)width;

@optional
- (NSString *)titleForActionSheet:(PMActionSheet *)actionSheet;


@end

@protocol PMActionSheetDelegate <NSObject>

@optional
- (void)actionSheetDidCancelled:(PMActionSheet *)actionSheet;

@end

@interface PMActionSheet : UIView
/*
    开放接口：
        1、初始化
        2、展示
        3、隐藏
        4、取消
    初始化过程：
        1、初始化backgroundView
        2、初始化customView
        3、初始化cancelButton
        4、初始化titleLabel
        5、初始化containerView
        6、设置frame
        7、将titleLabel、customView添加到contentView
        8、将cancelButton、contentView添加到containerView上
        9、将containerView添加到self上
 */
@property (nonatomic,weak) id<PMActionSheetConfigurationDelegate> configurationDelegate;
@property (nonatomic,weak) id<PMActionSheetDelegate> delegate;

- (void)show;
- (void)hide;
- (void)cancel;

@end









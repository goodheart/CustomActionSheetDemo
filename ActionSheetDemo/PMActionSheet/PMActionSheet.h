//
//  PMActionSheet.h
//  ActionSheetDemo
//
//  Created by majian on 15/10/10.
//  Copyright © 2015年 majian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PMActionSheet;
@protocol PMActionSheetDelegate <NSObject>
@required
- (UIView *)customViewForActionSheet:(PMActionSheet *)actionSheet
                              bounds:(CGRect)bounds;
- (NSString *)titleForActionSheet:(PMActionSheet *)actionSheet;

@optional
- (void)actionSheetDidCancelled:(PMActionSheet *)actionSheet;
@end

@interface PMActionSheet : UIView
/*
    开放接口：
        1、初始化
        2、展示
        3、隐藏
 */
@property (nonatomic,weak) id<PMActionSheetDelegate> delegate;
- (id)initWithButtonCount:(NSUInteger)buttonCount withTitle:(NSString *)title;

- (void)show;
- (void)hide;

@end

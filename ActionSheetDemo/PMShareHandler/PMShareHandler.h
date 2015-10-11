//
//  PMShareHandler.h
//  ActionSheetDemo
//
//  Created by majian on 15/10/11.
//  Copyright © 2015年 majian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMShareContent.h"
@class PMShareHandler;
@protocol PMShareHandlerDelegate <NSObject>

@optional
- (void)shareHandler:(PMShareHandler *)shareHandler didShareSuccessForPlatform:(NSString *)platform;
- (void)shareHandler:(PMShareHandler *)shareHandler didShareFailForPlatform:(NSString *)platform;
- (void)shareHandler:(PMShareHandler *)shareHandler didCancelShareForPlatform:(NSString *)platform;

@end

@interface PMShareHandler : NSObject
/*
    业务方传入：分享的内容、图片、标题、链接、描述、类型
    提供的接口
        传入分享的内容
 */

@property (nonatomic,weak) id<PMShareHandlerDelegate> delegate;

- (void)shareWithContent:(PMShareContent *)content;

@end









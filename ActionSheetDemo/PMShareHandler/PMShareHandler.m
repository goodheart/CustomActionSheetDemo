//
//  PMShareHandler.m
//  ActionSheetDemo
//
//  Created by majian on 15/10/11.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "PMShareHandler.h"
#import "PMShareContent.h"

@interface PMShareHandler ()<PMShareActionSheetDelegate>

@property (nonatomic,strong) PMShareActionSheet * shareActionSheet;
@property (nonatomic,strong) PMShareContent * shareContent;

@end

@implementation PMShareHandler

#pragma mark - Public Method
- (void)shareWithContent:(PMShareContent *)content {
    self.shareContent = content;
    self.shareActionSheet.sharePlatformType = content.sharePlatformType;
    [self.shareActionSheet show];
}

#pragma mark - PMShareActionSheetDelegate
- (void)actionSheetDidCancelled:(PMActionSheet *)actionSheet {
    if ([self.delegate respondsToSelector:@selector(shareHandler:didCancelShareForPlatform:)]) {
        [self.delegate shareHandler:self
          didCancelShareForPlatform:nil];
    }
}

- (void)actionSheet:(PMActionSheet *)actionSheet didSelectSharePlatForm:(ShareType)sharePlatform {

    //构造分享内容
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    id<ISSContent> publishContent = [ShareSDK content:self.shareContent.content
                                       defaultContent:self.shareContent.defaultContent
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:self.shareContent.title
                                                  url:self.shareContent.url
                                          description:self.shareContent.descriptionContent
                                            mediaType:self.shareContent.mediaType];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
        [container setIPadContainerWithView:[[UIApplication sharedApplication].windows firstObject] arrowDirect:UIPopoverArrowDirectionUp];
    
    [ShareSDK showShareViewWithType:sharePlatform
                          container:container
                            content:publishContent
                      statusBarTips:YES
                        authOptions:nil
                       shareOptions:nil
                             result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                 
     static char * shareNameArr[5] = {"QQ","QQ空间","新浪微博","微信好友","微信朋友圈"};
     NSString * platform = nil;
     char * platformCString = shareNameArr[sharePlatform];
     if (NULL != platformCString) {
         platform = [NSString stringWithCString:platformCString
                                       encoding:NSUTF8StringEncoding];
     }

         switch (state) {
             case SSResponseStateCancel:
                 if ([self.delegate respondsToSelector:@selector(shareHandler:didCancelShareForPlatform:)]) {
                     [self.delegate shareHandler:self
                       didCancelShareForPlatform:platform];
                 }
             break;
                 
             case SSResponseStateFail:
                 if ([self.delegate respondsToSelector:@selector(shareHandler:didShareFailForPlatform:)]) {
                     [self.delegate shareHandler:self
                         didShareFailForPlatform:platform];
                 }
             break;
                 
             case SSResponseStateSuccess:
                 if ([self.delegate respondsToSelector:@selector(shareHandler:didShareSuccessForPlatform:)]) {
                     [self.delegate shareHandler:self
                      didShareSuccessForPlatform:platform];
                 }
             break;
                 
             default:
             break;
         }
                             }];
 }
     

#pragma mark - Lazy Initialization
- (PMShareActionSheet *)shareActionSheet {
    if (_shareActionSheet) {
        return _shareActionSheet;
    }
    
    _shareActionSheet = [[PMShareActionSheet alloc] init];
    _shareActionSheet.delegate = self;
    
    return _shareActionSheet;
}
@end

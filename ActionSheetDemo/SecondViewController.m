//
//  SecondViewController.m
//  ActionSheetDemo
//
//  Created by majian on 15/10/11.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "SecondViewController.h"
#import "PMShareHandler/PMShareHandler.h"
@interface SecondViewController ()<PMShareHandlerDelegate> {
    PMShareHandler * _shareHandler;
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _shareHandler = [[PMShareHandler alloc] init];
    _shareHandler.delegate = self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    PMShareContent * shareContent = [[PMShareContent alloc] init];
    shareContent.sharePlatformType = PMSharePlatformTypeAll;
//    shareContent.content = @"开始测试啦";
    shareContent.defaultContent = @"测试数据";
    shareContent.mediaType = SSPublishContentMediaTypeNews;
    shareContent.title = @"重大信息";
    shareContent.url = @"http://www.baidu.com";
    shareContent.descriptionContent = @"测试测试测试";
    [_shareHandler shareWithContent:shareContent];
}


#pragma mark - PMShareHandlerDelegate
- (void)shareHandler:(PMShareHandler *)shareHandler didCancelShareForPlatform:(NSString *)platform {
    NSLog(@"cancel");
}

- (void)shareHandler:(PMShareHandler *)shareHandler didShareSuccessForPlatform:(NSString *)platform {
    NSLog(@"success");
}

- (void)shareHandler:(PMShareHandler *)shareHandler didShareFailForPlatform:(NSString *)platform {
    NSLog(@"faild");
}


@end












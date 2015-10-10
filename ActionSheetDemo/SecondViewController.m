//
//  SecondViewController.m
//  ActionSheetDemo
//
//  Created by majian on 15/10/11.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "SecondViewController.h"
#import "PMActionSheet.h"
@interface SecondViewController ()<PMActionSheetDelegate> {
    PMActionSheet * _actionSheet;
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    PMActionSheet * actionSheet = [[PMActionSheet alloc] initWithButtonCount:4
                                                            withTitle:@"分享至"];
    actionSheet.delegate = self;
    _actionSheet = actionSheet;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_actionSheet show];
}

- (void)tapGes {
    [_actionSheet hide];
}

#pragma mark - PMActionSheetDelegate
- (UIView *)customViewForActionSheet:(PMActionSheet *)actionSheet bounds:(CGRect)bounds {
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0
                                           green:arc4random() % 255 / 255.0
                                            blue:arc4random() % 255 / 255.0
                                           alpha:1.0];
    UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes)];
    [view addGestureRecognizer:tapGes];
    return view;
}

- (NSString *)titleForActionSheet:(PMActionSheet *)actionSheet {
    return [NSString stringWithFormat:@"这是标题%d",arc4random() % 100];
}

- (void)actionSheetDidCancelled:(PMActionSheet *)actionSheet {
    NSLog(@"didCancelled");
}
@end





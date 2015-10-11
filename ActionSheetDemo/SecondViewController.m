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

- (UIView *)customViewForActionSheet:(PMActionSheet *)actionSheet width:(CGFloat)width {
    UIView * view = [[UIView alloc] init];
    
    for (NSUInteger index = 0; index < 5; index++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0
                                              green:arc4random() % 255 / 255.0
                                               blue:arc4random() % 255 / 255.0
                                              alpha:1.0];
        btn.frame = CGRectMake(0, index * 44, width, 44);
        btn.tag = index;
        [btn addTarget:self
                action:@selector(btnAction:)
      forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    
    view.frame = CGRectMake(0, 0, width, 5 * 44);
    
    return view;
}

- (void)btnAction:(UIButton *)sender {
    NSLog(@"%ld",sender.tag);
    [_actionSheet hide];
}

- (NSString *)titleForActionSheet:(PMActionSheet *)actionSheet {
    return [NSString stringWithFormat:@"这是标题%d",arc4random() % 100];
//    return nil;
}

- (void)actionSheetDidCancelled:(PMActionSheet *)actionSheet {
    NSLog(@"didCancelled");
}


@end





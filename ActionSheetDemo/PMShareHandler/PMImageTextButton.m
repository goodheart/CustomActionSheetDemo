//
//  PMImageTextButton.m
//  ButtonDemo
//
//  Created by majian on 15/10/11.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "PMImageTextButton.h"

#define kPMTitleHeightRatio 0.2
#define kPMImageHeightRatio 0.7

@implementation PMImageTextButton


- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleHeight = CGRectGetHeight(contentRect) * kPMTitleHeightRatio;
    CGFloat titleWidth = CGRectGetWidth(contentRect);
    CGFloat y = CGRectGetHeight(contentRect) * (1 - kPMTitleHeightRatio);
    return CGRectMake(0, y, titleWidth, titleHeight);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageHeight = CGRectGetHeight(contentRect) * kPMImageHeightRatio;
    CGFloat imageWidth = CGRectGetWidth(contentRect);
    return CGRectMake(0, 0, imageWidth, imageHeight);
}


@end








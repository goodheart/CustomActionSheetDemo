//
//  PMShareContent.h
//  ActionSheetDemo
//
//  Created by majian on 15/10/11.
//  Copyright © 2015年 majian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMShareActionSheet.h"
@interface PMShareContent : NSObject

@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * defaultContent;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSString * descriptionContent;
@property (nonatomic,assign) SSPublishContentMediaType mediaType;
@property (nonatomic, assign) PMSharePlatformType sharePlatformType;

@end

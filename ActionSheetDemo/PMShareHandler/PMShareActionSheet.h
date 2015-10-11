//
//  ShareActionSheet.h
//
//
//  Created by majian on 15/10/11.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "PMActionSheet.h"
#import <ShareSDK/ShareSDK.h>


typedef NS_ENUM(NSUInteger,PMSharePlatformType) {
    PMSharePlatformTypeQQ,
    PMSharePlatformTypeQQSpace,
    PMSharePlatformTypeSinaWeibo,
    PMSharePlatformTypeWeixiSession,
    PMSharePlatformTypeWeixiTimeline,
    PMSharePlatformTypeAll //所有平台
};

@protocol PMShareActionSheetDelegate <PMActionSheetDelegate>

- (void)actionSheet:(PMActionSheet *)actionSheet didSelectSharePlatForm:(ShareType)sharePlatform;

@end

@interface PMShareActionSheet : PMActionSheet

@property (nonatomic, weak) id<PMShareActionSheetDelegate> delegate;
@property (nonatomic, assign) PMSharePlatformType sharePlatformType;

@end








//
//  TestActionTest.h
//  ActionSheetDemo
//
//  Created by majian on 15/10/11.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "PMActionSheet.h"

@protocol TestActionTestDelegate <PMActionSheetDelegate>

- (void)actionSheet:(PMActionSheet *)actionSheet didSelectItemAtIndex:(NSUInteger)index;

@end

@interface TestActionTest : PMActionSheet

@property (nonatomic,weak) id<TestActionTestDelegate> delegate;

@end

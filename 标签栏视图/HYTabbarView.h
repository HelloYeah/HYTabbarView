//
//  HYTabbarView.h
//  标签栏视图-多视图滑动点击切换
//
//  Created by Sekorm on 16/3/31.
//  Copyright © 2016年 HY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYTabbarView : UIView

/**
 *  添加一个子控制器
 */
- (void)addSubItemWithViewController:(UIViewController *)viewController;

//选中新增的item
- (void)selectNewItem;

@end

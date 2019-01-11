//
//  HYTabbarView.h
//  标签栏视图-多视图滑动点击切换
//
//  Created by Sekorm on 16/3/31.
//  Copyright © 2016年 HY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYTopBar.h"
@interface HYTabbarView : UIView
/** 标题栏*/
@property(nonatomic, strong)HYTopBar *topBar;

/** 页面与topBar的距离*/
@property(nonatomic, assign)CGFloat controllerWithTopBarMargin;
/**
 *  添加一个子控制器
 */
- (void)addSubItemWithViewController:(UIViewController *)viewController;

//选中新增的item
- (void)selectNewItem;

@end

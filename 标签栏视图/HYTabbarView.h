//
//  HYTabbarView.h
//  标签栏视图
//
//  Created by Sekorm on 16/3/31.
//  Copyright © 2016年 HY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYTabbarView : UIView

/**
 *  添加一个条目
 *
 *  @param viewController 把这个控制器的view添加到HYTabbarView中
 *  @param title          对应的标题
 */
- (void)addSubItemWithViewController:(NSString *)viewController title:(NSString *)title;

@end

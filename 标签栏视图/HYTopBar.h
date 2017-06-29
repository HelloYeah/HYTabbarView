//
//  HYTopBar.h
//  标签栏视图
//
//  Created by Sekorm on 2017/6/29.
//  Copyright © 2017年 HY. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HYScreenW [UIScreen mainScreen].bounds.size.width
#define HYScreenH [UIScreen mainScreen].bounds.size.height
@class HYTopBar;
@protocol HYTopBarDelegate <NSObject>
- (void)HYTopBarChangeSelectedItem:(HYTopBar *)topbar selectedIndex:(NSInteger)index;
@end

@interface HYTopBar : UIScrollView

@property (nonatomic,weak) id<HYTopBarDelegate> topBarDelegate;

- (void)addTitleBtn:(NSString *)title;
- (void)setSelectedItem:(NSInteger)index;

@end

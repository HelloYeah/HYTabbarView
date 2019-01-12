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
- (void)HYTopBarChangeContentViewHeight;
@end

@interface HYTopBar : UIScrollView

@property (nonatomic,weak) id<HYTopBarDelegate> topBarDelegate;

/** 标题之间的间距*/
@property(nonatomic, assign)CGFloat topBarItemMargin;

/** 顶部标签条的高度*/
@property(nonatomic, assign)CGFloat topBarHeight;


/***********指示条**************/

/** 指示条与标题的距离*/
@property(nonatomic, assign)CGFloat indicatorWithItemMargin;

/** 指示条颜色*/
@property(nonatomic, strong)UIColor *indicatorBackgroundColor;

/** 指示条高度*/
@property(nonatomic, assign)CGFloat indicatorHeight;

/** 指示条的宽度是否随标题的宽度变化，默认值为NO*/
@property(nonatomic, assign)BOOL changeWithItemWidth;

/** 指示条宽度，默认值为30，如果宽度需要随标题的宽度变化，则不需要设置*/
@property(nonatomic, assign)CGFloat indicatorWidth;


/***************标题*****************/

/** 第一个标题X坐标*/
@property(nonatomic, assign)CGFloat firstItemX;

/** 标题高度*/
@property(nonatomic, assign)CGFloat itemHeight;

/** 标题颜色*/
@property(nonatomic, strong)UIColor *itemNormalColor;

/** 标题选中颜色*/
@property(nonatomic, strong)UIColor *itemSelectedColor;

/** 标题字体大小*/
@property(nonatomic, strong)UIFont *itemNormalFont;

/** 标题选中字体大小*/
@property(nonatomic, strong)UIFont *itemSelectedFont;

- (void)addTitleBtn:(NSString *)title;
- (void)setSelectedItem:(NSInteger)index;

@end

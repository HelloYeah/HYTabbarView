//
//  HYTopBar.m
//  标签栏视图
//
//  Created by Sekorm on 2017/6/29.
//  Copyright © 2017年 HY. All rights reserved.
//

#import "HYTopBar.h"

//static CGFloat const topBarItemMargin = 22.5; ///标题之间的间距
//static CGFloat const topBarHeight = 18; //顶部标签条的高度

@interface HYTopBar()
@property (nonatomic,strong) NSMutableArray *btnArray;
@property (nonatomic,strong) UIButton *selectedBtn;
/** 滑动的横线*/
@property(nonatomic, strong)UIView *indicatorView;
@end

@implementation HYTopBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        
        // 滑动条
        UIView *indicatorView = [[UIView alloc] init];
        self.indicatorView = indicatorView;
        [self addSubview:indicatorView];
    }
    return self;
}

- (void)addTitleBtn:(NSString *)title {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.titleLabel.font = self.itemNormalFont;
    [btn setTitleColor:self.itemNormalColor forState:UIControlStateNormal];
    [btn setTitleColor:self.itemSelectedColor forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(itemSelectedChange:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [self.btnArray addObject:btn];
    
    [self layoutIfNeeded];
}

- (void)itemSelectedChange:(UIButton *)btn {
    
    NSInteger index = [self.btnArray indexOfObject:btn];
    if ([self.topBarDelegate respondsToSelector:@selector(HYTopBarChangeSelectedItem:selectedIndex:)]) {
        [self.topBarDelegate HYTopBarChangeSelectedItem:self selectedIndex:index];
    }
}

- (void)setSelectedItem:(NSInteger)index {
    
    UIButton *btn = self.btnArray[index];
    
    //    btn.titleLabel.font = self.itemSelectedFont;
    [UIView animateWithDuration:0.25 animations:^{
        
        self.selectedBtn.selected = NO;
        self.selectedBtn.titleLabel.font = self.itemNormalFont;
        
        btn.selected = YES;
        btn.titleLabel.font = self.itemSelectedFont;
        self.selectedBtn = btn;
        
        if (self.changeWithItemWidth) {
            CGRect newFrame = self.indicatorView.frame;
            newFrame.size.width = btn.frame.size.width;
            self.indicatorView.frame = newFrame;
        }
        
        
        CGPoint newCenter = self.indicatorView.center;
        newCenter.x = btn.center.x;
        self.indicatorView.center = newCenter;
        
        // 计算偏移量
        CGFloat offsetX = btn.center.x - HYScreenW * 0.5;
        if (offsetX < 0) offsetX = 0;
        // 获取最大滚动范围
        CGFloat maxOffsetX = self.contentSize.width - HYScreenW;
        if (offsetX > maxOffsetX) offsetX = maxOffsetX;
        
        if (self.contentSize.width > [UIScreen mainScreen].bounds.size.width) {
            // 滚动标题滚动条
            [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        }
    }];
}
- (void)setTopBarHeight:(CGFloat)topBarHeight{
    _topBarHeight = topBarHeight;
    if ([self.topBarDelegate respondsToSelector:@selector(HYTopBarChangeContentViewHeight)]) {
        [self.topBarDelegate HYTopBarChangeContentViewHeight];
    }
}
- (NSMutableArray *)btnArray{
    
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (void)layoutSubviews {
    NSLog(@"-----layoutSubviews");
    [super layoutSubviews];
    self.indicatorView.backgroundColor = self.indicatorBackgroundColor;
    
    CGRect newFrame = self.indicatorView.frame;
    newFrame.size.height = self.indicatorHeight;
    self.indicatorView.frame = newFrame;
    
    CGFloat radius = self.indicatorView.frame.size.height * 0.5;
    self.indicatorView.layer.cornerRadius = radius;
    
    if((!self.changeWithItemWidth) && self.indicatorWidth != 0){
        CGRect newFrame = self.indicatorView.frame;
        newFrame.size.width = self.indicatorWidth;
        self.indicatorView.frame = newFrame;
    }else if(self.indicatorWidth == 0 && !self.changeWithItemWidth){
        CGRect newFrame = self.indicatorView.frame;
        newFrame.size.width = 30;
        self.indicatorView.frame = newFrame;
    }
    
    CGFloat btnX = self.firstItemX;
    for (int i = 0 ; i < self.btnArray.count; i++) {
        
        UIButton *btn = self.btnArray[i];
        CGRect titileSize = [btn.titleLabel.text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.itemSelectedFont} context:nil];
        
        btn.frame = CGRectMake(btnX, 0, btn.frame.size.width, titileSize.size.height);
        btnX += btn.frame.size.width + self.topBarItemMargin;
        
        CGRect newFrame = self.indicatorView.frame;
        newFrame.origin.y = CGRectGetMaxY(btn.frame) + self.indicatorWithItemMargin;
        self.indicatorView.frame = newFrame;
        
    }
    self.contentSize = CGSizeMake(btnX, 0);
}
@end

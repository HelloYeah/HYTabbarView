//
//  ViewController.m
//  标签栏视图
//
//  Created by Sekorm on 16/3/31.
//  Copyright © 2016年 HY. All rights reserved.
//

#import "ViewController.h"
#import "HYTabbarView.h"
#import "TestViewController.h"

@interface ViewController ()
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) HYTabbarView * tabbarView;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.tabbarView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.index = 0;
}

- (IBAction)newItem {
    
    TestViewController *vc0 = [[TestViewController alloc]init];
    vc0.title = [NSString stringWithFormat:@"NewItem-%02ld",self.index];
    self.index++;
    [_tabbarView addSubItemWithViewController:vc0];
    [_tabbarView selectNewItem];
}

//懒加载
- (HYTabbarView *)tabbarView{
    
    if (!_tabbarView) {
        _tabbarView = ({
            
            HYTabbarView *tabbarView = [[HYTabbarView alloc]initWithFrame:CGRectMake(0, 120, HYScreenW, HYScreenH - 120 - 44 - 20)];
            tabbarView.controllerWithTopBarMargin = 7;
            tabbarView.topBar.topBarHeight = 30;
            tabbarView.topBar.topBarItemMargin = 22.5;
            tabbarView.topBar.indicatorWithItemMargin = 6;
            tabbarView.topBar.indicatorBackgroundColor = [UIColor orangeColor];
            tabbarView.topBar.indicatorHeight = 3;
//            tabbarView.topBar.indicatorWidth = 50;
            //    tabbarView.topBar.changeWithItemWidth = YES;
            tabbarView.topBar.firstItemX = 15;
            tabbarView.topBar.itemNormalColor = [UIColor blackColor];
            tabbarView.topBar.itemSelectedColor = [UIColor greenColor];
            tabbarView.topBar.itemNormalFont = [UIFont systemFontOfSize:15];
            tabbarView.topBar.itemSelectedFont = [UIFont systemFontOfSize:18];
            
            [self.view addSubview:tabbarView];
            
            
            TestViewController * vc0 = [[TestViewController alloc]init];
            vc0.title = @"推荐";
            [tabbarView addSubItemWithViewController:vc0];
            
            TestViewController * vc1 = [[TestViewController alloc]init];
            vc1.title = @"热点";
            [tabbarView addSubItemWithViewController:vc1];
            
            TestViewController * vc2 = [[TestViewController alloc]init];
            vc2.title = @"视频";
            [tabbarView addSubItemWithViewController:vc2];
            
            TestViewController * vc3 = [[TestViewController alloc]init];
            vc3.title = @"中国好声音";
            [tabbarView addSubItemWithViewController:vc3];

            TestViewController * vc4 = [[TestViewController alloc]init];
            vc4.title = @"数码";
            [tabbarView addSubItemWithViewController:vc4];
            
            TestViewController * vc5 = [[TestViewController alloc]init];
            vc5.title = @"头条号";
            [tabbarView addSubItemWithViewController:vc5];
            
            TestViewController * vc6 = [[TestViewController alloc]init];
            vc6.title = @"房产";
            [tabbarView addSubItemWithViewController:vc6];
            
            TestViewController * vc7 = [[TestViewController alloc]init];
            vc7.title = @"奥运会";
            [tabbarView addSubItemWithViewController:vc7];
            
            TestViewController * vc8 = [[TestViewController alloc]init];
            vc8.title = @"时尚";
            [tabbarView addSubItemWithViewController:vc8];
            
            tabbarView;
        });
    }
    return _tabbarView;
}

@end

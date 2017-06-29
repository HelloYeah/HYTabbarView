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
            
            HYTabbarView * tabbar = [[HYTabbarView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
            
            TestViewController * vc0 = [[TestViewController alloc]init];
            vc0.title = @"推荐";
            [tabbar addSubItemWithViewController:vc0];
            
            TestViewController * vc1 = [[TestViewController alloc]init];
            vc1.title = @"热点";
            [tabbar addSubItemWithViewController:vc1];
            
            TestViewController * vc2 = [[TestViewController alloc]init];
            vc2.title = @"视频";
            [tabbar addSubItemWithViewController:vc2];
            
            TestViewController * vc3 = [[TestViewController alloc]init];
            vc3.title = @"中国好声音";
            [tabbar addSubItemWithViewController:vc3];

            TestViewController * vc4 = [[TestViewController alloc]init];
            vc4.title = @"数码";
            [tabbar addSubItemWithViewController:vc4];
            
            TestViewController * vc5 = [[TestViewController alloc]init];
            vc5.title = @"头条号";
            [tabbar addSubItemWithViewController:vc5];
            
            TestViewController * vc6 = [[TestViewController alloc]init];
            vc6.title = @"房产";
            [tabbar addSubItemWithViewController:vc6];
            
            TestViewController * vc7 = [[TestViewController alloc]init];
            vc7.title = @"奥运会";
            [tabbar addSubItemWithViewController:vc7];
            
            TestViewController * vc8 = [[TestViewController alloc]init];
            vc8.title = @"时尚";
            [tabbar addSubItemWithViewController:vc8];
            
            tabbar;
        });
    }
    return _tabbarView;
}

@end

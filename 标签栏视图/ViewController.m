//
//  ViewController.m
//  标签栏视图
//
//  Created by Sekorm on 16/3/31.
//  Copyright © 2016年 HY. All rights reserved.
//

#import "ViewController.h"
#import "HYTabbarView.h"

@interface ViewController ()

@property (nonatomic,strong) HYTabbarView * tabbarView;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.tabbarView];
}

//懒加载
- (HYTabbarView *)tabbarView{
    
    if (!_tabbarView) {
        _tabbarView = ({
            
            HYTabbarView * tabbar = [[HYTabbarView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
            
            UIViewController * vc0 = [[UIViewController alloc]init];
            vc0.title = @"推荐";
            [tabbar addSubItemWithViewController:vc0];
            
            UIViewController * vc1 = [[UIViewController alloc]init];
            vc1.title = @"热点";
            [tabbar addSubItemWithViewController:vc1];
            
            UIViewController * vc2 = [[UIViewController alloc]init];
            vc2.title = @"视频";
            [tabbar addSubItemWithViewController:vc2];
            
            UIViewController * vc3 = [[UIViewController alloc]init];
            vc3.title = @"中国好声音";
            [tabbar addSubItemWithViewController:vc3];
            
            UIViewController * vc4 = [[UIViewController alloc]init];
            vc4.title = @"数码";
            [tabbar addSubItemWithViewController:vc4];
            
            UIViewController * vc5 = [[UIViewController alloc]init];
            vc5.title = @"头条号";
            [tabbar addSubItemWithViewController:vc5];
            
            UIViewController * vc6 = [[UIViewController alloc]init];
            vc6.title = @"房产";
            [tabbar addSubItemWithViewController:vc6];
            
            UIViewController * vc7 = [[UIViewController alloc]init];
            vc7.title = @"奥运会";
            [tabbar addSubItemWithViewController:vc7];
            
            UIViewController * vc8 = [[UIViewController alloc]init];
            vc8.title = @"时尚";
            [tabbar addSubItemWithViewController:vc8];

            tabbar;
        });
    }
    return _tabbarView;
}

@end

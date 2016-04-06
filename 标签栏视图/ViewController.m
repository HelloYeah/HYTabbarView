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

//懒加载
- (HYTabbarView *)tabbarView{

    if (!_tabbarView) {
        _tabbarView = ({
            
            HYTabbarView * tabbar = [[HYTabbarView alloc]initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, 600)];
            [tabbar addSubItemWithViewController:@"UIViewController" title:@"第一个"];
            [tabbar addSubItemWithViewController:@"UIViewController" title:@"第二个"];
            [tabbar addSubItemWithViewController:@"UIViewController" title:@"第三个"];
            [tabbar addSubItemWithViewController:@"UIViewController" title:@"第四个"];
            [tabbar addSubItemWithViewController:@"UIViewController" title:@"第五个"];
            [tabbar addSubItemWithViewController:@"UIViewController" title:@"第六个"];
            [tabbar addSubItemWithViewController:@"UIViewController" title:@"第七个"];
            [tabbar addSubItemWithViewController:@"UIViewController" title:@"第八个"];
            [tabbar addSubItemWithViewController:@"UIViewController" title:@"第九个"];
            [tabbar addSubItemWithViewController:@"UIViewController" title:@"第十个"];
            tabbar;
        });
    }
    return _tabbarView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self.view addSubview:self.tabbarView];
}



@end

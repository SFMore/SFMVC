//
//  NavigationController.m
//  SFMVC
//
//  Created by zsf on 16/9/30.
//  Copyright © 2016年 zsf. All rights reserved.
//

#import "NavigationController.h"

#define kBarTintColor   [UIColor whiteColor]    //导航背景色
#define kTintColor      [UIColor blackColor]    //字体颜色
#define kTitleColor     [UIColor whiteColor]    //按钮颜色
#define kBarItemTextColor  [UIColor redColor] //字体颜色
#define kBarItemTextFont   14
#define kTitleFont 18
@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

+ (void)initialize
{
    // 统一设置UINavigationBar的颜色与字体颜色
    NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
    barAttrs[NSForegroundColorAttributeName] = kTintColor;
    barAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:kTitleFont];
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTitleTextAttributes:barAttrs];
    navBar.barTintColor = kBarTintColor;
    
    // 设置整个项目所有item的主题样式
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = kBarItemTextColor;
//    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:kBarItemTextFont];
//    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        //隐藏TabBarItem
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end

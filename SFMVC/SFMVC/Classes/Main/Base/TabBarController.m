//
//  TabBarController.m
//  SFMVC
//
//  Created by zsf on 16/10/8.
//  Copyright © 2016年 zsf. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"
#import "HomeController.h"
#import "MineController.h"
#import "LoginController.h"
#define kSelectTextColor    [UIColor redColor]
#define kNormalTextColor          [UIColor blackColor]
#define kItemTitleFont 11
@interface TabBarController ()

@end

@implementation TabBarController

+ (void)initialize
{
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *attriDict = [NSMutableDictionary new];
    attriDict[NSFontAttributeName] = [UIFont systemFontOfSize:kItemTitleFont];
    attriDict[NSForegroundColorAttributeName] = kNormalTextColor;
    
    NSMutableDictionary *attriSelectDict = [NSMutableDictionary new];
    attriSelectDict[NSFontAttributeName] = [UIFont systemFontOfSize:kItemTitleFont];
    attriSelectDict[NSForegroundColorAttributeName] = kSelectTextColor;
    
    [item setTitleTextAttributes:attriDict forState:UIControlStateNormal];
    [item setTitleTextAttributes:attriSelectDict forState:UIControlStateSelected];
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
  
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:childVc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    [self addChildViewController:nav];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeController *homeVc = [[HomeController alloc] init];
    [self addChildVc:homeVc title:@"首页" image:@"" selectedImage:@""];
   
    MineController *mineVc = [[MineController alloc] init];
    [self addChildVc:mineVc title:@"我的" image:@"" selectedImage:@""];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

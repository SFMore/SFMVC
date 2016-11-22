//
//  UINavigationController+Extension.m
//  SFMVC
//
//  Created by zsf on 16/10/10.
//  Copyright © 2016年 zsf. All rights reserved.
//

#import "UINavigationController+Extension.h"

@implementation UINavigationController (Extension)

/**
 *  @brief  寻找Navigation中的某个viewcontroler对象
 *
 *  @param className viewcontroler名称
 *
 *  @return viewcontroler对象
 */
- (id)findViewController:(NSString*)className
{
    for (UIViewController *viewController in self.viewControllers) {
        if ([viewController isKindOfClass:NSClassFromString(className)]) {
            return viewController;
        }
    }
    
    return nil;
}

/**
 *  @brief  返回指定的viewcontroler
 *
 *  @param className 指定viewcontroler类名
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)popToViewControllerWithClassName:(NSString*)className animated:(BOOL)animated;
{
    return [self popToViewController:[self findViewController:className] animated:YES];
}

- (void)addTitleTextAttributes:(NSDictionary *)dict
{
    [self.navigationBar setTitleTextAttributes:dict];
}
@end

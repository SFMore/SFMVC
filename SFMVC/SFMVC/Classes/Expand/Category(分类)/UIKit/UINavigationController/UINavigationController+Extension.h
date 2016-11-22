//
//  UINavigationController+Extension.h
//  SFMVC
//
//  Created by zsf on 16/10/10.
//  Copyright © 2016年 zsf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Extension)


/**
 *  @brief  寻找Navigation中的某个viewcontroler对象
 *
 *  @param className viewcontroler名称
 *
 *  @return viewcontroler对象
 */
- (id)findViewController:(NSString*)className;


/**
 *  @brief  返回指定的viewcontroler
 *
 *  @param className 指定viewcontroler类名
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)popToViewControllerWithClassName:(NSString*)className animated:(BOOL)animated;

/**设置导航标题属性*/
- (void)addTitleTextAttributes:(NSDictionary *)dict;
@end

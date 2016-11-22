//
//  UIBarButtonItem+Extension.h
//  SFMVC
//
//  Created by zsf on 16/10/11.
//  Copyright © 2016年 zsf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/**只有图片*/
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

/**只有文字*/
+ (instancetype)itemWithTitle:(NSString *)title font:(UIFont *)titleFont color:(UIColor *)titleColor target:(id)target action:(SEL)action;

+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**图片和文字(黑色)*/
+ (instancetype)itemWithTitle:(NSString *)title font:(UIFont *)titleFont image:(NSString *)imageName target:(id)target action:(SEL)action;
/**图片和文字(属性自定义)*/
+ (instancetype)itemWithTitle:(NSString *)title font:(UIFont *)titleFont color:(UIColor *)titleColor image:(NSString *)imageName target:(id)target action:(SEL)action;
@end

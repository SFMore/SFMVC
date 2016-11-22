//
//  UIBarButtonItem+Extension.m
//  SFMVC
//
//  Created by zsf on 16/10/11.
//  Copyright © 2016年 zsf. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
@implementation UIBarButtonItem (Extension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    if (highImage) {
        [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    }
    btn.size = btn.currentBackgroundImage.size;
    kAppLog(@"%@",NSStringFromCGSize(btn.size));
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:btn];
}

+ (instancetype)itemWithTitle:(NSString *)title font:(UIFont *)titleFont color:(UIColor *)titleColor target:(id)target action:(SEL)action
{
    UIBarButtonItem *buttonItem=[self itemWithTitle:title target:target action:action];
    if (titleColor && titleFont) {
        [buttonItem setTitleTextAttributes:@{
                                             NSForegroundColorAttributeName :titleColor ,
                                             NSFontAttributeName:titleFont}
                                  forState:UIControlStateNormal];
    }
    
    return buttonItem;
}


+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIBarButtonItem *buttonItem=[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    return buttonItem;
}

+ (instancetype)itemWithTitle:(NSString *)title font:(UIFont *)titleFont image:(NSString *)imageName target:(id)target action:(SEL)action
{
    return [self itemWithTitle:title font:titleFont color:[UIColor blackColor] image:imageName target:target action:action];
}

+ (instancetype)itemWithTitle:(NSString *)title font:(UIFont *)titleFont color:(UIColor *)titleColor image:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = titleFont;
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:btn];
}


@end

//
//  UIApplication+Extension.m
//  SFMVC
//
//  Created by zsf on 16/11/4.
//  Copyright © 2016年 zsf. All rights reserved.
//

#import "UIApplication+Extension.h"

@implementation UIApplication (Extension)
- (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    //  Getting topMost ViewController
    while ([topController presentedViewController])	topController = [topController presentedViewController];
    //  Returning topMost ViewController
    return topController;
}

//
- (UIViewController*)getCurrentViewConttoller
{
    UIViewController *currentViewController = [self topMostController];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    while (currentViewController.presentedViewController) {
        currentViewController = currentViewController.presentedViewController;
    }
    return currentViewController;
}
@end

//
//  BaseViewController.h
//  SFMVC
//
//  Created by zsf on 16/9/30.
//  Copyright © 2016年 zsf. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol  BaseViewControllerDelegate<NSObject>

@optional
/**设置导航背景色*/
- (UIColor *)setNavigationBarBackgroundColor;

/**是否隐藏导航底部黑线*/
- (BOOL)hideNavigationBottomLine;
@end

@interface BaseViewController : UIViewController<BaseViewControllerDelegate>

@end

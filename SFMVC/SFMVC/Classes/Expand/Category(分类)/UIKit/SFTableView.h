//
//  SFTableView.h
//  SFMVC
//
//  Created by zsf on 16/11/11.
//  Copyright © 2016年 zsf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SFRefreshState)
{
     /** 下拉刷新的状态 */
    SFRefreshStateRefreshing,
    
     /** 上拉刷新的状态 */
    SFRefreshStatePulling,
};

@protocol SFTableViewDelegate <NSObject>
@optional

- (void)loadDataRefreshOrPull:(SFRefreshState)state;

@end


@interface SFTableView : UITableView
/**
 *  是否展示空白页 默认为YES
 */
@property(nonatomic,assign)BOOL isShowEmpty;


/**
 *  空白页的标题 默认为 “" 为空不显示
 */
@property(nonatomic,copy) NSString *titleForEmpty;
/**
 *  空白页的副标题 默认为 “" 为空不显示
 */
@property(nonatomic,copy) NSString *descriptionForEmpty;
/**
 *  空白页展位图名称 默认为 “img_placehoder_icon" 为空或nil无图片
 */
@property(nonatomic,copy) NSString *imageNameForEmpty;


/**
 *  是否支持下拉刷新 默认为NO
 */
@property (nonatomic,assign) BOOL isRefresh;

/**
 *  是否可以加载更多 默认为NO
 */
@property (nonatomic,assign) BOOL isLoadMore;


/**
 *  TableView delegate
 */
@property (nonatomic,weak) id<SFTableViewDelegate>tableViewDelegate;


/**
 *  当前访问的page 下标
 */
@property (nonatomic,assign) NSInteger page;

/**
 *
 *  获取当下访问接口下标
 */
-(NSNumber *)getCurrentPage;

/**
 *  开始加载
 */
-(void)beginLoading;

/**
 *  结束刷新
 */
-(void)endLoading;
@end

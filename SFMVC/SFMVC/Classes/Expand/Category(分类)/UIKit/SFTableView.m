//
//  SFTableView.m
//  SFMVC
//
//  Created by zsf on 16/11/11.
//  Copyright © 2016年 zsf. All rights reserved.
//

#import "SFTableView.h"
#import "UIScrollView+EmptyDataSet.h"

@interface SFTableView ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/**
 *  是否第一次加载就展示空白页 默认为YES
 */
@property(nonatomic,assign)BOOL firstShowEmpty;
@end


@implementation SFTableView
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self initUI];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self initUI];
       
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self =[super initWithFrame:frame style:style];
    if (self) {
        [self initUI];
    }
    return self;
}


- (void)initUI
{
    self.tableFooterView                = [UIView new];
    self.titleForEmpty                  = @"咋没数据呢,刷新试试~~";
    self.descriptionForEmpty            = @"您的数据被程序猿搬走咯~~";
    self.imageNameForEmpty              = @"blankpage_button_reload";
    self.firstShowEmpty = YES;
    self.isShowEmpty = NO;
    self.isRefresh = NO;
    self.isLoadMore = NO;
    self.page = 0;
}

-(void)setIsShowEmpty:(BOOL)isShowEmpty{
    _isShowEmpty = isShowEmpty;
    if (isShowEmpty) {
        self.emptyDataSetDelegate=self;
        self.emptyDataSetSource=self;
    }
}


#pragma mark - 设置代理
- (void)setTableViewDelegate:(id<SFTableViewDelegate>)tableViewDelegate
{
    _tableViewDelegate = tableViewDelegate;
    self.delegate = (id<UITableViewDelegate>)tableViewDelegate;
    self.dataSource = (id<UITableViewDataSource>)tableViewDelegate;
}


#pragma mark - 上拉刷新
- (void)setIsRefresh:(BOOL)isRefresh
{
    _isRefresh = isRefresh;
    if (isRefresh) {
        [self setMj_header:[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)]];
    }
}


#pragma mark - 下拉加载
- (void)setIsLoadMore:(BOOL)isLoadMore
{
    _isLoadMore = isLoadMore;
    if (isLoadMore) {
        if (self.mj_footer == nil) {
            [self setMj_footer:[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                if (_tableViewDelegate &&[_tableViewDelegate respondsToSelector:@selector(loadDataRefreshOrPull:)]) {
                    [_tableViewDelegate loadDataRefreshOrPull:SFRefreshStatePulling];
                }
            }]];
        }
    }
}


- (void)refreshData
{
    if (self.mj_footer.state == MJRefreshStateNoMoreData) {
        [self.mj_footer resetNoMoreData];//重置没有更多数据的状态
    }
    
    if (_tableViewDelegate &&[_tableViewDelegate respondsToSelector:@selector(loadDataRefreshOrPull:)]) {
        self.page = 0;
        [_tableViewDelegate loadDataRefreshOrPull:SFRefreshStateRefreshing];
    }
    
}

- (NSNumber *)getCurrentPage
{
    return [NSNumber numberWithInteger:++self.page];
}

-(void)beginLoading
{
    [self.mj_header beginRefreshing];
}

-(void)endLoading
{
    if([self.mj_header isRefreshing])
        [self.mj_header endRefreshing];
    if ([self.mj_footer isRefreshing])
        [self.mj_footer endRefreshing];
}

#pragma mark - DZNEmptyDataSetSource Methods
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text           = self.titleForEmpty;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text                     = self.descriptionForEmpty;
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode            = NSLineBreakByWordWrapping;
    paragraph.alignment                = NSTextAlignmentCenter;
    
    NSDictionary *attributes           = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                           NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                           NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
//{
//    if (!self.imageNameForEmpty) {
//        return nil;
//    }
//    return [UIImage imageNamed:self.imageNameForEmpty];
//}

//返回图片按钮
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    if (!self.imageNameForEmpty) {
        return nil;
    }
    return [UIImage imageNamed:self.imageNameForEmpty];
}


- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}
//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return -20.0f;
//}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 0.0f;
}
#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    if (self.firstShowEmpty) {
        self.firstShowEmpty = NO;
        
        return NO;
    }
    
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(nonnull UIButton *)button
{
    if (button) {
        [self beginLoading];
    }
}


- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView
{
    //解决刷新后向上偏移问题
    [UIView animateWithDuration:0.5 animations:^{
        scrollView.contentOffset = CGPointZero;
    }];
}


@end

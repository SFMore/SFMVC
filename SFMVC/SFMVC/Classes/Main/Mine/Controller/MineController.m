//
//  MineController.m
//  SFMVC
//
//  Created by zsf on 16/10/12.
//  Copyright © 2016年 zsf. All rights reserved.
//

#import "MineController.h"
#import "UIScrollView+EmptyDataSet.h"
@interface MineController ()<UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic,strong)NSMutableArray*dataArray;
@property (nonatomic,weak) UITableView *tableView;
@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title  = @"我的";
    _dataArray = @[].mutableCopy;
    UITableView * tableVeiw = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    //tableVeiw.backgroundColor = [UIColor redColor];
    tableVeiw.dataSource = self;
    tableVeiw.rowHeight = 80;
    tableVeiw.emptyDataSetSource = self;
    tableVeiw.emptyDataSetDelegate = self;
    [self.view addSubview:tableVeiw];
    _tableView = tableVeiw;
    
    [self loadData];
    
     [SFNetworkCache removeAllHttpCache];
}

- (void)loadData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (NSInteger i = 0; i < 10; i++) {
            [ _dataArray addObject:[NSString stringWithFormat:@"测试%ld",i]];
        }
        
        [_tableView reloadData];
    });
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"Identifider";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.backgroundColor = [UIColor greenColor];
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}


#pragma mark - DZNEmptyDataSetSource


//返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *title = @"暂无数据";
    return [[NSAttributedString alloc] initWithString:title attributes:nil];
}

//返回详情文字
//-(NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
//{
//    NSString *desStr = @"正在加载中。。。";
//    return [[NSAttributedString alloc] initWithString:desStr attributes:nil];
//}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"blankpage_image_loadFail"];
}

//返回文字按钮
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSString *buttonTitle = @"重新获取";
    return [[NSAttributedString alloc] initWithString:buttonTitle attributes:nil];
}

//返回图片按钮
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return [UIImage imageNamed:@"blankpage_button_reload"];
}

//自定义背景色
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor redColor];
}

//自定义视图
//- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
//{
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor yellowColor];
//    UILabel *label = [[UILabel alloc] init];
//    [view addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(view);
//    }];
//     label.text = @"标题";
//    
//    UIImageView *image = [[UIImageView alloc] init];
//    [image setImage:[UIImage imageNamed:@"blankpage_image_Sleep"]];
//    [view addSubview:image];
//    [image mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(label);
//        make.top.equalTo(label.mas_bottom).offset(10);
//    }];
//    
//    UIButton *btn = [[UIButton alloc] init];
//    [view addSubview:btn];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(view);
//        make.top.equalTo(image.mas_bottom).offset(10);
//    }];
//    [btn setTitle:@"按钮" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//    return view;
//}

//设置垂直间距
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 5;
}

//设置偏移量
- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return CGPointZero;
}

#pragma mark - DZNEmptyDataSetSource

//是否显示空白页,默认YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldBeForcedToDisplay:(UIScrollView *)scrollView
{
    return NO;
}



//是否允许点击，默认YES
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

//是否允许滚动，默认NO
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

//空白页点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
     kAppLog(@"点击");
}

//空白页按钮点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(nonnull UIButton *)button
{
    kAppLog(@"按钮点击");
    [self loadData];
}

- (void)click
{
    
}

- (void)emptyDataSetDidAppear:(UIScrollView *)scrollView
{
    
}
@end

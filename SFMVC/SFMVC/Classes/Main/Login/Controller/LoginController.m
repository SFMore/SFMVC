//
//  LoginController.m
//  SFMVC
//
//  Created by zsf on 16/10/11.
//  Copyright © 2016年 zsf. All rights reserved.
//

#import "LoginController.h"
#import "UIView+EaseBlankPage.h"

@interface LoginController()<UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray*dataArray;
@property (nonatomic,weak) UITableView *tableView;
@end

@implementation LoginController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem  itemWithImage:@"nav_back" highImage:nil target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"返回" font:kFont(14) image:@"nav_back" target:self action:@selector(back)];
    
   // [MBProgressHUD showAutoMessage:@"登陆成功" ToView:self.navigationController.view];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 50, 50)];
//    label.text = @"23333";
//    [self.view addSubview:label];
    
        _dataArray = [NSMutableArray array];
    
        UITableView * tableVeiw = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
        //tableVeiw.backgroundColor = [UIColor redColor];
        tableVeiw.dataSource = self;
        tableVeiw.rowHeight = 80;
        [self.view addSubview:tableVeiw];
    _tableView = tableVeiw;
    [self loadData];
    
    
    kAppLog(@"%@",[UIApplication sharedApplication].getCurrentViewConttoller);
}

- (void)loadData
{
    [_tableView reloadData];
    [self.view configBlankPage:EaseBlankPageTypeMaterialScheduling hasData:self.dataArray.count hasError:(self.dataArray.count == 0) reloadButtonBlock:^(id sender) {
        for (NSInteger i = 0;  i < 10; i++) {
            [_dataArray addObject:[NSString stringWithFormat:@"测试===>%ld",i]];
        }
         [MBProgressHUD showAutoMessage:@"加载数据完成" ToView:self.navigationController.view];
        [self loadData];
    }];
}


- (void)back
{
    [self.navigationController popToViewControllerWithClassName:@"HomeController" animated:YES];
    
}

- (UIColor *)setNavigationBarBackgroundColor
{
    return [UIColor yellowColor];
}

- (BOOL)hideNavigationBottomLine
{
    return YES;
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

@end


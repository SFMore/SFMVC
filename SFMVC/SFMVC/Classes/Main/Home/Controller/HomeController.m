//
//  HomeController.m
//  SFMVC
//
//  Created by zsf on 16/10/12.
//  Copyright © 2016年 zsf. All rights reserved.
//

#import "HomeController.h"
#import "LoginController.h"
#import "SFTableView.h"

#define url(page)  [NSString stringWithFormat:@"http://fundex2.eastmoney.com/FundMobileApi/FundNetList.ashx?appType=ttjj&SortColumn=RZDF&version=4.2.3&CompanyId=&pageSize=30&pageIndex=%@&plat=Android&deviceid=0f607264fc6318a92b9e13c65db7cd3c&BUY=true&Sort=asc&FundType=27&product=EFund",page]
@interface HomeController ()<UITableViewDelegate,UITableViewDataSource,SFTableViewDelegate>
@property(nonatomic,strong)SFTableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"登录" font:kFont(15) color:[UIColor redColor] target:self action:@selector(login)];
   //self.view.backgroundColor = [UIColor redColor];
    [self.navigationController addTitleTextAttributes:@{NSFontAttributeName:kFont(20),
                                                       NSForegroundColorAttributeName:[UIColor redColor]}];
   
//    
//    UILabel *label = [[UILabel alloc] init];
//    [self.view addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//    }];
//    label.text = @"11111";
    _dataArray = @[].mutableCopy;
    SFTableView * tableVeiw = [[SFTableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    tableVeiw.backgroundColor = [UIColor redColor];
    tableVeiw.isShowEmpty = YES;
    tableVeiw.rowHeight = 80;
    tableVeiw.isRefresh = YES;
    tableVeiw.isLoadMore = YES;
    tableVeiw.tableViewDelegate = self;
    [tableVeiw beginLoading];
    [self.view addSubview:tableVeiw];
    _tableView = tableVeiw;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
    });
    
  
    
    
}

- (void)loadData:(NSString *)URL
{
    [SFNetworking getOrPostWithType:GET WithUrl:URL params:nil cache:^(id responseCache){
        kAppLog(@"缓存===>%@",responseCache);
        
//                    if (responseCache) {
//                        [_tableView endLoading];
//                        if (_tableView.page == 0) {
//                            [_dataArray removeAllObjects];
//                        }
//                        
//                        for (NSDictionary *dict in responseCache[@"Datas"]) {
//                            [_dataArray addObject:dict[@"SHORTNAME"]];
//                        }
//                        [_tableView reloadData];
//                    }
    } success:^(id response) {
        [_tableView endLoading];
        if (_tableView.page == 0) {
            [_dataArray removeAllObjects];
        }
        kAppLog(@"网络===>%@",response);
        
        for (NSDictionary *dict in response[@"Datas"]) {
            [_dataArray addObject:dict[@"SHORTNAME"]];
        }
        [_tableView reloadData];
    } fail:^(NSError *error) {
        [_tableView endLoading];
        [_tableView reloadData];
    } showHUD:YES toShowView:self.view];
}


- (void)loadDataRefreshOrPull:(SFRefreshState)state
{
    if (state == SFRefreshStateRefreshing) {
        [self loadData:url(@(0))];
    }else if (state == SFRefreshStatePulling){
        [self loadData:url([_tableView getCurrentPage])];
    }
}


- (void)login
{
    
    [MBProgressHUD showAutoMessage:@"登录成功" ToView:self.view];
    
    
   // [self.navigationController pushViewController:[[LoginController alloc] init] animated:YES];

   // [self presentViewController:[[LoginController alloc] init] animated:YES completion:nil];
  
}

- (UIColor *)setNavigationBarBackgroundColor
{
    return [UIColor whiteColor];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"Identifider";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    //cell.backgroundColor = [UIColor greenColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_dataArray[indexPath.row]];
    
    return cell;
}



@end

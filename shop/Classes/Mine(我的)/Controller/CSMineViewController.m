//
//  CSMineViewController.m
//  shop
//
//  Created by apple on 16/5/1.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import "CSMineViewController.h"
#import "CSLoginViewController.h"

@interface CSMineViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *bgNavView;
}
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataArray;

@end

@implementation CSMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = false;
    [self loadData];
    [self createTableView];
    [self createNavigation];
}

- (void)loadData{
    _dataArray = [NSMutableArray array];
    //section1
    
    //section2
    
    NSString *myInformationStr = @"我的信息";
    NSMutableDictionary *myInformationDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:myInformationStr,@"Title", nil];
    
    
    NSString *myAddressStr = @"我的收货地址";
    NSMutableDictionary *myAddressDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:myAddressStr,@"Title", nil];
    
    NSMutableArray *myInformationAry = [NSMutableArray array];
    [myInformationAry addObject:myInformationDic];
    [myInformationAry addObject:myAddressDic];
    
    
    
    //section3
    NSString *CustomerStr = @"客服电话：021-7785940";
    NSMutableDictionary *CustomerDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:CustomerStr,@"Title", nil];
    
    NSMutableArray *CustomerAry = [NSMutableArray array];
    [CustomerAry addObject:CustomerDic];
    
    [_dataArray addObject:myInformationAry];
    [_dataArray addObject:CustomerAry];
}

-(void)createNavigation{
    CSNavigationView *navigationView = [[CSNavigationView alloc]createNavigationViewWithTitle:@"登陆" WithNavigationType:NavigationTypeTitle];
    [self.view addSubview:navigationView];
}

- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screen_width, screen_height-49) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count+1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return [_dataArray[section-1] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        loginButton.frame = CGRectMake(screen_width/2-35, 31, 70, 32);
        [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
        loginButton.backgroundColor = [UIColor clearColor];
        [loginButton addTarget:self action:@selector(goLogin) forControlEvents:UIControlEventTouchUpInside];
        loginButton.layer.borderWidth = 1;
        loginButton.layer.cornerRadius = 10;
        loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
        [cell addSubview:loginButton];
        cell.frame = CGRectMake(0, 0, screen_width, 100);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        }
    NSArray *sectionAry = _dataArray[indexPath.section-1];
    NSDictionary *dic = sectionAry[indexPath.row];
    
    
    UILabel *meFunction = [[UILabel alloc]initWithFrame:CGRectMake(10, cell.center.y-10, cell.bounds.size.width-16, 20)];
    meFunction.text = [dic objectForKey:@"Title"];
    [cell addSubview:meFunction];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tabBarController.tabBar setHidden:NO];
    self.navigationController.navigationBarHidden = YES;
}

- (void)goLogin{
    CSLoginViewController *login = [[CSLoginViewController alloc]init];
    [self.tabBarController.tabBar setHidden:YES];
    [self presentViewController:login animated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

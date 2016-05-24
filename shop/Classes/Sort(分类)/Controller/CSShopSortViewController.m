//
//  CSShopSortViewController.m
//  shop
//
//  Created by apple on 16/5/2.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import "CSShopSortViewController.h"
#import "CSShorSortTableViewCell.h"
#import "CSGoodsInfoViewController.h"

@interface CSShopSortViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *bgNavView;
    UIView *menuBarView;
    UITextField *searchField;
    NSMutableArray *dataAry;
}

@property (nonatomic ,strong)UITableView *tableView;

@end

@implementation CSShopSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = false;
    [self loadData];
    [self initTableView];
    
}

- (void)loadData{
    dataAry = [NSMutableArray array];
    for (int i = 0; i<20; i++) {
        NSString *str = [NSString stringWithFormat:@"编号：%c",i];
        [dataAry addObject:str];
    }
}

- (void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 108, screen_width, screen_height-108) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataAry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CSShorSortTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"csshopsortcell"];
    
    if (!cell)
    {
        NSArray *ArrayCell = [[NSBundle mainBundle]loadNibNamed:@"CSShorSortTableViewCell" owner:self options:nil];
        cell = ArrayCell[0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CSGoodsInfoViewController *goodDetailsVC = [[CSGoodsInfoViewController alloc]init];
    [self.navigationController pushViewController:goodDetailsVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    [self setNavigation];
    [self setMenuBar];
}

- (void)setNavigation{
   
    CSNavigationView *navigation = [[CSNavigationView alloc]createNavigationViewWithTitle:@"搜索商品" WithNavigationType:NavigationTypeBackSearchBtn];
    
    [self.view addSubview:navigation];
}


- (void)setMenuBar{
    menuBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screen_width, 44)];
    menuBarView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    NSArray *menuAry = @[@"销量", @"时间", @"价格", @"筛选"];
    for (int i = 0; i < 5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(screen_width/5*i, 0, screen_width/5, 44);
        if (i == 4) {
            [btn setImage:[UIImage imageNamed:@"screen"] forState:UIControlStateNormal];
        }else{
            [btn setTitle:[NSString stringWithFormat:@"%@",menuAry[i]] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            ;
        }
        btn.backgroundColor = [UIColor whiteColor];
        [menuBarView addSubview:btn];
    }
    [self.view addSubview:menuBarView];
}

- (void)clickBtn:(UIButton *)btn{
    
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

//
//  CSCarViewController.m
//  shop
//
//  Created by apple on 16/5/1.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import "CSCarViewController.h"
#import "CSCarModel.h"
#import "CSCarTableViewCell.h"

#define  TAG_BACKGROUNDVIEW 100

#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
@interface CSCarViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *bgNavView;
    UILabel *navTitle;
    
    
    UITableView *myTableView;
    
    //展示数据源数组
    NSMutableArray *dataArray;
    
    
}

@end

@implementation CSCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBA(245.0, 246.0, 248.0 ,1.0);
    self.automaticallyAdjustsScrollViewInsets = false;
    dataArray = [NSMutableArray array];
    [self setupMainView];
    [self creatData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    [self setNavgation];
}

- (void)setNavgation{
    NSString *title = @"购物车";
    CSNavigationView *navigationView = [[CSNavigationView alloc]createNavigationViewWithTitle:title WithNavigationType:NavigationTypeTitle];
    
    [self.view addSubview:navigationView];
}


/**
 *  @author LQQ, 16-02-18 11:02:16
 *
 *  计算已选中商品金额
 */

/**
 *  @author LQQ, 16-02-18 11:02:32
 *
 *  创建测试数据源
 */
-(void)creatData
{
    for (int i = 0; i < 10; i++) {
        CSCarModel *model = [[CSCarModel alloc]init];
        
        model.nameStr = @"测试数据";
        model.price = @"100.00";
        model.number = 1;
        model.image = [UIImage imageNamed:@"goods.png"];
        model.dateStr = @"2016.02.18";
        model.sizeStr = @"18*20cm";
        
        [dataArray addObject:model];
    }
    
    if (myTableView) {
        [myTableView reloadData];
    }
    else
    {
        [self setupMainView];
    }
}





#pragma mark - 设置主视图
-(void)setupMainView
{
    //当购物车为空时,显示默认视图
    if (dataArray.count == 0) {
        [self cartEmptyShow];
    }
    //当购物车不为空时,tableView展示
    else
    {
        UIView *vi = [self.view viewWithTag:100];
        [vi removeFromSuperview];
        
        myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screen_width, screen_height - 113) style:UITableViewStylePlain];
        self.automaticallyAdjustsScrollViewInsets = false;
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.rowHeight = 100;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        myTableView.backgroundColor = RGB(245, 246, 248);
        
        [self.view addSubview:myTableView];
        
    }
    
}
//购物车为空时的默认视图
-(void)cartEmptyShow
{
    
    //默认视图背景
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    backgroundView.tag = TAG_BACKGROUNDVIEW;
    [self.view addSubview:backgroundView];
    
    //默认图片
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cart_default_bg"]];
    img.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0 - 120);
    img.bounds = CGRectMake(0, 0, 247.0/187 * 100, 100);
    [backgroundView addSubview:img];
    
    UILabel *warnLabel = [[UILabel alloc]init];
    warnLabel.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0 - 10);
    warnLabel.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    warnLabel.textAlignment = NSTextAlignmentCenter;
    warnLabel.text = @"购物车好空,买点什么呗!";
    warnLabel.font = [UIFont systemFontOfSize:15];
    warnLabel.textColor = UIColorFromRGB(0x706F6F);
    [backgroundView addSubview:warnLabel];
    
    //默认视图按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0 + 40);
    btn.bounds = CGRectMake(0, 0, SCREEN_WIDTH - 40, 40);
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_background_red"] forState:UIControlStateNormal];
    [btn setTitle:@"去定制" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goToMainmenuView) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn];
    
}
-(void)goToMainmenuView
{
    NSLog(@"去首页");
}
#pragma mark - tableView 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[CSCarTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell reloadDataWith:[dataArray objectAtIndex:indexPath.row]];
    return cell;
}

-(void)reloadTable
{
    [myTableView reloadData];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该商品?删除后无法恢复!" preferredStyle:1];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            [dataArray removeObjectAtIndex:indexPath.row];
            //    删除
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            //延迟0.5s刷新一下,否则数据会乱
            [self performSelector:@selector(reloadTable) withObject:nil afterDelay:0.5];
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:okAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
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

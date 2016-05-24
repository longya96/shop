//
//  CSSortViewController.m
//  shop
//
//  Created by apple on 16/5/1.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import "CSSortViewController.h"
#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"
#import "CSShopSortViewController.h"


@interface CSSortViewController ()<UITextFieldDelegate, UITableViewDelegate,UITableViewDataSource>
{
    UIView *bgNavView;
    UITextField *searchField;
}

@property (nonatomic, strong) UITableView *liftMenuTableView;
@property (nonatomic, strong) UITableView *rightMenuTableView;
@property (nonatomic, strong) NSDictionary *dataDictionary;
@property (nonatomic, strong) NSArray *menuArray;
@property (nonatomic ,strong) NSArray *myData;

@end

@implementation CSSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = false;
    [self loadData];
    [self creatLiftTableView];
    [self creatRightTableView];
    [self initAllTableView];
}

- (void)loadData{
    
    NSArray *array0 = [[NSArray alloc]initWithObjects:@"琪妹",@"芭朵兰",@"王胜富",@"喂奶文胸",@"裹胸",@"琪多姿束身衣",@"贴身仕卫",@"收腹衣",@"天资奥莉",@"珍梦",@"媚金", nil];
    NSArray *array1 = [[NSArray alloc]initWithObjects:@"芭朵兰",@"王胜富",@"喂奶文胸",@"裹胸",@"琪多姿束身衣",@"贴身仕卫",@"收腹衣",@"天资奥莉",@"珍梦",@"媚金",  nil];
    NSArray *array2 = [[NSArray alloc]initWithObjects:@"王胜富",@"喂奶文胸",@"裹胸",@"琪多姿束身衣",@"贴身仕卫",@"收腹衣",@"天资奥莉",@"珍梦",@"媚金",  nil];
    NSArray *array3 = [[NSArray alloc]initWithObjects:@"喂奶文胸",@"裹胸",@"琪多姿束身衣",@"贴身仕卫",@"收腹衣",@"天资奥莉",@"珍梦",@"媚金",  nil];
    _dataDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:array0,@"全部分类",array1,@"文胸",array2,@"短裤",array3,@"套装", nil];
    _menuArray = @[@"全部分类",@"文胸",@"短裤",@"套装"];
    
    
}

- (void)creatLiftTableView{
    _liftMenuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screen_width/3, screen_height) style:UITableViewStylePlain];
    _liftMenuTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _liftMenuTableView.delegate = self;
    _liftMenuTableView.dataSource = self;
    _liftMenuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _liftMenuTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    [self.view addSubview:_liftMenuTableView];
}

- (void)creatRightTableView{
    _rightMenuTableView = [[UITableView alloc]initWithFrame:CGRectMake(screen_width/3, 64, screen_width/3*2, screen_height) style:UITableViewStylePlain];
    _rightMenuTableView.delegate = self;
    _rightMenuTableView.dataSource = self;
    _rightMenuTableView.separatorColor = separaterColor;
    _rightMenuTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_rightMenuTableView];
    
}


//实现TableView的代理方法;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == _liftMenuTableView) {
        
        return _menuArray.count;
    }else{
        return _myData.count;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _liftMenuTableView) {
        LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"liftcell"];
        
        if (!cell)
        {
            NSArray *ArrayCell = [[NSBundle mainBundle]loadNibNamed:@"LeftTableViewCell" owner:self options:nil];
            cell = ArrayCell[0];
        }
        cell.tableview_textLabel.text = _menuArray[indexPath.row];
        
        cell.backgroundColor = [UIColor clearColor];//设置Cell选中效果
        UIView *selectView =  [[UIView alloc]init];
        selectView.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = selectView;
        return cell;
    }else{
        RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightcell"];
        if (!cell) {
            NSArray *ArrayCell = [[NSBundle mainBundle]loadNibNamed:@"RightTableViewCell" owner:self options:nil];
            cell = ArrayCell[0];
        }
        
        cell.tableView_textLable.text = _myData[indexPath.row];
        cell.selectionStyle = 0;
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _liftMenuTableView) {
        return 40;
    }else{
        return 44;
    }
}

- (void)initAllTableView{
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [_liftMenuTableView selectRowAtIndexPath:indexpath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    _myData = _dataDictionary[_menuArray[0]];
    [_rightMenuTableView reloadData];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _liftMenuTableView) {
        _myData = _dataDictionary[_menuArray[indexPath.row]];
        [_rightMenuTableView reloadData];
    }else{
        NSLog(@"点击了商品");
        CSShopSortViewController *shopSortView = [[CSShopSortViewController alloc]init];
        [self.navigationController pushViewController:shopSortView animated:YES];
        [self.tabBarController.tabBar setHidden:YES]
        ;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tabBarController.tabBar setHidden:NO];
    self.navigationController.navigationBarHidden = YES;
    [self setNavgation];
}

- (void)setNavgation{
    
    CSNavigationView *navigation = [[CSNavigationView alloc]createNavigationViewWithTitle:@"搜索商品" WithNavigationType:NavigationTypeSearchBtn];
    [self.view addSubview:navigation];
    
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

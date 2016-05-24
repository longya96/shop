//
//  CSHomeViewController.m
//  shop
//
//  Created by apple on 16/5/1.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import "CSHomeViewController.h"
#import "CSHomePageModel.h"
#import "SDCycleScrollView.h"
//#import "CSRefreshStateHeader.h"

@interface CSHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationBarDelegate,SDCycleScrollViewDelegate>{
    CSNavigationView *navigation;
    UIView *bgView;
    UITextField *searchField;
}

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = false;
    [self initData];
    [self initTabelView];
    
    
}

-(void)initTabelView{
    //tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.delegate=self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
}

-(void)initData{
    
        NSDictionary *cycleScroller1 = [NSDictionary dictionaryWithObjectsAndKeys:@"dljy",@"title",@"banner1",@"imageNamed", nil];
        NSDictionary *cycleScroller2 = [NSDictionary dictionaryWithObjectsAndKeys:@"kslp",@"title",@"banner1",@"imageNamed", nil];
        NSDictionary *cycleScroller3 = [NSDictionary dictionaryWithObjectsAndKeys:@"jkx",@"title",@"banner1",@"imageNamed", nil];
        NSDictionary *cycleScroller4 = [NSDictionary dictionaryWithObjectsAndKeys:@"xpx",@"title",@"banner1",@"imageNamed", nil];
        NSDictionary *cycleScroller5 = [NSDictionary dictionaryWithObjectsAndKeys:@"zzba",@"title",@"banner1",@"imageNamed", nil];
        NSArray *cycleScrollerAry = @[cycleScroller1,cycleScroller2,cycleScroller3,cycleScroller4,cycleScroller5];
        
        NSDictionary *btnDic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"推荐",@"title",@"button_00",@"imageNamed", nil];
        NSDictionary *btnDic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"促销",@"title",@"button_01",@"imageNamed", nil];
        NSDictionary *btnDic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"新品",@"title",@"button_02",@"imageNamed", nil];
        NSDictionary *btnDic4 = [NSDictionary dictionaryWithObjectsAndKeys:@"咨讯",@"title",@"button_03",@"imageNamed", nil];
        NSDictionary *btnDic5 = [NSDictionary dictionaryWithObjectsAndKeys:@"信息",@"title",@"button_04",@"imageNamed", nil];
        NSDictionary *btnDic6 = [NSDictionary dictionaryWithObjectsAndKeys:@"往来",@"title",@"button_05",@"imageNamed", nil];
        NSDictionary *btnDic7 = [NSDictionary dictionaryWithObjectsAndKeys:@"订单",@"title",@"button_06",@"imageNamed", nil];
        NSDictionary *btnDic8 = [NSDictionary dictionaryWithObjectsAndKeys:@"栏目",@"title",@"button_07",@"imageNamed", nil];
        
        NSArray *btnAry = @[btnDic1,btnDic2,btnDic3,btnDic4,btnDic5,btnDic6,btnDic7,btnDic8];
        
        _dataArray = @[cycleScrollerAry,btnAry];
        NSArray *cycleAry = _dataArray[0];
        NSMutableArray *imageNamed = [NSMutableArray array];
        _images = [NSMutableArray array];
        for (NSDictionary *dic in cycleAry) {
            [imageNamed addObject:[dic objectForKey:@"imageNamed"]];
        }
        for (NSString *imagename in imageNamed) {
            [_images addObject:[UIImage imageNamed:imagename]];
        }
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    [self setNavigation];
    
}

-(void)setNavigation{
    
    navigation = [[CSNavigationView alloc]createNavigationViewWithTitle:@"搜索商品" WithNavigationType:NavigationTypeSortSearchBtn];
    navigation.backgroundColor = [UIColor clearColor];
    [self.view addSubview:navigation];}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    UIColor *color = [UIColor whiteColor];
    
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"offsetY%f",offsetY);
    if (offsetY < -20) {
        [navigation setHidden:YES];
        navigation.backgroundColor = [color colorWithAlphaComponent:0];
        
    }else if(offsetY<500){
        [navigation setHidden:NO];
        CGFloat alpha = 1 - ((64 - offsetY) / 64);
        navigation.backgroundColor = [color colorWithAlphaComponent:alpha];
        navigation.searchFiled.alpha = alpha+0.3;
        
    }
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 ||section == 1) {
        return 1;
    }else {
        return 3;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (indexPath.section == 0) {
        
        // 创建不带标题的图片轮播器
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, screen_width, 200) imageNamesGroup:_images];
        cycleScrollView.delegate = self;
        cycleScrollView.autoScrollTimeInterval = 3.0;
        [cell addSubview:cycleScrollView];
        cell.frame = cycleScrollView.frame;
    }else if (indexPath.section == 1){
        NSArray *btnAry = _dataArray[indexPath.section];
        for (int i = 0; i < 8; i++) {
            UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake((screen_width/4)*(i%4)+0.5, 80*(i/4)+0.5, screen_width/4-1, 80-1)];
            btnView.backgroundColor = [UIColor whiteColor];
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((screen_width/4-45)/2, 10, 45, 40)];
            imageView.image = [UIImage imageNamed:[btnAry[i] objectForKey:@"imageNamed"]];
                
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 55, screen_width/4-10, 20)];
            label.text = [btnAry[i] objectForKey:@"title"];
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            [btnView addSubview:imageView];
            [btnView addSubview:label];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame = btnView.frame;
            btn.tag = 1000+i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnView];
            [cell addSubview:btn];
            cell.backgroundColor = [UIColor clearColor];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setFrame:CGRectMake(0, 0, screen_width, 160)];
        }
    }else{
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 ||section == 1) {
        return 0;
    }
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    if (section == 2) {
        UIView *labelView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, screen_width, 30)];
        labelView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, screen_width, 20)];
        label.text = @"精品推荐";
        [labelView addSubview:label];
        [view addSubview:labelView];
    }
    return view;
}

- (void)btnClick:(UIButton *)button{
    NSLog(@"点击了第%ld个button",button.tag);
    switch (button.tag) {
        default:
            break;
    }
}


-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了第%ld个轮播图",index);
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

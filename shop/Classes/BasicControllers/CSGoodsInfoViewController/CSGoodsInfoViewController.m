//
//  CSGoodsInfoViewController.m
//  shop
//
//  Created by apple on 16/5/2.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import "CSGoodsInfoViewController.h"
#import "CSGoodsdetailsTopTabBar.h"
#import "CSGooddetailsTopView.h"
#import "CSGooddetailsMiddleView.h"
#import "CSGooddetailsBottomView.h"
#import "MJRefresh.h"


@interface CSGoodsInfoViewController ()<UITableViewDelegate,UITableViewDataSource,CSGoodsdetailsTopTabBarDelegate,UIScrollViewDelegate>
{
    UIView *bgNavView;
    UILabel *navTitle;
}

@property(nonatomic,weak)CSGoodsdetailsTopTabBar* TopTabBar;
@property(nonatomic,weak)UIView* NavBarView;

@property (strong, nonatomic) UIScrollView *MyScrollView;
@property (weak, nonatomic) CSGooddetailsTopView* topView;
@property (weak, nonatomic) CSGooddetailsMiddleView* middleView;
@property (weak, nonatomic) CSGooddetailsBottomView* bottomView;
@property (weak, nonatomic) UITableView* detailTableview;
@property (weak, nonatomic) MJRefreshHeaderView* secondheader;
@property (weak, nonatomic) MJRefreshFooterView* firstfooter;
@property (assign, nonatomic)float TopViewScale;
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation CSGoodsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.TopViewScale = 1.0;
    [self initView];
    [self setNavigationView];//提示,要在最后添加
}

/**
 添加导航栏背后的View
 */
-(void)setNavigationView{
    CSNavigationView *navigationView = [[CSNavigationView alloc]createNavigationViewWithTitle:nil WithNavigationType:NavigationTypeBack];
    [self.view addSubview:navigationView];
}

-(void)viewDidDisappear:(BOOL)animated{
    //释放下拉刷新内存
    [self.secondheader free];
    [self.MyScrollView removeFromSuperview];
    [super viewDidDisappear:animated];
}
-(UIScrollView *)MyScrollView{
    if (_MyScrollView == nil) {
        _MyScrollView = [[UIScrollView alloc] init];
        _MyScrollView.delegate = self;
        _MyScrollView.frame = CGRectMake(0.0, 0.0, screen_width, screen_height - bottom_height);
        _MyScrollView.pagingEnabled = YES;//进行分页
        _MyScrollView.showsVerticalScrollIndicator = NO;
        _MyScrollView.tag = 0;
        [self.view addSubview:_MyScrollView];
    }
    return _MyScrollView;
}
/**
 添加底部购买按钮和加入购物车按钮的view
 */
-(void)initBottomView{
    UIView* view = [[UIView alloc] init];
    view.frame = CGRectMake(0,CGRectGetMaxY(self.MyScrollView.frame), screen_width, bottom_height);
    view.backgroundColor = [UIColor whiteColor];
    
    CGFloat btnW = 100;
    CGFloat btnH = 52;
    CGFloat margin = 3;
    //加入购物车按钮
    CGFloat aX = screen_width - btnW;
    UIButton* aBtn = [[UIButton alloc] init];
    aBtn.frame = CGRectMake(aX, 0, btnW, btnH);
    [aBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [aBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    aBtn.backgroundColor = RGBA(250.0, 63.0, 51.0, 1.0);
    [aBtn addTarget:self action:@selector(addShoppingCar:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:aBtn];
    
    //立即购买按钮
    CGFloat bX = screen_width - 2*btnW - margin;
    UIButton* bBtn = [[UIButton alloc] init];
    bBtn.frame = CGRectMake(bX, 0, btnW, btnH);
    [bBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [bBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bBtn.backgroundColor = RGBA(0.0, 162.0, 154.0, 1.0);
    [bBtn addTarget:self action:@selector(nowBuy:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:bBtn];
    
    
    [self.view addSubview:view];
}
/**
 加入购物车按钮点击动作
 */
-(void)addShoppingCar:(id)sender{
    NSLog(@"加入购物车");
}
/**
 立即购买按钮动作
 */
-(void)nowBuy:(id)sender{
    NSLog(@"购买");
}
/**
 初始化相关的view
 */
-(void)initView{
    //初始化第一个页面
    //初始化第一个页面的父亲view
    
    UIView* firstPageView = [[UIView alloc] init];
    firstPageView.frame = CGRectMake(0, 0, screen_width, screen_height - bottom_height);
        UITableView *firstPageTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-bottom_height) style:(UITableViewStyleGrouped)];
    firstPageTableView.delegate = self;
    firstPageTableView.dataSource = self;
    firstPageTableView.tag = 1;
    firstPageTableView.showsVerticalScrollIndicator = NO;
    CSGooddetailsBottomView*bottomView = [CSGooddetailsBottomView view];
    bottomView.frame = CGRectMake(0,0, screen_width, bottom_height);
    [firstPageTableView setTableFooterView:bottomView];
    
    [firstPageView addSubview:firstPageTableView];
    
    
    [self.MyScrollView addSubview:firstPageView];
    
    
    //初始化第二个页面
    [self addSecondPageView];
    
    // 设置scrollview内容区域大小
    self.MyScrollView.contentSize = CGSizeMake(screen_width, (screen_height - bottom_height)*2);
    [self initBottomView];
}
/**
 添加第二个页面
 */
-(void)addSecondPageView{
    //初始化第二个页面的父亲view
    UIView* secondPageView = [[UIView alloc] init];
    secondPageView.frame = CGRectMake(0, screen_height - bottom_height, screen_width, screen_height - bottom_height);
    NSArray* array  = @[@"图文详情",@"详细参数",@"包装清单"];
    CSGoodsdetailsTopTabBar* tabBar = [[CSGoodsdetailsTopTabBar alloc] initWithArray:array] ;
    tabBar.frame = CGRectMake(0,navigation_height, screen_width, 44);
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.delegate = self;
    self.TopTabBar = tabBar;
    [secondPageView addSubview:tabBar];
    //初始化一个UITableView
    UITableView* secondPageTableView = [[UITableView alloc] init];
    self.detailTableview = secondPageTableView;
    secondPageTableView.dataSource = self;
    secondPageTableView.delegate = self;
    secondPageTableView.tag = 2;
    secondPageTableView.frame = CGRectMake(0, CGRectGetMaxY(tabBar.frame), screen_width,secondPageView.frame.size.height - tabBar.frame.size.height-navigation_height);
    MJRefreshHeaderView* RheaderView = [MJRefreshHeaderView header];
    RheaderView.scrollView = secondPageTableView;
    self.secondheader = RheaderView;
    RheaderView.beginRefreshingBlock = ^(MJRefreshBaseView* refreshView){
        NSOperationQueue* Queue = [[NSOperationQueue alloc] init];
        [Queue addOperationWithBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.5 animations:^{
                    self.MyScrollView.contentOffset = CGPointMake(0, 0);
                } completion:^(BOOL finished) {
                    self.MyScrollView.scrollEnabled = YES;
                }];
                [self.secondheader endRefreshing];
            });
        }];
    };
    
    [secondPageView addSubview:secondPageTableView];
    [self.MyScrollView addSubview:secondPageView];
}
#pragma -- <UIScrollViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@" --== %f",scrollView.contentOffset.y);
    if(scrollView.tag == 0){
        if(scrollView.contentOffset.y<0){
            if(self.TopViewScale<1.1){
                self.TopViewScale += 0.00015f;
                [self.imageView setTransform:CGAffineTransformScale(self.imageView.transform, self.TopViewScale, self.TopViewScale)];
            }
            scrollView.contentOffset = CGPointMake(0, 0);
        }else{
            self.NavBarView.backgroundColor = RGBA(0.0,162.0,154.0, scrollView.contentOffset.y/(screen_height-bottom_height));
        }
        if(scrollView.contentOffset.y == (screen_height-bottom_height)){
            scrollView.scrollEnabled = NO;
        }else if (scrollView.contentOffset.y == -navigation_height && !scrollView.isDragging){
            [UIView animateWithDuration:0.3 animations:^{
                scrollView.contentOffset = CGPointMake(0, 0);
            }];
        }else;
    }
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@" endd-- %f",self.TopViewScale);
    self.TopViewScale = 1.0;
    [UIView animateWithDuration:0.5 animations:^{
        [self.imageView setTransform:CGAffineTransformIdentity];//恢复原来的大小
    }];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //NSLog(@" -- %f",scrollView.contentOffset.y);
}

#pragma -- MyOrderTopTabBarDelegate(顶部标题栏delegate)
-(void)tabBar:(CSGoodsdetailsTopTabBar *)tabBar didSelectIndex:(NSInteger)index{
    
    NSLog(@"点击了 －－－ %ld",index);
}
#pragma -- UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (tableView.tag) {
        case 1:{
            return 0;
            break;
        }
        default:
            return 0;
            break;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    switch (tableView.tag) {
        case 1:{
            return 4;
            break;
        }
        default:
            return 1;
            break;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch (tableView.tag) {
        case 1:{
            switch (section) {
                case 0:{
                    CSGooddetailsTopView *view = [CSGooddetailsTopView view];
                    view.frame = CGRectMake(0, 0, screen_width, 380);
                    return view;
                    break;
                }
                case 1:{
                    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 40)];
                    view.backgroundColor = [UIColor whiteColor];
                    UILabel*title = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, screen_width, 21)];
                    title.text = @"选择颜色分类";
                    [view addSubview:title];
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
                    btn.frame = view.frame;
                    btn.tag = 200 + section;
                    [view addSubview:btn];
                    return view;
                    break;
                }
                default:{
                    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 40)];
                    view.backgroundColor = [UIColor whiteColor];
                    UILabel*title = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, screen_width, 21)];
                    title.text = @"商品详情";
                    [view addSubview:title];
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
                    btn.frame = view.frame;
                    btn.tag = 200 + section;
                    [view addSubview:btn];
                    return view;
                    break;
                }
            }
            break;
        }
        default:{
            return nil;
            break;
        }
    }
}

-(void)clickBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 202:{
            [UIView animateWithDuration:0.3 animations:^{
                _MyScrollView.contentOffset = CGPointMake(0, screen_height-49);
                [_TopTabBar setSelectedTabBtnWithIndex:1];
            }];
            break;
        }
        case 203:{
            [UIView animateWithDuration:0.3 animations:^{
                _MyScrollView.contentOffset = CGPointMake(0, screen_height-49);
                [_TopTabBar setSelectedTabBtnWithIndex:2];
            }];
            break;
        }
        default:
            break;
    }
    NSLog(@"%ld",sender.tag);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    UIView *view = [self tableView:tableView viewForHeaderInSection:section];
    NSLog(@"gaodu:%f",view.bounds.size.height);
    return view.bounds.size.height;
}

#pragma -- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
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

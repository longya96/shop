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

#define TopViewH 380
#define MiddleViewH 195
#define BottomH 49
#define TopTabBarH 50
#define NaviBarH 64.0

@interface CSGoodsInfoViewController ()<UITableViewDelegate,UITableViewDataSource,CSGoodsdetailsTopTabBarDelegate>
{
    UIView *bgNavView;
    UILabel *navTitle;
}
@property(nonatomic,weak)CSGoodsdetailsTopTabBar *TopTabBar;
@property(nonatomic,weak)UIView* NavBarView;

@property (weak, nonatomic) UIScrollView *MyScrollView;
@property (weak, nonatomic) CSGooddetailsTopView* topView;
@property (weak, nonatomic) CSGooddetailsMiddleView* middleView;
@property (weak, nonatomic) CSGooddetailsBottomView* bottomView;
@property (weak, nonatomic) UITableView* detailTableview;
@property (assign, nonatomic)float TopViewScale;

@end

@implementation CSGoodsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopViewScale = 1.0;
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

-(void)clickBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    //释放下拉刷新内存
    [self.MyScrollView removeFromSuperview];
    [super viewDidDisappear:animated];
}
-(UIScrollView *)MyScrollView{
    if (_MyScrollView == nil) {
        UIScrollView* scroll = [[UIScrollView alloc] init];
        _MyScrollView = scroll;
        scroll.delegate = self;
        scroll.frame = CGRectMake(0.0, 0.0, screen_width, screen_height-BottomH);
        scroll.pagingEnabled = YES;//进行分页
        scroll.showsVerticalScrollIndicator = NO;
        scroll.tag = 0;
        [self.view addSubview:scroll];
    }
    return _MyScrollView;
}
/**
 添加底部购买按钮和加入购物车按钮的view
 */
-(void)initBottomView{
    UIView* view = [[UIView alloc] init];
    view.frame = CGRectMake(0,CGRectGetMaxY(self.MyScrollView.frame), screen_width, BottomH);
    view.backgroundColor = [UIColor whiteColor];
    
    CGFloat btnW = 100;
    CGFloat btnH = 45;
    CGFloat margin = 3;
    //加入购物车按钮
    CGFloat aX = screen_width - btnW;
    UIButton* aBtn = [[UIButton alloc] init];
    aBtn.frame = CGRectMake(aX, 2, btnW, btnH);
    [aBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [aBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    aBtn.backgroundColor = RGBA(250.0, 63.0, 51.0, 1.0);
    [aBtn addTarget:self action:@selector(addShoppingCar:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:aBtn];
    
    //立即购买按钮
    CGFloat bX = screen_width - 2*btnW - margin;
    UIButton* bBtn = [[UIButton alloc] init];
    bBtn.frame = CGRectMake(bX, 2, btnW, btnH);
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
    firstPageView.frame = CGRectMake(0, 0, screen_width, screen_height - BottomH);
    CSGooddetailsTopView* topView = [CSGooddetailsTopView view];
    self.topView = topView;
    topView.frame = CGRectMake(0,0, screen_width, TopViewH);
    [firstPageView addSubview:topView];
    CSGooddetailsMiddleView* middleView = [CSGooddetailsMiddleView view];
    self.middleView = middleView;
    middleView.frame = CGRectMake(0,CGRectGetMaxY(topView.frame) + 6, screen_width, MiddleViewH);
    [firstPageView addSubview:middleView];
    CSGooddetailsBottomView* bottomView = [CSGooddetailsBottomView view];
    self.bottomView = bottomView;
    CGFloat bottomViewY = 0.0;
    if ((screen_width==414)?1:0) {
        bottomViewY = self.MyScrollView.frame.size.height - BottomH;
    }else{
        bottomViewY = CGRectGetMaxY(middleView.frame);
    }
    bottomView.frame = CGRectMake(0,bottomViewY, screen_width, BottomH);
    [firstPageView addSubview:bottomView];
    [self.MyScrollView addSubview:firstPageView];
    [self initBottomView];
    //初始化第二个页面
    [self addSecondPageTopTabBar];
    // 设置scrollview内容区域大小
    self.MyScrollView.contentSize = CGSizeMake(screen_width, (screen_height - BottomH)*2);
}
/**
 添加第二个页面顶部tabBar
 */
-(void)addSecondPageTopTabBar{
    //初始化第二个页面的父亲view
    UIView* secondPageView = [[UIView alloc] init];
    secondPageView.frame = CGRectMake(0, screen_height - BottomH, screen_width, screen_height - BottomH);
    NSArray* array  = @[@"图文详情",@"宝贝评价",@"宝贝咨询"];
    CSGoodsdetailsTopTabBar* tabBar = [[CSGoodsdetailsTopTabBar alloc] initWithArray:array] ;
    tabBar.frame = CGRectMake(0,NaviBarH, screen_width, TopTabBarH);
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.delegate = self;
    self.TopTabBar = tabBar;
    [secondPageView addSubview:tabBar];
    //初始化一个UITableView
    UITableView* tableview = [[UITableView alloc] init];
    self.detailTableview = tableview;
    tableview.dataSource = self;
    tableview.delegate = self;
    tableview.tag = 1;
    tableview.frame = CGRectMake(0, CGRectGetMaxY(tabBar.frame), screen_width,secondPageView.frame.size.height - tabBar.frame.size.height-NaviBarH);
    
    
    [secondPageView addSubview:tableview];
    [self.MyScrollView addSubview:secondPageView];
}
#pragma -- <UIScrollViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@" --== %f",scrollView.contentOffset.y);
    if(scrollView.tag == 0){
        if(scrollView.contentOffset.y<0){
            if(self.TopViewScale<1.01){
                self.TopViewScale += 0.00015f;
                
            }
            scrollView.contentOffset = CGPointMake(0, 0);
        }else{
            self.NavBarView.backgroundColor = RGBA(255.0,255.0,255.0, scrollView.contentOffset.y/(screen_height-BottomH));
        }
        if(scrollView.contentOffset.y == (screen_height-BottomH)){
            scrollView.scrollEnabled = NO;
        }else if (scrollView.contentOffset.y == -NaviBarH && !scrollView.isDragging){
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
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
    
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

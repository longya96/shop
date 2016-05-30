//
//  CSGoodsdetailsTopTabBar.m
//  shop
//
//  Created by newtouch on 16/5/5.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import "CSGoodsdetailsTopTabBar.h"
#import "CSTopButton.h"

#define bottomViewW 6.0
@interface CSGoodsdetailsTopTabBar()

@property(nonatomic,weak) UIButton *lastBtn;//记录上一个按钮
@property(nonatomic,weak) UIView* bottomView;//记录底部指示的标示条
@property(nonatomic,assign)CGFloat btnW;//记录按钮的宽度
@property(nonatomic,assign)CGFloat btnH;//记录按钮的高度

@end

@implementation CSGoodsdetailsTopTabBar

+(instancetype)tabbar{
    return [[self alloc] init];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView* bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = RGBA(0.0, 162.0, 154.0, 1.0);
        self.bottomView = bottomView;
        [self addSubview:bottomView];
    }
    return self;
}

/**
 使用字符数组初始化
 */

-(instancetype)initWithArray:(NSArray *)array{
    self = [super init];
    if (self) {
        for(NSString* name in array){
            [self AddTarBarBtn:name];
        }
    }
    return self;
}

/**
 添加顶部标题项的名字
 */
-(void)AddTarBarBtn:(NSString *)name{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(33.0, 33.0, 33.0, 1.0) forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(0.0,162.0,154.0,1.0) forState:UIControlStateSelected];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:17.0]];
    [btn addTarget:self action:@selector(TabBtnClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    [btn setTag:self.subviews.count-2];
    //NSLog(@"按钮tag == %ld",self.subviews.count - 2);
    if(2 == self.subviews.count){
        [self TabBtnClick:btn];
    }
    
}
/**
 计算字view的frame
 */
-(void)layoutSubviews{
    NSInteger btnCount = self.subviews.count;
    CGFloat btnW = self.frame.size.width/(btnCount - 1);
    CGFloat btnH = self.frame.size.height;
    self.btnW = btnW;
    self.btnH = btnH;
    for(int i=0;i<btnCount;i++){
        if ([self.subviews[i] isKindOfClass:[UIButton class]]) {
            UIButton *btn = self.subviews[i];
            btn.frame = CGRectMake((i-1)*btnW, 0, btnW, btnH);
        }else{
            UIView* view = self.subviews[i];
            view.frame = CGRectMake(0, btnH - bottomViewW, btnW, bottomViewW);
        }
    }
    //NSLog(@"按钮数量 == %ld",self.subviews.count);
}

/**
 监听tabbar的点击
 */
-(void)TabBtnClick:(UIButton *)sender{
    if(_lastBtn != nil){
        _lastBtn.selected = NO;
    }
    sender.selected = YES;
    _lastBtn = sender;
    //底部指示view的动画
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomView.frame = CGRectMake(sender.tag*self.btnW, self.btnH - bottomViewW, self.btnW, bottomViewW);
    }];
    if([_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)]){//判断代理有没有实现这个函数了
        [_delegate tabBar:self didSelectIndex:sender.tag];
    }
}
/**
 设定
 */
- (void)setSelectedTabBtnWithIndex:(NSInteger)index{
    UIButton *btn = (UIButton *)[self viewWithTag:index];
    [self TabBtnClick:btn];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  CSGoodsdetailsTopTabBar.h
//  shop
//
//  Created by newtouch on 16/5/5.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSGoodsdetailsTopTabBar;
@protocol CSGoodsdetailsTopTabBarDelegate <NSObject>

@optional

-(void)tabBar:(CSGoodsdetailsTopTabBar *)tabBar didSelectIndex:(NSInteger)index;

@end

@interface CSGoodsdetailsTopTabBar : UIView

@property(nonatomic,weak) id<CSGoodsdetailsTopTabBarDelegate> delegate;
/**
 静态方法初始化
 */
+(instancetype)tabbar;
/**
 使用数组初始化
 */
-(instancetype)initWithArray:(NSArray*)array;
-(void)AddTarBarBtn:(NSString *)name;//添加顶部标题项的名字
-(void)TabBtnClick:(UIButton *)sender;//监听tabbar的点击
- (void)setSelectedTabBtnWithIndex:(NSInteger)index;
@end

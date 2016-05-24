//
//  CSNavigationView.m
//  shop
//
//  Created by newtouch on 16/5/9.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import "CSNavigationView.h"
#import "CSSortViewController.h"
@interface CSNavigationView()


@end
@implementation CSNavigationView

- (instancetype)createNavigationViewWithTitle:(NSString *)title WithNavigationType:(NavigationType)navigationType{
    CSNavigationView *navigationView = [[CSNavigationView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    navigationView.backgroundColor = [UIColor whiteColor];
    
    switch (navigationType) {
        
        case NavigationTypeBackSearchBtn:{
            _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_leftBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
            [_leftBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
            [navigationView addSubview:_leftBtn];
            
            _searchFiled = [[UITextField alloc]init];
            _searchFiled.backgroundColor = [UIColor whiteColor];
            [_searchFiled setBorderStyle:UITextBorderStyleRoundedRect];
            _searchFiled.placeholder = title;
            _searchFiled.textAlignment = NSTextAlignmentLeft;
            [navigationView addSubview:_searchFiled];
            
            _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_rightBtn setImage:[UIImage imageNamed:@"navbar_r_00"] forState:UIControlStateNormal];
            
            [navigationView addSubview:_rightBtn];
            [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(navigationView).with.offset(10);
                make.top.equalTo(navigationView).with.offset(27);
                make.width.equalTo(@30);
                make.height.equalTo(@30);
            }];
            
            [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@27);
                make.right.equalTo(navigationView).with.offset(-10);
                make.width.equalTo(@30);
                make.height.equalTo(@30);
            }];
            
            [_searchFiled mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_leftBtn.mas_right).with.offset(10);
                make.right.equalTo(_rightBtn.mas_left).with.offset(-10);
                make.top.equalTo(navigationView).with.offset(27);
                make.height.equalTo(@30);
            }];
            
            break;
        }
        case NavigationTypeBackTitileBtn:{
            _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_leftBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
            [_leftBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
            [navigationView addSubview:_leftBtn];
            
            UILabel *title = [[UILabel alloc]init];
            
            title.text = [NSString stringWithFormat:@"%@",title];
            title.textAlignment = NSTextAlignmentCenter;
            title.font = [UIFont systemFontOfSize:20];
            
            [navigationView addSubview:title];
            
            _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_rightBtn setImage:[UIImage imageNamed:@"navbar_r_00"] forState:UIControlStateNormal];
            
            [navigationView addSubview:_rightBtn];
            [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(navigationView).with.offset(10);
                make.top.equalTo(navigationView).with.offset(27);
                make.width.equalTo(@30);
                make.height.equalTo(@30);
            }];
            
            [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@27);
                make.right.equalTo(navigationView).with.offset(-10);
                make.width.equalTo(@30);
                make.height.equalTo(@30);
            }];
            
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_leftBtn.mas_right).with.offset(10);
                make.right.equalTo(_rightBtn.mas_left).with.offset(-10);
                make.top.equalTo(navigationView).with.offset(27);
                make.height.equalTo(@30);
            }];
            break;
        }
        case NavigationTypeSortSearchBtn:{
            _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_leftBtn addTarget:self action:@selector(clickPush) forControlEvents:UIControlEventTouchUpInside];
            [_leftBtn setImage:[UIImage imageNamed:@"navbar_l_00"] forState:UIControlStateNormal];
            [navigationView addSubview:_leftBtn];
            
            _searchFiled = [[UITextField alloc]init];
            _searchFiled.backgroundColor = [UIColor whiteColor];
            [_searchFiled setBorderStyle:UITextBorderStyleRoundedRect];
            _searchFiled.placeholder = title;
            _searchFiled.backgroundColor = [UIColor clearColor];
            _searchFiled.textAlignment = NSTextAlignmentCenter;
            [navigationView addSubview:_searchFiled];
            
            _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_rightBtn setImage:[UIImage imageNamed:@"navbar_r_00"] forState:UIControlStateNormal];
            
            [navigationView addSubview:_rightBtn];
            [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(navigationView).with.offset(10);
                make.top.equalTo(navigationView).with.offset(27);
                make.width.equalTo(@30);
                make.height.equalTo(@30);
            }];
            
            [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@27);
                make.right.equalTo(navigationView).with.offset(-10);
                make.width.equalTo(@30);
                make.height.equalTo(@30);
            }];
            
            [_searchFiled mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_leftBtn.mas_right).with.offset(10);
                make.right.equalTo(_rightBtn.mas_left).with.offset(-10);
                make.top.equalTo(navigationView).with.offset(27);
                make.height.equalTo(@30);
            }];
            break;
        }
        case NavigationTypeSearchBtn:{
            _searchFiled = [[UITextField alloc]init];
            _searchFiled.backgroundColor = [UIColor whiteColor];
            [_searchFiled setBorderStyle:UITextBorderStyleRoundedRect];
            _searchFiled.placeholder = title;
            _searchFiled.textAlignment = NSTextAlignmentLeft;
            [navigationView addSubview:_searchFiled];
            
            _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_rightBtn setImage:[UIImage imageNamed:@"navbar_r_00"] forState:UIControlStateNormal];
            
            [navigationView addSubview:_rightBtn];
            
            [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@27);
                make.right.equalTo(navigationView).with.offset(-10);
                make.width.equalTo(@30);
                make.height.equalTo(@30);
            }];
            
            [_searchFiled mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(navigationView).with.offset(10);
                make.right.equalTo(_rightBtn.mas_left).with.offset(-10);
                make.top.equalTo(navigationView).with.offset(27);
                make.height.equalTo(@30);
            }];
            break;
        }
        case NavigationTypeTitle:{
            UILabel *titleLable = [[UILabel alloc]init];
            
            titleLable.text = [NSString stringWithFormat:@"%@",title];
            titleLable.textAlignment = NSTextAlignmentCenter;
            titleLable.textColor = [UIColor grayColor];
            titleLable.font = [UIFont systemFontOfSize:20];
            
            [navigationView addSubview:titleLable];
            
            [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(navigationView).offset(27);
                make.centerX.equalTo(navigationView.mas_centerX);
                make.height.equalTo(@30);
                make.width.equalTo(@150);
            }];
            break;
        }
        case NavigationTypeBack:{
            _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_leftBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
            [_leftBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
            navigationView.backgroundColor = [UIColor clearColor];
            [navigationView addSubview:_leftBtn];
            
            [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(navigationView).offset(27);
                make.left.equalTo(navigationView).offset(10);
                make.width.equalTo(@30);
                make.height.equalTo(@30);
            }];

            break;
        }
        default:
            break;
    }
    return navigationView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)clickPush{
    /*
    UIViewController *controller = [self viewController];
    CSSortViewController *sortVC = [[CSSortViewController alloc]init];
    [controller.navigationController pushViewController:sortVC animated:YES];
     */
    UIViewController *controller = [self viewController];
    [controller.tabBarController setSelectedIndex:1];
}


- (void)clickBack{
    UIViewController *controller = [self viewController];
    [controller.navigationController popViewControllerAnimated:YES];
}
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end

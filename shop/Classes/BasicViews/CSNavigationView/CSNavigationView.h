//
//  CSNavigationView.h
//  shop
//
//  Created by newtouch on 16/5/9.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CSNavigationView;
typedef NS_ENUM(NSUInteger, NavigationType){
    NavigationTypeBackSearchBtn,
    NavigationTypeBackTitileBtn,
    NavigationTypeSortSearchBtn,
    NavigationTypeSearchBtn,
    NavigationTypeTitle,
    NavigationTypeBack
};


@interface CSNavigationView : UIView<UITextFieldDelegate>

@property (nonatomic ,strong) UIButton *leftBtn;
@property (nonatomic ,strong) UIButton *rightBtn;
@property (nonatomic ,strong) UITextField *searchFiled;

- (instancetype)createNavigationViewWithTitle:(NSString *)title WithNavigationType:(NavigationType)navigationType;



@end

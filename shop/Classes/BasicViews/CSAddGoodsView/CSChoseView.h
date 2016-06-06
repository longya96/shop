//
//  CSChoesView.h
//  shop
//
//  Created by newtouch on 16/6/6.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CSTypeView.h"
#import "CSBuyCountView.h"
@interface CSChoseView : UIView<UITextFieldDelegate,UIAlertViewDelegate>
@property(nonatomic, retain)UIView *alphaiView;
@property(nonatomic, retain)UIView *whiteView;

@property(nonatomic, retain)UIImageView *img;

@property(nonatomic, retain)UILabel *lb_price;
@property(nonatomic, retain)UILabel *lb_stock;
@property(nonatomic, retain)UILabel *lb_detail;
@property(nonatomic, retain)UILabel *lb_line;

@property(nonatomic, retain)UIScrollView *mainscrollview;

@property(nonatomic, retain)CSTypeView *sizeView;
@property(nonatomic, retain)CSTypeView *colorView;
@property(nonatomic, retain)CSBuyCountView *countView;

@property(nonatomic, retain)UIButton *bt_sure;
@property(nonatomic, retain)UIButton *bt_cancle;

@property(nonatomic) int stock;
@end
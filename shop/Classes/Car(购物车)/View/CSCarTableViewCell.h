//
//  CSCarTableViewCell.h
//  shop
//
//  Created by newtouch on 16/5/5.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSCarModel.h"

@interface CSCarTableViewCell : UITableViewCell


/**
 *  @author LQQ, 16-02-18 11:02:39
 *
 *  刷新cell
 *
 *  @param model cell数据模型
 */
-(void)reloadDataWith:(CSCarModel*)model;
@end

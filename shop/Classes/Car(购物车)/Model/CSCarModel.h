//
//  CSCarModel.h
//  shop
//
//  Created by newtouch on 16/5/5.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSCarModel : NSObject
@property (nonatomic,copy) NSString *sizeStr;
@property (nonatomic,copy) NSString *nameStr;
@property (nonatomic,copy) NSString *dateStr;
@property (nonatomic,assign) NSInteger number;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,retain)UIImage *image;
@property (nonatomic,assign) BOOL isSelect;
@end

//
//  CSTypeView.h
//  shop
//
//  Created by newtouch on 16/6/6.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CSTypeSeleteDelegete <NSObject>

-(void)btnindex:(int) tag;

@end
@interface CSTypeView : UIView
@property(nonatomic)float height;
@property(nonatomic)int seletIndex;
@property (nonatomic,retain) id<CSTypeSeleteDelegete> delegate;

-(instancetype)initWithFrame:(CGRect)frame andDatasource:(NSArray *)arr :(NSString *)typename;
@end
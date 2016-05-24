//
//  CSGooddetailsTopView.m
//  shop
//
//  Created by newtouch on 16/5/5.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import "CSGooddetailsTopView.h"

@implementation CSGooddetailsTopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    
}
-(void)collectAction:(UIButton*)sender{
    sender.selected = sender.isSelected?NO:YES;
    
}
+ (instancetype)view
{
    return [[[NSBundle mainBundle] loadNibNamed:@"CSGooddetailsTopView" owner:nil options:nil] firstObject];
}


@end

//
//  CSLoginView.m
//  shop
//
//  Created by newtouch on 16/5/9.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import "CSLoginView.h"

@implementation CSLoginView

-(void)awakeFromNib{
    
}

+ (instancetype)view
{
    return [[[NSBundle mainBundle] loadNibNamed:@"CSGooddetailsTopView" owner:nil options:nil] firstObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  CSCenterLineLabel.m
//  shop
//
//  Created by newtouch on 16/5/5.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import "CSCenterLineLabel.h"

@implementation CSCenterLineLabel


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    UIRectFill(CGRectMake(0, rect.size.height * 0.5, rect.size.width, 1));
}


@end

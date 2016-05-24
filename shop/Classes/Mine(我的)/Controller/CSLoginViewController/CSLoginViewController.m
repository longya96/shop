//
//  CSLoginViewController.m
//  shop
//
//  Created by newtouch on 16/5/9.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import "CSLoginViewController.h"

@interface CSLoginViewController ()
{
    UIView *bgNavView;
}
@end

@implementation CSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)clickBtn:(UIButton *)sender {
    switch (sender.tag) {
        case 102:{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        break;
        }
        case 103:{
            break;
        }
        default:
        break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

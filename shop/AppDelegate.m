//
//  AppDelegate.m
//  shop
//
//  Created by newtouch on 16/4/19.
//  Copyright © 2016年 vavens. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "CSHomeViewController.h"
#import "CSSortViewController.h"
#import "CSCarViewController.h"
#import "CSMineViewController.h"
#import "CSDiscoveryViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>
@property (nonatomic,strong) UITabBarController *tabbar;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self initTabBarController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self isConnectionAvailable];
    [self registered];
    return YES;
}

-(void)initTabBarController{
    CSHomeViewController *homeVC = [[CSHomeViewController alloc] init];
    
    UINavigationController*homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    homeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"tabbar_00"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_00_s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    CSSortViewController *sortVC = [[CSSortViewController alloc]init];
    UINavigationController *sortNav = [[UINavigationController alloc] initWithRootViewController:sortVC];
    sortNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分类" image:[[UIImage imageNamed:@"tabbar_01"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_01_s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    CSCarViewController *carVC = [[CSCarViewController alloc] init];
    UINavigationController *carNav = [[UINavigationController alloc] initWithRootViewController:carVC];
    carNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"购物车" image:[[UIImage imageNamed:@"tabbar_02"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_02_s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    CSMineViewController *mineVC = [[CSMineViewController alloc]init];
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人中心" image:[[UIImage imageNamed:@"tabbar_03"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_03_s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    CSDiscoveryViewController *discoveryVC = [[CSDiscoveryViewController alloc]init];
    UINavigationController *discoveryNav = [[UINavigationController alloc] initWithRootViewController:discoveryVC];
    discoveryNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[[UIImage imageNamed:@"tabbar_04"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_04_s"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    
    _tabbar = [[UITabBarController alloc] init];
    
    _tabbar.delegate = self;
    
    _tabbar.viewControllers = @[homeNav, sortNav, carNav, mineNav, discoveryNav];
    
    _tabbar.tabBar.barTintColor = UIColorFromRGB(0xf8f8f8);
    
    _tabbar.tabBar.translucent = NO;
    //e16527
//    0xDB0013
    UIColor *titleHighlightedColor = UIColorFromRGB(0xFF522A);
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor blackColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    
    self.window.rootViewController = _tabbar;
}


-(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"2G/3G/4G");
            break;
    }
    
    if (!isExistenceNetwork)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查网络连接" delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    return isExistenceNetwork;
}

- (void)registered{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
}

- (void)alertView:(UIAlertController *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        exit(0);
    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

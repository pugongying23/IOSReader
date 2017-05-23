//
//  AppDelegate.m
//  Aphrodite
//
//  Created by XuanLiang on 25/2/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "AppDelegate.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVFoundation/AVFoundation.h>
#import "localStorage.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    UITabBarController *  tabBarController  = [[UITabBarController alloc]init];
    
    UINavigationController *  Bookworld = [[UINavigationController alloc]initWithRootViewController:[[BookworldViewController alloc]init]];
    
    UINavigationController * Bookshelf = [[UINavigationController alloc]initWithRootViewController: [[BookshelfViewController alloc]init]];
    
    UINavigationController * Find  = [[UINavigationController alloc]initWithRootViewController:[[FindViewController alloc]init]];
    
    UINavigationController * Mine = [[UINavigationController alloc]initWithRootViewController:[[MineViewController alloc]init]];
    
    
    tabBarController.viewControllers =  [[NSArray alloc]initWithObjects:Bookworld,Bookshelf,Find,Mine, nil];
    
    UITabBarItem * BookworldItem = [[UITabBarItem alloc]initWithTitle:@"书城" image:[UIImage imageNamed:@"home"]selectedImage:[UIImage imageNamed:@"home"]];
    
    UITabBarItem * BookshelfItem = [[UITabBarItem alloc]initWithTitle:@"书架" image:[UIImage imageNamed:@"bookshelf"]selectedImage:[UIImage imageNamed:@"bookshelf"]];
    
    UITabBarItem * FindItem = [[UITabBarItem alloc]initWithTitle:@"分类" image:[UIImage imageNamed:@"Find"]selectedImage:[UIImage imageNamed:@"Find"]];
    
    UITabBarItem * MineItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"Mine"]selectedImage:[UIImage imageNamed:@"Mine"]];
    
    Bookworld.tabBarItem = BookworldItem;
    
    Bookshelf.tabBarItem = BookshelfItem;
    
    Find.tabBarItem = FindItem;
    
    Mine.tabBarItem = MineItem;
    

    Bookworld.tabBarController.tabBar.tintColor = TINT_COLOR;
    
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
    
    //字体 颜色 便好设置
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [user setObject:MY_FONT_VALUE forKey:MY_FONT_KEY];
    [user setObject:MY_FONT_SIZE_VALUE forKey:MY_FONT_SIZE_KEY];
    [user setObject:@"0" forKey:USER_OLD_ID_KEY];
    [user setObject:@"0" forKey:USER_ID_KEY];
    [user setObject:@"登陆账号后可以获取更过信息" forKey:USER_NAME_KEY];
    [user setObject:READER_BACKGROUNDCOLOR_VALUE forKey:READER_BACKGROUNDCOLOR_KEY];
    [user synchronize];
    //初始化AVOSCloud
    [AVOSCloud setApplicationId:@"G2OwHTCvX7DM5GiMaxjA3dei-gzGzoHsz" clientKey:@"YoNIhJIwI2YmvoNRlCSYJhoH"];
    //如果想跟踪统计应用的打开情况，后面还可以添加下列代码
    //[AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
     [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
 
    [AVOSCloud setAllLogsEnabled:false];
    
    
    // 1.获取音频回话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // 2.设置后台播放类别
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    // 3.激活回话
    [session setActive:YES error:nil];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

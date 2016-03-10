//
//  AppDelegate.m
//  OutsourcingProject
//
//  Created by LingLi on 16/2/18.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "LoginViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)getAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    AppEngineManager *engineManager = [[AppEngineManager alloc]init];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    AppEngine *app = [[AppEngine alloc]init];
    OPLog(@"%@",app);
    //开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    //开始监听，会启动一个run loop
    [self.hostReach startNotifier];
    
    
    DBManager *db = [[DBManager sharedDBManager]initDBDirectoryWithPath:engineManager.dirDBSqlite];//打开数据库
    [db createDBTableWithTableName:@"MarkDateList"];
    
    
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"RBMSOist7FsKk2z7ujj1IZGZ" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor:[ConfigUITools colorWithR:214 G:35 B:36 A:1]];
    [[UINavigationBar appearance]setBarTintColor:[ConfigUITools colorWithR:200 G:60 B:61 A:1]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTranslucent:NO];
    //    [[UINavigationBar appearance] setTranslucent:NO];
    
    
    //    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [[UINavigationBar appearance] setTitleTextAttributes: dict];
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kUserLoginStatus]) {
        
        self.window.rootViewController = [[MainTabBarController alloc]init];
        
    }else {
        
        self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[LoginViewController alloc]init]];
        
    }
    
    
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
#pragma mark 消失角标1:接收到通知并点击进入应用
// 接收到本地消息
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"content：%@", notification.alertBody);
     NSLog(@"content：%@", notification.userInfo);
    // 角标设置为0 即消失.
    _localNotiID = [notification.userInfo objectForKey:@"id"];
    // 提示视图
    // UIActionSheet
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒消息" message:notification.alertBody delegate:self cancelButtonTitle:@"取消提醒" otherButtonTitles:@"确定", nil];
    
    // 弹出提示视图
    [alert show];
    
    application.applicationIconBadgeNumber = 0;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"ResignActive");
    //    [BMKMapView willBackGround];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    application.applicationIconBadgeNumber = 0;
    NSLog(@"BecomeActive");
    //    [BMKMapView didForeGround];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)reachabilityChanged:(NSNotification *)note
{
    Reachability *currReach = [note object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    
    //对连接改变做出响应处理动作
    NetworkStatus status = [currReach currentReachabilityStatus];
    //如果没有连接到网络就弹出提醒实况
    self.isReachable = YES;
    if(status == NotReachable)
    {
        NSUserDefaults *netStatus = [NSUserDefaults standardUserDefaults];
        [netStatus setBool:NO forKey:kNetworkConnecting];
        [netStatus synchronize];
        
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        //        [alert show];
        
        self.isReachable = NO;
        
        return;
    }
    if (status==kReachableViaWiFi||status==kReachableViaWWAN) {
        
        NSUserDefaults *netStatus = [NSUserDefaults standardUserDefaults];
        [netStatus setBool:YES forKey:kNetworkConnecting];
        [netStatus synchronize];
        self.isReachable = YES;
    }
}



- (BOOL)isExistenceNetwork
{
    BOOL isExistenceNetwork = false;
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.google.com"];  // 测试服务器状态
    
    switch([reachability currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = FALSE;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = TRUE;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = TRUE;
            break;
    }
    return  isExistenceNetwork;
}

+ (BOOL)isNetworkConecting {
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {
        
        return YES;
        
    }else {
        
        return NO;
        
    }
    
}

#pragma mark - AlertView Delegate
#pragma mark 某个下标的按钮被点击
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%li", buttonIndex);
    if (buttonIndex == 0) {
        NSArray *notificaitons = [[UIApplication sharedApplication] scheduledLocalNotifications];
//        //获取当前所有的本地通知
//        if (!notificaitons || notificaitons.count <= 0) {
//            return;
//        }
        for (UILocalNotification *notify in notificaitons) {
            if ([[notify.userInfo objectForKey:@"id"] isEqualToString:_localNotiID]) {
                //取消一个特定的通知
                [[UIApplication sharedApplication] cancelLocalNotification:notify];
                break;
            }
            

        }
        
        //取消所有的本地通知
//        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        
    }

    
    
    
}
@end

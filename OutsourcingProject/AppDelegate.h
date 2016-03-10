//
//  AppDelegate.h
//  OutsourcingProject
//
//  Created by LingLi on 16/2/18.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件


@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Reachability *hostReach;
@property (assign, nonatomic) BOOL         isReachable;
@property (strong, nonatomic) BMKMapManager *mapManager;

@property (strong, nonatomic) NSString *localNotiID;
+ (AppDelegate *)getAppDelegate;

+ (BOOL)isNetworkConecting;

@end


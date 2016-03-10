//
//  BaiduMapViewController.h
//  OutsourcingProject
//
//  Created by LingLi on 16/3/9.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaiduMapViewController : JustBackBtn
@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;

@property (nonatomic, strong) NSString *destination;

@end

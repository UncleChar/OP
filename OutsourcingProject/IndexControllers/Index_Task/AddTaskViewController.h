//
//  AddTaskViewController.h
//  OutsourcingProject
//
//  Created by LingLi on 16/2/23.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "JustBackBtn.h"
typedef enum {
    ENUM_ShowWithExistInfo=0,//开始
    ENUM_ShowWithEditInfo//停止
} enum_showType;
@interface AddTaskViewController : JustBackBtn
@property (nonatomic, assign) enum_showType  ENUMShowType;

@property (nonatomic, strong) NSString *extDate;
@property (nonatomic, strong) NSString *sendDate;
@property (nonatomic, strong) NSString *receiveNamess;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *titleTopc;

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, assign) BOOL isChongxin;


@end

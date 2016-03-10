//
//  AddScheduleViewController.h
//  OutsourcingProject
//
//  Created by LingLi on 16/2/24.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ENUM_ScheduleEdit=0,//开始
    ENUM_ScheduleCreate,//停止
    ENUM_ScheduleSubmitCreate,
    ENUM_ScheduleSaveEdit,
    ENUM_ScheduleDelete
} ENUM_Schedule;

typedef void(^DeleteSchBlock)(BOOL );

@interface AddScheduleViewController : JustBackBtn
@property (nonatomic, assign) ENUM_Schedule  enum_schedule;
@property (nonatomic, strong) DeleteSchBlock deleteBlock;
@property (nonatomic, strong) NSString *schId;
@end

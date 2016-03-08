//
//  FinalDetailContentViewController.h
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/28.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "JustBackBtn.h"

typedef enum {
    Enum_ActionModuleCanclePraise=0,//
    Enum_ActionModulePraise,//
    Enum_ActionModuleCancleFavor,//
    Enum_ActionModuleFavor
} Enum_ActionModule;



@interface FinalDetailContentViewController : JustBackBtn
@property (nonatomic, strong) NSString *chID;
@property (nonatomic, strong) NSString *dataType;
@property (nonatomic, strong) NSString *titleTop;

@property (nonatomic, assign) NSInteger diffTag;//区分第三种model
@property (nonatomic, strong) NSString  *diffContent;//区分第三种model

@property (nonatomic, assign) BOOL isBtn;//区分第三种model
@property (nonatomic, strong) NSString *sendDate;
@property (nonatomic, strong) NSString *senderName;


@property (nonatomic, assign) BOOL isHasClassify;//区分
@property (nonatomic, assign) BOOL isReceiver;

@property (nonatomic, strong) NSString *showTitle;

@property (nonatomic, assign) BOOL   isFavor;



@property (nonatomic, strong) NSString *ChTopicPost;
@property (nonatomic, strong) NSString *DataTypepost;
@property (nonatomic, strong) NSString *chContentPost;
@property (nonatomic, strong) NSString *senderIconpicPost;
@property (nonatomic, strong) NSString *memberCode;
@property (nonatomic, strong) NSString *dataCode;
@property (nonatomic, strong) NSString *PhoneIC;
//@property (nonatomic, strong) NSString *senderName = "\U7ba1\U7406\U5458";
@property (nonatomic, assign) Enum_ActionModule  enum_action;

@end

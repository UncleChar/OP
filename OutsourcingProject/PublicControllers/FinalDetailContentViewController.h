//
//  FinalDetailContentViewController.h
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/28.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "JustBackBtn.h"

@interface FinalDetailContentViewController : JustBackBtn
@property (nonatomic, strong) NSString *chID;
@property (nonatomic, strong) NSString *dataType;
@property (nonatomic, strong) NSString *titleTop;

@property (nonatomic, assign) NSInteger diffTag;//区分第三种model
@property (nonatomic, strong) NSString  *diffContent;//区分第三种model

@property (nonatomic, assign) BOOL isBtn;//区分第三种model
@property (nonatomic, strong) NSString *sendDate;
@property (nonatomic, strong) NSString *senderName;
@end

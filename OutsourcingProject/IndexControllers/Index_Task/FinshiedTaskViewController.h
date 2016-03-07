//
//  FinshiedTaskViewController.h
//  OutsourcingProject
//
//  Created by LingLi on 16/3/7.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "JustBackBtn.h"

@interface FinshiedTaskViewController : JustBackBtn

@property (nonatomic, strong) NSString *titleTopic;
@property (nonatomic, strong) NSString *senderName;

@property (nonatomic, strong) NSString *expDate;
@property (nonatomic, strong) NSString *sendDate;
@property (nonatomic, strong) NSString *numberT;
@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *chid;
@property (nonatomic, assign) NSInteger requestTag;

@end

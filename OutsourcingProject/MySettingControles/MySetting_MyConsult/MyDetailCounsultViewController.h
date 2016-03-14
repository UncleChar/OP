//
//  MyDetailCounsultViewController.h
//  OutsourcingProject
//
//  Created by UncleChar on 16/3/14.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "JustBackBtn.h"

@interface MyDetailCounsultViewController : JustBackBtn

@property (nonatomic, strong) NSString *senderName;
@property (nonatomic, strong) NSString *sendDate;
@property (nonatomic, strong) NSString *isReceipt;
@property (nonatomic, strong) NSString *ChTopic;
@property (nonatomic, strong) NSString *chContent;
@property (nonatomic, strong) NSString *chID;
@property (nonatomic, strong) NSString *receiptDate;

@property (nonatomic, strong) NSString *showTitle;
@property (nonatomic, strong) NSString *dataType;

@property (nonatomic, assign) BOOL  isRep;

@end

//
//  SendingDetailViewController.h
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/29.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "JustBackBtn.h"

@interface SendingDetailViewController : JustBackBtn
@property (nonatomic, strong) NSString *senderName;
@property (nonatomic, strong) NSString *sendDate;
@property (nonatomic, strong) NSString *isReceipt;
@property (nonatomic, strong) NSString *ChTopic;
@property (nonatomic, strong) NSString *chContent;

@end

//
//  IndexNotiModel.h
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/26.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndexNotiModel : NSObject
@property (nonatomic, strong) NSString *AllCount;
@property (nonatomic, strong) NSString *ChID;
@property (nonatomic, strong) NSString *ChTopic;
@property (nonatomic, strong) NSString *SnID;
@property (nonatomic, strong) NSString *chContent;
@property (nonatomic, strong) NSString *isReceipt;
@property (nonatomic, strong) NSString *readStatus;
@property (nonatomic, strong) NSString *receiptDate;
@property (nonatomic, strong) NSString *receiptStatus;
@property (nonatomic, strong) NSString *sendDate;
@property (nonatomic, strong) NSString *senderIconpic;
@property (nonatomic, strong) NSString *senderName;
@property (nonatomic, strong) NSString *urgLevel;
@end

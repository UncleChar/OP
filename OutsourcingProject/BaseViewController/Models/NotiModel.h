//
//  NotiModel.h
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/25.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotiModel : NSObject
@property (nonatomic, strong) NSString *ChID;
@property (nonatomic, strong) NSString *allCount;
@property (nonatomic, strong) NSString *chtopic;
@property (nonatomic, strong) NSString *isReceipt;
@property (nonatomic, strong) NSString *readStatus;
@property (nonatomic, strong) NSString *receiptStatus;
@property (nonatomic, strong) NSString *sendDate;
@property (nonatomic, strong) NSString *senderName;
@property (nonatomic, strong) NSString *urgLevel;
@end

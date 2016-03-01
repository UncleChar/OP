//
//  NotiDetialViewController.h
//  OutsourcingProject
//
//  Created by UncleChar on 16/3/1.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "JustBackBtn.h"



typedef void(^DeleteBlock)( NSInteger tag);

@interface NotiDetialViewController : JustBackBtn

@property (nonatomic, strong) NSString *senderName;
@property (nonatomic, strong) NSString *receiverName;
@property (nonatomic, strong) NSString *sendDate;
@property (nonatomic, strong) NSString *isReceipt;
@property (nonatomic, strong) NSString *ChTopic;
@property (nonatomic, strong) NSString *chContent;
@property (nonatomic, strong) DeleteBlock deleteBlock;
@property (nonatomic, assign) NSInteger headTag;
@property (nonatomic, strong) NSString *ChID;


@property (nonatomic, strong) NSString *ExpDate;
@property (nonatomic, strong) NSString *aSendDate;
@property (nonatomic, strong) NSString *allCount;
@property (nonatomic, strong) NSString *chtopic;
@property (nonatomic, strong) NSString *readStatus;


@end

//
//  ActivityDetailViewController.h
//  OutsourcingProject
//
//  Created by LingLi on 16/3/1.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "JustBackBtn.h"

typedef void(^DeleteBlock)( NSInteger tag);

@interface ActivityDetailViewController : JustBackBtn
@property (nonatomic, strong) NSString *senderName;
@property (nonatomic, strong) NSString *receiverName;
@property (nonatomic, strong) NSString *sendDate;
@property (nonatomic, strong) NSString *isReceipt;
@property (nonatomic, strong) NSString *ChTopic;
@property (nonatomic, strong) NSString *chContent;
@property (nonatomic, strong) DeleteBlock deleteBlock;
@property (nonatomic, assign) NSInteger blockTag;
@property (nonatomic, strong) NSString *ChID;
@end

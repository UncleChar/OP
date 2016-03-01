//
//  SubGuideModel.h
//  OutsourcingProject
//
//  Created by LingLi on 16/2/26.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubGuideModel : UIViewController
@property (nonatomic, strong) NSString *AllCount;
@property (nonatomic, strong) NSString *ChID;
@property (nonatomic, strong) NSString *ChTopic;
@property (nonatomic, strong) NSString *DataType;
@property (nonatomic, strong) NSString *PublishDate;
@property (nonatomic, strong) NSString *SnID;
@property (nonatomic, strong) NSString *senderIconpic;
@property (nonatomic, strong) NSString *senderName;

//以下是区别成果展示多出来的model的信息
@property (nonatomic, strong) NSString *acceptStatus;
@property (nonatomic, strong) NSString *readStatus;
@property (nonatomic, strong) NSString *chContent;
@property (nonatomic, strong) NSString *FinshDate;

//一下是为了我发出的动态model增加
@property (nonatomic, strong) NSString *receiverName;
@property (nonatomic, strong) NSString *sendDate;
@property (nonatomic, strong) NSString *endDate;
@end

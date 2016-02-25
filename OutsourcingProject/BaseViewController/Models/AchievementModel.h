//
//  AchievementModel.h
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/25.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AchievementModel : NSObject


@property (nonatomic, strong) NSString *ChID;
@property (nonatomic, strong) NSString *ChTopic;
@property (nonatomic, strong) NSString *FinshDate;
@property (nonatomic, strong) NSString *SnID;
@property (nonatomic, strong) NSString *acceptDate;
@property (nonatomic, strong) NSString *acceptStatus;
@property (nonatomic, strong) NSString *attfile;
@property (nonatomic, strong) NSString *chContent;
@property (nonatomic, strong) NSString *dataType;
@property (nonatomic, strong) NSString *readStatus;
@property (nonatomic, strong) NSString *sendDate;
@property (nonatomic, strong) NSString *senderIconpic;
@property (nonatomic, strong) NSString *senderName;

@end

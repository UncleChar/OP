//
//  ActivityModel.h
//  OutsourcingProject
//
//  Created by LingLi on 16/3/4.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityModel : NSObject
@property (nonatomic, strong) NSString *ChID;
@property (nonatomic, strong) NSString *ExpDate;
@property (nonatomic, strong) NSString *sendDate;
@property (nonatomic, strong) NSString *allCount;
@property (nonatomic, strong) NSString *ChTopic;
@property (nonatomic, strong) NSString *readStatus;
@end

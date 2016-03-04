//
//  OfficalDocModel.h
//  OutsourcingProject
//
//  Created by LingLi on 16/3/4.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OfficalDocModel : NSObject

@property (nonatomic, strong) NSString *AllCount;
@property (nonatomic, strong) NSString *ChID;
@property (nonatomic, strong) NSString *SnID;
@property (nonatomic, strong) NSString *chContent;
@property (nonatomic, strong) NSString *chtopic;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *fawendept;
@property (nonatomic, strong) NSString *publishDate;
@property (nonatomic, strong) NSString *readDate;
@property (nonatomic, strong) NSString *readStatus;
@property (nonatomic, strong) NSString *secretlevel;
@property (nonatomic, strong) NSString *senderIconpic;
@property (nonatomic, strong) NSString *senderName;
@property (nonatomic, strong) NSString *wenhao;

@property (nonatomic, assign) BOOL     isChecking;
@end

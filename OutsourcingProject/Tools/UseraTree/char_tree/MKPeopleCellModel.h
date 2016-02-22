//
//  ViewController.m
//  MKTreeTest
//
//  Created by 张平 on 15/12/24.
//  Copyright © 2015年 zhangping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKPeopleCellModel : NSObject

@property (assign, nonatomic) NSInteger messageId;//主键id
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *peoples;
@property (strong, nonatomic) NSDictionary *peopleDic;
@property (strong, nonatomic) NSArray *node;
@property (strong, nonatomic) NSString *mobile;
@property (strong, nonatomic) NSString *mobileID;

@property (strong, nonatomic) NSString *ename;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *isParent;
@property (strong, nonatomic) NSString *pId;

@property (assign, nonatomic) BOOL isCheck;

+ (MKPeopleCellModel *)sharedPeople;

+ (void)clear;

- (void)updateWithDictionary:(NSDictionary *)dict;

- (void)savePeoples;

- (id)initWithName:(NSString *)name people:(NSArray *)people;

+ (id)dataObjectWithName:(NSString *)name children:(NSArray *)peoples;

@end

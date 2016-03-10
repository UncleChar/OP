//
//  UnionInfoViewController.h
//  OutsourcingProject
//
//  Created by LingLi on 16/3/10.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "JustBackBtn.h"

@interface UnionInfoViewController : JustBackBtn

@property (nonatomic, strong) NSString  *name;
@property (nonatomic, strong) NSString  *address;
@property (nonatomic, strong) NSString  *code;
@property (nonatomic, strong) NSString  *createTime;
@property (nonatomic, strong) NSString  *president;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *locationName;

@end

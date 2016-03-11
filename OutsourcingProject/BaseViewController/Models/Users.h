//
//  Users.h
//  OutsourcingProject
//
//  Created by LingLi on 16/2/19.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Users : NSObject


@property (nonatomic,strong)  NSString*   addr;
@property (nonatomic, strong) NSString*   deptcode;
@property (nonatomic, strong) NSString*   deptname;
@property (nonatomic, strong) NSString*   email;
@property (nonatomic, retain) NSString*   iconpic;
@property (nonatomic, strong) NSString*   logincookie;

@property (nonatomic, strong) NSString*   shengri;
@property (nonatomic, retain) NSString*   shouji;
@property (nonatomic, retain) NSString*   usercode;
@property (nonatomic, retain) NSString*   usertype;
@property (nonatomic, retain) NSString*   xingbie;
@property (nonatomic, retain) NSString*   xingming;



@property (nonatomic, retain) NSString*   lizhidate;
@property (nonatomic, retain) NSString*   phone;
@property (nonatomic, retain) NSString*   qqid;
@property (nonatomic, retain) NSString*   ruzhidate;

@property (nonatomic, retain) NSString*   tel_home;
@property (nonatomic, retain) NSString*   tel_office;

@property (nonatomic, retain) NSString*   zhiwu;
@property (nonatomic, retain) NSString*   zhize;



@property (nonatomic, retain) NSString*   gonghuimingcheng;
@property (nonatomic, retain) NSString*   gongzuodanwei;
@property (nonatomic, retain) NSString*   number;

@end

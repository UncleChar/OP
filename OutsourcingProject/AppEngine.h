//
//  AppEngine.h
//
//  Created by Peteo on 12-5-15.
//  Copyright 2012 The9. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Users.h"

@interface AppEngine : NSObject

@property (nonatomic,retain) Users * owner;


//实现单利方法
+(AppEngine *) GetAppEngine;

//必须初始化时候调用
-(void) Initialization;


-(void)saveUserLoginInfo:(NSMutableDictionary*) userDict;






@end

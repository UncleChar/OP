//
//  AppEngine.m
//
//  Created by Peteo on 12-5-15.
//  Copyright 2012 The9. All rights reserved.
//

#import "AppEngine.h"

@implementation AppEngine


static AppEngine * AppEngineInstance = nil; //单例对象

+(AppEngine *) GetAppEngine
{
	@synchronized(self)
	{
		if (AppEngineInstance == nil)
		{
			AppEngineInstance = [[self alloc] init];
		}
	}
	return AppEngineInstance;
}


- (instancetype)init {
    
    if (self = [super init]) {
        

        self.owner = [[Users alloc]init];
        
    }
    return self;
}



-(void) saveUserLoginInfo:(NSMutableDictionary*) userDict
{

    _owner.addr = [userDict objectForKey:@"addr"];
    _owner.deptcode = [userDict objectForKey:@"deptcode"];
    _owner.deptname = [userDict objectForKey:@"deptname"];
    _owner.email = [userDict objectForKey:@"email"];
    _owner.iconpic = [userDict objectForKey:@"iconpic"];
    _owner.logincookie = [userDict objectForKey:@"logincookie"];
    _owner.shengri = [userDict objectForKey:@"shengri"];
    _owner.shouji = [userDict objectForKey:@"shouji"];
    _owner.usercode = [userDict objectForKey:@"usercode"];
    _owner.usertype = [userDict objectForKey:@"usertype"];
    _owner.xingbie = [userDict objectForKey:@"xingbie"];
    _owner.xingming = [userDict objectForKey:@"xingming"];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:_owner.addr forKey:@"addr"];
    [defaults setObject:_owner.deptcode forKey:@"deptcode"];
    [defaults setObject:_owner.deptname forKey:@"deptname"];
    [defaults setObject:_owner.email forKey:@"email"];
    [defaults setObject:_owner.iconpic forKey:@"iconpic"];
    [defaults setObject:_owner.logincookie forKey:@"logincookie"];
    [defaults setObject:_owner.shengri forKey:@"shengri"];
    [defaults setObject:_owner.usercode forKey:@"usercode"];
    [defaults setObject:_owner.usertype forKey:@"usertype"];
    [defaults setObject:_owner.xingbie forKey:@"xingbie"];
    [defaults setObject:_owner.xingming forKey:@"xingming"];
    [defaults setObject:_owner.shouji forKey:@"shouji"];

    [defaults synchronize];//同步写入到文件
}





@end

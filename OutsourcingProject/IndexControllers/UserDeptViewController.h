//
//  UserDeptViewController.h
//  OutsourcingProject
//
//  Created by LingLi on 16/2/22.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectedUsersBlock)(NSArray *);
@interface UserDeptViewController : JustBackBtn

@property (nonatomic, assign) BOOL  isJump;
@property (nonatomic, strong) selectedUsersBlock selectedBlock;

@end

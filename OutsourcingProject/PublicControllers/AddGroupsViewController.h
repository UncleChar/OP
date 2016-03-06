//
//  AddGroupsViewController.h
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/22.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "JustBackBtn.h"

typedef void(^SubmitAddUserGroups)( BOOL isSuccess);

@interface AddGroupsViewController : JustBackBtn
@property (nonatomic, strong) SubmitAddUserGroups submitBtnBlock;
@end

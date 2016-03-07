//
//  TaskTableViewCell.h
//  OutsourcingProject
//
//  Created by LingLi on 16/3/7.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IndexNotiModel;
@interface TaskTableViewCell : UITableViewCell
@property (nonatomic, strong) IndexNotiModel *model;
@property (nonatomic, strong) NSString       *cellTag;
@end

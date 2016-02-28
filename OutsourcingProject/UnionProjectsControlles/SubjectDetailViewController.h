//
//  SubjectDetailViewController.h
//  OutsourcingProject
//
//  Created by LingLi on 16/2/26.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubjectDetailViewController : JustBackBtn


@property (nonatomic, assign) NSInteger requestTag;
@property (nonatomic, strong) NSString *subjectTitle;
@property (nonatomic, strong) NSString  *dataType;
@property (nonatomic, strong) NSString  *filter;

@property (nonatomic, assign) NSInteger MokuaiTag;


@end

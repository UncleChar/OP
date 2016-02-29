//
//  SendingDetailViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/29.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "SendingDetailViewController.h"

@interface SendingDetailViewController ()

@end

@implementation SendingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知详情";
    
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, kScreenWidth, 50)];
    titleLabel.text =self.ChTopic;
    titleLabel.textAlignment = 1;
    titleLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    UIView  *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 51, kScreenWidth, 2)];
    lineView.backgroundColor = [UIColor orangeColor];
    [titleLabel addSubview:lineView];
    
    UILabel *senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 53, kScreenWidth, 40)];
    senderLabel.text =   [NSString stringWithFormat:@"  通知发送者:    %@",self.senderName];
    //    titleLabel.textAlignment = 1;
    senderLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:senderLabel];
    
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 94, kScreenWidth, 40)];
    dateLabel.text = [NSString stringWithFormat:@"  发送时间:       %@",self.sendDate];
    //    titleLabel1.textAlignment = 1;
    dateLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dateLabel];

    
    UILabel *receiptLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 135, kScreenWidth, 40)];
    receiptLabel.text = [NSString stringWithFormat:@"  回执时间:       %@",self.isReceipt];
    //    titleLabel1.textAlignment = 1;
    receiptLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:receiptLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end

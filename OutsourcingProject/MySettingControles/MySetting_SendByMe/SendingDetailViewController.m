//
//  SendingDetailViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/29.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "SendingDetailViewController.h"

@interface SendingDetailViewController ()
@property (nonatomic, strong) UIScrollView *backgroungScrollView;
@end

@implementation SendingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知详情";
    
    _backgroungScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _backgroungScrollView.backgroundColor = kBackColor;
    _backgroungScrollView.userInteractionEnabled = YES;
    [self.view addSubview:_backgroungScrollView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, kScreenWidth, 50)];
    titleLabel.text =self.ChTopic;
    titleLabel.textAlignment = 1;
    titleLabel.backgroundColor = [UIColor whiteColor];
    [self.backgroungScrollView addSubview:titleLabel];
    
    UIView  *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 51, kScreenWidth, 2)];
    lineView.backgroundColor = [UIColor orangeColor];
    [titleLabel addSubview:lineView];
    
    UILabel *senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 53, kScreenWidth, 40)];
    senderLabel.text =   [NSString stringWithFormat:@"  通知发送者:    %@",self.senderName];
    //    titleLabel.textAlignment = 1;
    senderLabel.backgroundColor = [UIColor whiteColor];
    [self.backgroungScrollView addSubview:senderLabel];
    
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 94, kScreenWidth, 40)];
    dateLabel.text = [NSString stringWithFormat:@"  发送时间:       %@",self.sendDate];
    //    titleLabel1.textAlignment = 1;
    dateLabel.backgroundColor = [UIColor whiteColor];
    [self.backgroungScrollView addSubview:dateLabel];

    
    UILabel *receiptLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 135, kScreenWidth, 40)];
    receiptLabel.text = [NSString stringWithFormat:@"  回执时间:       %@",self.isReceipt];
    //    titleLabel1.textAlignment = 1;
    receiptLabel.backgroundColor = [UIColor whiteColor];
    [self.backgroungScrollView addSubview:receiptLabel];
    
    
    // 计算model.desc文字的高度
    CGFloat descLabelHeight = [ConfigUITools calculateTextHeight:self.chContent size:CGSizeMake(kScreenWidth, MAXFLOAT) font:OPFont(14.0f)];

    CGFloat height;
    if (descLabelHeight <40.0) {
        
        height = 40;
        
    }else {
    
        height = descLabelHeight;
        
    }
    
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 176, kScreenWidth , height)];
    contentLabel.text = self.chContent;
    contentLabel.backgroundColor = [UIColor whiteColor];
    contentLabel.font = OPFont(14.0);
    [self.backgroungScrollView addSubview:contentLabel];
    
     [ConfigUITools sizeToScroll:_backgroungScrollView withStandardElementMaxY:CGRectGetMaxY(contentLabel.frame) + 25 forStepsH:0];
    
}




@end

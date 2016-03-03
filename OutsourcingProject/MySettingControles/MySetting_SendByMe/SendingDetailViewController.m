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
    self.title = @"我发出的通知详情";
    
    _backgroungScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _backgroungScrollView.backgroundColor = kBackColor;
    _backgroungScrollView.userInteractionEnabled = YES;
    [self.view addSubview:_backgroungScrollView];
    
    UITextView *titleLabel = [[UITextView alloc]init];
    titleLabel.text =self.ChTopic;
    titleLabel.textAlignment = 1;
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    [self.backgroungScrollView addSubview:titleLabel];
    
    
    NSString *contenttitle = [self.ChTopic htmlEntityDecode];
    // 计算model.desc文字的高度
    CGFloat descLabelH = [ConfigUITools calculateTextHeight:contenttitle size:CGSizeMake(kScreenWidth, MAXFLOAT) font:OPFont(17)];
    
    CGFloat height;
    if (descLabelH <40) {
        
        height = 40;
        
    }else {
        
        height = descLabelH + 15;
        
    }
    titleLabel.frame = CGRectMake(0, 1, kScreenWidth, height);
    titleLabel.text = contenttitle;
    titleLabel.userInteractionEnabled = NO;
    
    
    
    UIView  *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, height+ 1, kScreenWidth, 2)];
    lineView.backgroundColor = [UIColor orangeColor];
    [_backgroungScrollView addSubview:lineView];
    
    UILabel *senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, height+ 3, kScreenWidth, 40)];
    senderLabel.text =   [NSString stringWithFormat:@"  通知发送者:    %@",self.senderName];
    //    titleLabel.textAlignment = 1;
    senderLabel.backgroundColor = [UIColor whiteColor];
    [self.backgroungScrollView addSubview:senderLabel];
    
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, height+ 44, kScreenWidth, 40)];
    dateLabel.text = [NSString stringWithFormat:@"  发送时间:       %@",self.sendDate];
    //    titleLabel1.textAlignment = 1;
    dateLabel.backgroundColor = [UIColor whiteColor];
    [self.backgroungScrollView addSubview:dateLabel];

    
    UILabel *receiptLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, height+ 85, kScreenWidth, 40)];
    receiptLabel.text = [NSString stringWithFormat:@"  回执时间:       %@",self.isReceipt];
    //    titleLabel1.textAlignment = 1;
    receiptLabel.backgroundColor = [UIColor whiteColor];
    [self.backgroungScrollView addSubview:receiptLabel];
    
    
    
    NSString *conten = [self.chContent htmlEntityDecode];
//    // 计算model.desc文字的高度
//    CGFloat descLabelHeight = [ConfigUITools calculateTextHeight:conten size:CGSizeMake(kScreenWidth, MAXFLOAT) font:OPFont(14.0f)];
//
//    CGFloat height1;
//    if (descLabelHeight <40.0) {
//        
//        height1 = 40;
//        
//    }else {
//    
//        height1 = descLabelHeight;
//        
//    }
    
//    UITextView *contentView = [[UITextView alloc]initWithFrame:CGRectMake(0, 176, kScreenWidth , height1)];
//    contentView.text = conten;
//    contentView.backgroundColor = [UIColor whiteColor];
//    contentView.font = OPFont(14.0);
//    [self.backgroungScrollView addSubview:contentView];
    
    
   UITextView *showWebView = [[UITextView alloc] initWithFrame:CGRectMake(0, height + 127, kScreenWidth, kScreenHeight- height- 127 - 64 )];
    
//    [showWebView sizeToFit];
//    showWebView.scalesPageToFit = YES;
    //        [showWebView sizeToFit];
    //        showWebView.scalesPageToFit = YES;
    showWebView.text = conten;
    [showWebView setEditable:NO];
    [self.view addSubview:showWebView];
//    [showWebView loadHTMLString:self.chContent baseURL:[NSURL URLWithString:@"www.baidu.com"]];
    
//     [ConfigUITools sizeToScroll:_backgroungScrollView withStandardElementMaxY:CGRectGetMaxY(contentView.frame) + 25 forStepsH:0];
    
}




@end

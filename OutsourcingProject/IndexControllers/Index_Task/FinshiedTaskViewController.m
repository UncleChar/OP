//
//  FinshiedTaskViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/3/7.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "FinshiedTaskViewController.h"

@interface FinshiedTaskViewController ()
{
    
    ReturnValueBlock returnBlock;
    UILabel *secretLabel;
    UITextView *showView;
    
    
}
@end

@implementation FinshiedTaskViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = 1;

    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.text = self.titleTopic;
    [self.view addSubview:titleLabel];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), kScreenWidth, 1)];
    lineView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:lineView];
    
    UILabel *senderNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lineView.frame)+ 2, kScreenWidth - 20, 30)];
    senderNameLabel.font = OPFont(14);
    senderNameLabel.text = [NSString stringWithFormat:@"任务发布者:       %@",self.senderName];
    [self.view addSubview:senderNameLabel];
    
    UILabel *senderDeptLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(senderNameLabel.frame), kScreenWidth - 20, 30)];
    senderDeptLabel.font = OPFont(14);
    senderDeptLabel.text = [NSString stringWithFormat:@"发布时间:    %@",self.sendDate];
    [self.view addSubview:senderDeptLabel];
    
    
    secretLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(senderDeptLabel.frame), kScreenWidth - 20, 30)];
    secretLabel.font = OPFont(14);
    secretLabel.text = [NSString stringWithFormat:@"完成期限:    %@",self.expDate];
    [self.view addSubview:secretLabel];
    
    
    showView = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(secretLabel.frame), kScreenWidth, kScreenHeight- CGRectGetMaxY(secretLabel.frame)  - 64 )];
    
    //    [showWebView sizeToFit];
    //    showWebView.scalesPageToFit = YES;
    //        [showWebView sizeToFit];
    //        showWebView.scalesPageToFit = YES;
    //    showView.text = [self.content htmlEntityDecode];
    showView.font = OPFont(15);
    [showView setEditable:NO];
    [self.view addSubview:showView];
    
    //
    //    UIWebView *contentView = [[UIWebView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(senderDate.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(senderDate.frame) - 64 - 18)];
    //
    //    [contentView sizeToFit];
    //    contentView.scalesPageToFit = YES;
    //
    //    [contentView loadHTMLString:[self.content htmlEntityDecode] baseURL:[NSURL URLWithString:@"www.baidu.com"]];
    //
    //    [self.view addSubview:contentView];
    
    [self handleRequsetDetaiDate];
    

        
        [self NotiDetailWithType:@"wangchengdegongzuorenwu" chid:[self.chid integerValue]];

        
//        [self NotiDetailWithType:@"wodegongwenshenpi" chid:[self.chid integerValue]];

    
    
    
    
    
}

- (void)configAfterData:(NSDictionary *)dict {
    
    NSString *conten = [dict objectForKey:@"chContent"];
    showView.text = conten;
    
    
    
    
    
}



- (void)handleRequsetDetaiDate {
    
    
    __weak typeof (self) weakSelf = self;
    returnBlock = ^(id resultValue){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            
            
            
            
            if ([NSNull null] ==[[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"]) {
                [SVProgressHUD showErrorWithStatus:@"没有数据哦"];
                OPLog(@"-FF-%@",[[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"]);
                
                
            }else {
                
                SBJSON *jsonParser = [[SBJSON alloc] init];
                NSError *parseError = nil;
                NSString *str  =   [[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"] ;
                //                NSLog(@"ssss %@",str);
                str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                NSDictionary * result = [jsonParser objectWithString:str
                                                               error:&parseError];
                NSLog(@"jsonParserresult:%@",[result objectForKey:@"rows"]);
                NSDictionary *detailDict = [result objectForKey:@"rows"][0];
                
                [weakSelf configAfterData:detailDict];
                
                
            }
            
        });
        
        
        
    };
    
}


- (void)NotiDetailWithType:(NSString *)type chid:(NSInteger)cid {
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        //        [SVProgressHUD showWithStatus:@"增在加载..."];
        NSString * requestBody = [NSString stringWithFormat:
                                  @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                                  "<soap12:Envelope "
                                  "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                                  "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                                  "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                                  "<soap12:Body>"
                                  "<GetJsonContentData xmlns=\"Net.GongHuiTong\">"
                                  "<logincookie>%@</logincookie>"
                                  "<datatype>%@</datatype>"
                                  "<ChID>%ld</ChID>"
                                  " </GetJsonContentData>"
                                  "</soap12:Body>"
                                  "</soap12:Envelope>",[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],type,(long)cid];
        
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"GetJsonContentDataResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];
        
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    
    
}



@end

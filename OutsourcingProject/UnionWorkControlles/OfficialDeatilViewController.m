//
//  OfficialDeatilViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/3/4.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "OfficialDeatilViewController.h"

@interface OfficialDeatilViewController ()
{
    
    ReturnValueBlock returnBlock;
    UILabel *wenhao;
    UITextView *showView;

    
}
@end

@implementation OfficialDeatilViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = 1;
//    titleLabel.font = [U÷]
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.text = self.titleTopic;
    [self.view addSubview:titleLabel];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), kScreenWidth, 1)];
    lineView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:lineView];
    
    UILabel *senderNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lineView.frame)+ 2, kScreenWidth - 20, 30)];
    senderNameLabel.font = OPFont(14);
    senderNameLabel.text = [NSString stringWithFormat:@"发布者:       %@",self.senderName];
    [self.view addSubview:senderNameLabel];
    
    UILabel *senderDeptLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(senderNameLabel.frame), kScreenWidth - 20, 30)];
    senderDeptLabel.font = OPFont(14);
    senderDeptLabel.text = [NSString stringWithFormat:@"发布单位:    %@",self.senderDept];
    [self.view addSubview:senderDeptLabel];
    
    
    UILabel *secretLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(senderDeptLabel.frame), kScreenWidth - 20, 30)];
    secretLabel.font = OPFont(14);
    secretLabel.text = [NSString stringWithFormat:@"机密程度:    %@",self.secretLevel];
    [self.view addSubview:secretLabel];
    
    UILabel *senderDate = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(secretLabel.frame), kScreenWidth/2 , 30)];
    senderDate.font = OPFont(14);
    senderDate.text = [NSString stringWithFormat:@"发布时间:    %@",self.sendDate];
    [self.view addSubview:senderDate];
    
    wenhao = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 2 + 10 , CGRectGetMaxY(secretLabel.frame), kScreenWidth  / 2 - 10, 30)];
    wenhao.font = OPFont(13);
    wenhao.text = [NSString stringWithFormat:@"文号:    %@",self.numberT];
    [self.view addSubview:wenhao];
   
    
    showView = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(wenhao.frame), kScreenWidth, kScreenHeight- CGRectGetMaxY(wenhao.frame)  - 64 )];
    
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
    
    if (_requestTag == 0) {
        
          [self NotiDetailWithType:@"wodegongwenchayue" chid:[self.chid integerValue]];
    }else {
    
          [self NotiDetailWithType:@"wodegongwenshenpi" chid:[self.chid integerValue]];
    }
  
    

    
    
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

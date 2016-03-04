//
//  SendingDetailViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/29.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "SendingDetailViewController.h"

@interface SendingDetailViewController ()
{
    
    ReturnValueBlock returnBlock;
    UILabel *dateLabel;
    
}
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
    
    dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, height+ 44, kScreenWidth, 40)];
    dateLabel.text = [NSString stringWithFormat:@"  发送时间:       %@",self.sendDate];
    //    titleLabel1.textAlignment = 1;
    dateLabel.backgroundColor = [UIColor whiteColor];
    [self.backgroungScrollView addSubview:dateLabel];
    
    [self handleRequsetDetaiDate];
    
    [self NotiDetailWithType:@"fachudetongzhi" chid:[self.chID integerValue]];
   
}


- (void)configAfterData:(NSDictionary *)dict {

       NSString *conten = [dict objectForKey:@"chContent"];

       UITextView *showView = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(dateLabel.frame) + 1, kScreenWidth, kScreenHeight- CGRectGetMaxY(dateLabel.frame) - 1 - 64 )];
    
    //    [showWebView sizeToFit];
    //    showWebView.scalesPageToFit = YES;
        //        [showWebView sizeToFit];
        //        showWebView.scalesPageToFit = YES;
        showView.text = conten;
        showView.font = OPFont(16);
        [showView setEditable:NO];
        [self.view addSubview:showView];
    
    

    
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

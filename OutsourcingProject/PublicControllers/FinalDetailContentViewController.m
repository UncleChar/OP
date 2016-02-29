//
//  FinalDetailContentViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/28.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "FinalDetailContentViewController.h"

@interface FinalDetailContentViewController ()
{
    
    ReturnValueBlock returnBlock;
    UIWebView *showWebView;
    NSString   *imgUrl;
    NSString   *contentStr;
    UILabel *senderLabel;
    UILabel *dateLabel;
    UIButton *zanBtn;
    UIButton *favBtn;
    
}
@end

@implementation FinalDetailContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self createUIAfterRequestData];

    self.title = self.titleTop;
    
    [self configUIWith:self.isBtn];
    

   
    [self handleDate];
    
    [self getWebViewDataWithType:self.dataType ChID:[self.chID integerValue]];
    
    // Do any additional setup after loading the view.
}

- (void)configUIWith:(BOOL)isBtn {

   senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, kScreenWidth, 29)];
    senderLabel.text =   [NSString stringWithFormat:@"发布者:    %@",self.senderName];
    //    titleLabel.textAlignment = 1;
    senderLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:senderLabel];
    
    dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, 30)];
    dateLabel.text = [NSString stringWithFormat:@"发布时间:    %@",self.sendDate];
    //    titleLabel1.textAlignment = 1;
    dateLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dateLabel];
    

    if (isBtn) {
        
        showWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight - 150 )];
        
        [showWebView sizeToFit];
        showWebView.scalesPageToFit = YES;
        [self.view addSubview:showWebView];
        
        
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(showWebView.frame) - 48, kScreenWidth,80 )];
        bottomView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bottomView];
        
        zanBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth / 3 - 17.5, 12, 35, 35)];
        zanBtn.tag = 100;
        [zanBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-dianzan(1)（合并）"] forState:UIControlStateNormal];
        [zanBtn setBackgroundImage:[UIImage imageNamed:@"点击后点赞"] forState:UIControlStateSelected];
        [zanBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        zanBtn.selected = NO;
        [bottomView addSubview:zanBtn];
        
        
        favBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth / 3 * 2 - 17.5, 12, 35, 35)];
        [favBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-shoucang(5)（合并）"] forState:UIControlStateNormal];
        [favBtn setBackgroundImage:[UIImage imageNamed:@"点击后收藏"] forState:UIControlStateSelected];
        [favBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        favBtn.selected = NO;
        favBtn.tag = 101;
        [bottomView addSubview:favBtn];
        
    }else {
    
        showWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight - 120 )];
        
        [showWebView sizeToFit];
        showWebView.scalesPageToFit = YES;
        [self.view addSubview:showWebView];
        
    
    
    
    }
    


    
    
    
    

    

    
}

- (void)handleContent:(NSDictionary *)dict {
    
    senderLabel.text =   [NSString stringWithFormat:@"发布者:    %@",[[[dict objectForKey:@"rows"] lastObject] objectForKey:@"senderName"]];
    
  

    
    if (self.diffTag == 2) {
        
       dateLabel.text = [NSString stringWithFormat:@"发布时间:    %@",[[[dict objectForKey:@"rows"] lastObject] objectForKey:@"sendDate"]];

        
    }else {
    
    
    dateLabel.text =     [NSString stringWithFormat:@"发布时间:    %@",[[[dict objectForKey:@"rows"] lastObject] objectForKey:@"PublishDate"]];
    }
//
//    
//    if (!dateLabel.text) {
//        dateLabel.text = [NSString stringWithFormat:@"发布时间:    %@",[[[dict objectForKey:@"rows"] lastObject] objectForKey:@"PublishDate"]];
//    }
    
    if (self.isBtn) {
        
        if ([[[[dict objectForKey:@"rows"] lastObject] objectForKey:@"ShoucangCode"] integerValue] == 0) {
            
            
            favBtn.selected = NO;
        }else {
        
          favBtn.selected = YES;
        }
        
        if ([[[[dict objectForKey:@"rows"] lastObject] objectForKey:@"PraiseCode"] integerValue] == 0) {
            
            
            favBtn.selected = NO;
        }else {
            
            favBtn.selected = YES;
        }
        



    }else {
    
        
    
    
    }

     NSString *string = [[[dict objectForKey:@"rows"] lastObject] objectForKey:@"chContent"];
    
    NSString *content = [string htmlEntityDecode];
    
    content = [NSString stringWithFormat:@"<div> style= 'font-size:19px' %@</div>",content];
    content = [content stringByReplacingOccurrencesOfString:@"[img_http" withString:@"<center><img src = http"];
    
    content = [content stringByReplacingOccurrencesOfString:@"/ueditor/server/upload/../../../../" withString:@"/"];
    content = [content stringByReplacingOccurrencesOfString:@"]" withString:@"/></center>"];
    content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    [showWebView loadHTMLString:content baseURL:nil];
    
    
    
    
    
//    NSString *subString =@"]";
//    NSRange range  = [ string rangeOfString:subString];
//    if (range.length > 0) {
//        
//        NSLog(@"rang:%@",NSStringFromRange(range));
//          NSString  *str = [string substringWithRange:range];//截取范围类的字符串
//        NSLog(@"截取的值为：%@",str);
//        NSString *urLStr =[string substringToIndex:range.location + 1];
//        NSLog(@"截取的imgurl值为：%@ ==== ",urLStr);
//        urLStr = [urLStr stringByReplacingOccurrencesOfString:@"/ueditor/server/upload/../../../../" withString:@"/"];
//        imgUrl = urLStr;
//        
//        contentStr =[string substringFromIndex:range.location];
//        NSLog(@"截取的内容值为：%@ ==== ",contentStr);
//   
//    }else {
//    
//    
//        contentStr = string;
//    
//    }
//    
//    [self createUIAfterRequestDataWithUrl:imgUrl content:contentStr];
    



}


- (void)handleDate {
    
    __weak typeof(self) weakself = self;
//    __weak typeof (showWebView) weakWebView = showWebView;
    returnBlock = ^(id resultValue){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD showSuccessWithStatus:@"加载完成!"];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
            OPLog(@"-FF-%@",[[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"]);
            
            if ([NSNull null] ==[[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"]) {

                [SVProgressHUD showErrorWithStatus:@"没有更多的数据哦"];
   
            }else {
                
                NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                [SVProgressHUD showSuccessWithStatus:@"加载完成"];
               
                [weakself handleContent:listDic];
                
            }
            
        });
        
    };
}




- (void)getWebViewDataWithType:(NSString *)type ChID:(NSInteger)chid{
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {
        
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD showWithStatus:@"增在加载..."];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        
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
                                  "</soap12:Envelope>",[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],type,chid];
        
        
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"GetJsonContentDataResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    
    
}
- (void)btnClicked:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    switch (sender.tag - 100 ) {
        case 0:
        {
            
            if (sender.selected) {
                
                [SVProgressHUD showSuccessWithStatus:@"点赞成功"];
            }else {
                
                
                [SVProgressHUD showSuccessWithStatus:@"取消点赞"];
            }
            
        }
            
            break;
        case 1:
        {
            if (sender.selected) {
                
                [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
            }else {
                
                
                [SVProgressHUD showSuccessWithStatus:@"取消收藏"];
            }
            
            
        }
            
            break;
            
        default:
            break;
    }
}


@end

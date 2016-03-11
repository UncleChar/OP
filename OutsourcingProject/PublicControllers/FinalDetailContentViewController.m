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

    self.title = self.showTitle;
    
    [self configUIWith:self.isBtn];

    [self handleDate];
    
    [self getWebViewDataWithType:self.dataType ChID:[self.chID integerValue]];
    
    // Do any additional setup after loading the view.
}

- (void)configUIWith:(BOOL)isBtn {


    if (isBtn) {
        
        showWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 70 )];
        
        [showWebView sizeToFit];
        showWebView.scalesPageToFit = YES;
        [self.view addSubview:showWebView];
        
        
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight  - 64 - 60, kScreenWidth,60 )];
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
        favBtn.selected = YES;
        favBtn.tag = 101;
        [bottomView addSubview:favBtn];
        
    }else {
    
        showWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 15 )];
        
        [showWebView sizeToFit];
        showWebView.scalesPageToFit = YES;
//        [showWebView sizeToFit];
//        showWebView.scalesPageToFit = YES;
        [self.view addSubview:showWebView];
        
    
    
    
    }
    
    
}

- (void)handleContent:(NSDictionary *)dict {
    
//    senderLabel.text =
    

  
  
    NSString *title;
    NSString *name;
    NSString *date ;
   
    title = [NSString stringWithFormat:@"<div style='font-size: 55px'><center><br>%@</center></div>",[[[dict objectForKey:@"rows"] lastObject] objectForKey:@"ChTopic"]];
    
    if (!_isHasClassify) {//bu需要区分发送和接受
        
        
        
        if ([[[dict objectForKey:@"rows"] lastObject] objectForKey:@"receiverName"]) {
            
            name = [NSString stringWithFormat:@"<br>接收者:    %@",[[[dict objectForKey:@"rows"] lastObject] objectForKey:@"receiverName"]];
            
        }
        
        if ([[[dict objectForKey:@"rows"] lastObject] objectForKey:@"senderName"]) {
            
            name = [NSString stringWithFormat:@"<br>发布者:    %@",[[[dict objectForKey:@"rows"] lastObject] objectForKey:@"senderName"]];
        }
        
        
    }else {
    
    
        if (!_isReceiver) {
            

            if (![[[dict objectForKey:@"rows"] lastObject] objectForKey:@"receiverName"]) {
                
                name = [NSString stringWithFormat:@"<br>接收者:    %@",[[[dict objectForKey:@"rows"] lastObject] objectForKey:@"receivename"]];
            }else {
                
                
                name = [NSString stringWithFormat:@"<br>接收者:    %@",[[[dict objectForKey:@"rows"] lastObject] objectForKey:@"receiverName"]];
                
            }
            
        }else {
            
            
            
//            if (![[[dict objectForKey:@"rows"] lastObject] objectForKey:@"senderName"]) {
//                
//                 name = [NSString stringWithFormat:@"<br>发布者:    %@",[[[dict objectForKey:@"rows"] lastObject] objectForKey:@"receivename"]];
//            }else {
            
            
                name = [NSString stringWithFormat:@"<br>发布者:    %@",[[[dict objectForKey:@"rows"] lastObject] objectForKey:@"senderName"]];
            
//            }
            
            
        }
    
    
    }
    


    
    if ([[[dict objectForKey:@"rows"] lastObject] objectForKey:@"sendDate"]) {
        
        date = [NSString stringWithFormat:@"<br>发送时间:    %@",[[[dict objectForKey:@"rows"] lastObject] objectForKey:@"sendDate"]];
        
    }
    
    if ([[[dict objectForKey:@"rows"] lastObject] objectForKey:@"PublishDate"]) {
        
        date = [NSString stringWithFormat:@"<br>发布时间:    %@",[[[dict objectForKey:@"rows"] lastObject] objectForKey:@"PublishDate"]];
    }
    
    NSString *appendString = [title stringByAppendingString:name];

    appendString = [appendString stringByAppendingString:date];
    
    appendString = [appendString stringByAppendingString:@"<br><br>"];
    

    
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

    appendString = [appendString stringByAppendingString:string];
    
    if ( nil ==self.ChTopicPost) {
        
        self.ChTopicPost = [[[dict objectForKey:@"rows"] lastObject] objectForKey:@"ChTopic"]; 
    }
   
    
    NSString *content = [appendString htmlEntityDecode];
    
    content = [NSString stringWithFormat:@"<div style='font-size: 45px'>  %@</div>",content];
    content = [content stringByReplacingOccurrencesOfString:@"[img_http" withString:@"<center><img style='width:100%;' src = http"];
    
    content = [content stringByReplacingOccurrencesOfString:@"/ueditor/server/upload/../../../../" withString:@"/"];
    content = [content stringByReplacingOccurrencesOfString:@"]" withString:@"/></center>"];
    content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    [showWebView loadHTMLString:content baseURL:nil];
    
    self.chContentPost = [[[dict objectForKey:@"rows"] lastObject] objectForKey:@"chContent"];

//    ChTopic = "\U5de5\U4f1a\U901a\U64cd\U4f5c\U624b\U518c";
//    DataType = "\U57fa\U5c42\U5de5\U4f5c";
//    PraiseCode = 0;
//    PublishDate = "2016-02-01";
//    ShoucangCode = 0;
//    attfile = 20162193724157245774;
//    chContent = "\U8bf7\U4e0b\U8f7d\U67e5\U9605\n";
//    senderIconpic = "";
//    senderName = "\U7ba1\U7406\U5458";
    
    
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

                
                OPLog(@"------%@----------",[listDic objectForKey:@"rows"]);
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
                
                {//点赞的接口
                
                    
                     //    "DataType","DataCode","PhoneIC"
                    self.dataCode = self.chID;
                    self.DataTypepost = self.dataType;
                    self.memberCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"usercode"];
                    self.PhoneIC = [[NSUserDefaults standardUserDefaults] objectForKey:@"shouji"];
                    self.enum_action = Enum_ActionModulePraise;
                    NSDictionary *keyAndValues = @{@"logincookie":[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],@"datatype":@"dianzan"};
                    NSString *xmlString =  [JHXMLParser generateXMLString:keyAndValues hostName:@"Net.GongHuiTong" startElementKey:@"AddAppInfo" xmlInfo:YES resouresInfo:@{@"DataType":self.DataTypepost,@"DataCode":self.dataCode,@"PhoneIC":self.PhoneIC} fileNames:nil fileExtNames:nil fileDesc:nil fileData:nil];
                    OPLog(@"---xml    %@",xmlString);
                    [self submitAddUserWithXmlString:xmlString];
                    
                    
                
                }
                [SVProgressHUD showSuccessWithStatus:@"点赞成功"];
            }else {
                {//取消的接口
                
                    self.enum_action = Enum_ActionModuleCanclePraise;
                
                
                }
                
                [SVProgressHUD showSuccessWithStatus:@"取消点赞"];
            }
            
        }
            
            break;
        case 1:
        {
            if (sender.selected) {
                {//收藏的接口
                    
                   
                   
                    
                    //    "DataType","DataCode","ChTopic","IconPic","ChContent","MemberCode"
                    
                    
                    self.dataCode = self.chID;
                    self.DataTypepost = self.dataType;
                    self.memberCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"usercode"];
                    self.enum_action = Enum_ActionModuleFavor;
                    NSDictionary *keyAndValues = @{@"logincookie":[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],@"datatype":@"shoucang"};
                    NSString *xmlString =  [JHXMLParser generateXMLString:keyAndValues hostName:@"Net.GongHuiTong" startElementKey:@"AddAppInfo" xmlInfo:YES resouresInfo:@{@"DataType":self.DataTypepost,@"DataCode":self.dataCode,@"ChTopic":self.ChTopicPost,@"MemberCode":self.memberCode} fileNames:nil fileExtNames:nil fileDesc:nil fileData:nil];
                    OPLog(@"---xml    %@",xmlString);
                    [self submitAddUserWithXmlString:xmlString];
                   
                
                }
                
            }else {
                {//取消的接口
                
                    self.enum_action = Enum_ActionModuleCancleFavor;
                
                }
                
                [SVProgressHUD showSuccessWithStatus:@"取消收藏"];
            }
            
            
        }
            
            break;
            
        default:
            break;
    }
}
- (void)submitAddUserWithXmlString:(NSString *)xmlString
{
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        
        
        __weak typeof(self) weakSelf = self;
        ReturnValueBlock returnBlockPost = ^(id resultValue){
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSLog(@"AddAppInfoResult::%@",[[resultValue lastObject] objectForKey:@"AddAppInfoResult"]);
                
                if ([[[resultValue lastObject] objectForKey:@"AddAppInfoResult"] isEqualToString:@"操作失败！"]) {
                    
                    [SVProgressHUD showErrorWithStatus:@"操作失败!"];
                    
                    
                }else {
                    
                    NSString *str = [[resultValue lastObject] objectForKey:@"AddAppInfoResult"];
                    
                    switch (self.enum_action) {
                        case Enum_ActionModulePraise:
                            
                            [SVProgressHUD showSuccessWithStatus:str];
                            OPLog(@"点赞ok");
                            
                            break;
                        case Enum_ActionModuleCanclePraise:
                            [SVProgressHUD showSuccessWithStatus:str];
                            OPLog(@"取消点赞ok");
                            break;
                        case Enum_ActionModuleFavor:
                            [SVProgressHUD showSuccessWithStatus:str];
                            OPLog(@"收藏ok");
                            break;
                        case Enum_ActionModuleCancleFavor:
                            OPLog(@"取消收藏ok");
                            [SVProgressHUD showSuccessWithStatus:str];
                            break;
                            
                        default:
                            break;
                    }
                    
                    

                    
//                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
                
                
            });
            
            
        };
        
        
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:xmlString parseParameters:@[@"AddAppInfoResult"] WithReturnValeuBlock:returnBlockPost WithErrorCodeBlock:nil];
        
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
    }
    
    
}


@end

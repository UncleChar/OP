//
//  ActivityDetailViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/3/1.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "ActivityDetailViewController.h"
@interface ActivityDetailViewController ()
{

    ReturnValueBlock returnBlock;
    UILabel *titleLabel;
   
    UILabel *dateLabel;
    UILabel *contentLabel;
    UIView *backView;
    UIButton *deleteBtn;
}
@property (nonatomic, strong) UIScrollView *backgroungScrollView;
@property (nonatomic, strong)UILabel *senderLabel;
@end

@implementation ActivityDetailViewController



- (void)viewDidLoad {
    
               [super viewDidLoad];
                self.title = @"通知详情";
    
        
        _backgroungScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _backgroungScrollView.backgroundColor = kBackColor;
        _backgroungScrollView.userInteractionEnabled = YES;
        [self.view addSubview:_backgroungScrollView];
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, kScreenWidth, 50)];
        titleLabel.text =[NSString stringWithFormat:@"%@",self.ChTopic];
        titleLabel.textAlignment = 1;
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        titleLabel.backgroundColor = [UIColor whiteColor];
        [self.backgroungScrollView addSubview:titleLabel];
        
        UIView  *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 51, kScreenWidth, 2)];
        lineView.backgroundColor = [UIColor orangeColor];
        [titleLabel addSubview:lineView];
        
        _senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 53, kScreenWidth, 40)];
        _senderLabel.text =   [NSString stringWithFormat:@"  通知接收者:    %@",self.senderName];
        //    titleLabel.textAlignment = 1;
        _senderLabel.font = OPFont(16);
        _senderLabel.backgroundColor = [UIColor whiteColor];
        [self.backgroungScrollView addSubview:_senderLabel];
        
        dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 94, kScreenWidth, 40)];
        dateLabel.text = [NSString stringWithFormat:@"  发送时间:       %@",self.sendDate];
        //    titleLabel1.textAlignment = 1;
        dateLabel.font = OPFont(16);
        dateLabel.backgroundColor = [UIColor whiteColor];
        [self.backgroungScrollView addSubview:dateLabel];
        
        // 计算model.desc文字的高度
        CGFloat descLabelHeight = [ConfigUITools calculateTextHeight:self.chContent size:CGSizeMake(kScreenWidth, MAXFLOAT) font:OPFont(16)];
        
        CGFloat height;
        if (descLabelHeight <40.0) {
            
            height = 40;
            
        }else {
            
            height = descLabelHeight;
            
        }
        
        contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 135, kScreenWidth , height)];
    
        contentLabel.text =[NSString stringWithFormat:@"  %@",self.chContent] ;
        contentLabel.backgroundColor = [UIColor whiteColor];
        contentLabel.font = OPFont(16);
        [self.backgroungScrollView addSubview:contentLabel];
        
        backView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(contentLabel.frame)+ 1, kScreenWidth, 60)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.backgroungScrollView addSubview:backView];
        
        deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 25, 5, 50, 50)];
        deleteBtn.backgroundColor = [ConfigUITools colorWithR:245.0 G:88.0 B:142.0 A:1];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        deleteBtn.layer.cornerRadius = 25;
        deleteBtn.layer.masksToBounds = 1;
        deleteBtn.titleLabel.font = OPFont(14);
        [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:deleteBtn];
        [ConfigUITools sizeToScroll:_backgroungScrollView withStandardElementMaxY:CGRectGetMaxY(backView.frame) + 25 forStepsH:0];

        
    
    if (self.blockTag == 1) {
    
        
        [self handleRequsetDetaiDate];
        [self readAppDataWithType:@"fachudegongzuodongtai" chid:[self.ChID integerValue]];
        _senderLabel.text =[NSString stringWithFormat:@"  通知接收者:    %@",@""];;
    }


    
    

}



- (void)deleteBtnClicked {

    

    [self handleRequsetAddDate];
    [self deleteAppDataWithType:@"gongzuodongtai" chid:[self.ChID integerValue]];
    
  
    

}
- (void)handleRequsetDetaiDate {
    
    
    __weak typeof (self) weakSelf = self;
    returnBlock = ^(id resultValue){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            OPLog(@"-FF-%@",[[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"]);
            
            
            
            
            if ([NSNull null] ==[[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"]) {
                
                
                
            }else {

                SBJSON *jsonParser = [[SBJSON alloc] init];
                NSError *parseError = nil;
                NSDictionary * result = [jsonParser objectWithString:[[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"]
                                                               error:&parseError];
                NSLog(@"jsonParserresult:%@",[result objectForKey:@"rows"]);
                
                OPLog(@"----far--%@----------",[[result objectForKey:@"rows"][0] class ]);
                NSString *replace = [[result objectForKey:@"rows"][0] objectForKey:@"receiveNames"];
                replace = [replace stringByReplacingOccurrencesOfString:@"," withString:@" "];
                weakSelf.senderLabel.text = [NSString stringWithFormat:@"  通知接收者:    %@",replace];;
                

            }
            
        });

        
        
    };
    
}

- (void)handleRequsetAddDate {
    

    __weak typeof (self) weakSelf = self;
    returnBlock = ^(id resultValue){
        dispatch_async(dispatch_get_main_queue(), ^{

            
            OPLog(@"-FF-%@",[[resultValue lastObject] objectForKey:@"DeleteAppInfoResult"]);

            
            if ([[[resultValue lastObject] objectForKey:@"DeleteAppInfoResult"] isEqualToString:@"操作成功！"]) {
                
//                dispatch_async(dispatch_get_main_queue(), ^{
                   [SVProgressHUD showSuccessWithStatus:@"删除成功!"];
                
                    weakSelf.deleteBlock( weakSelf.blockTag);
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                
//                });
                
            }else {
            
            
            
            }
            
        });
        
        
    };
    
}
- (void)readAppDataWithType:(NSString *)type chid:(NSInteger)cid {
    
    
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


- (void)deleteAppDataWithType:(NSString *)type chid:(NSInteger)cid {
    
    
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
                                  "<DeleteAppInfo xmlns=\"Net.GongHuiTong\">"
                                  "<logincookie>%@</logincookie>"
                                  "<datatype>%@</datatype>"
                                  "<id>%ld</id>"
                                  " </DeleteAppInfo>"
                                  "</soap12:Body>"
                                  "</soap12:Envelope>",[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],type,(long)cid];
        
        
        
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"DeleteAppInfoResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];
        
        
    }else {

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    
    
}



@end

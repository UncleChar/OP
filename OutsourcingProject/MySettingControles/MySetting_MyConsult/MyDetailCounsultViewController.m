//
//  MyDetailCounsultViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/3/14.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "MyDetailCounsultViewController.h"

@interface MyDetailCounsultViewController ()
{
    
    ReturnValueBlock returnBlock;
    UILabel *dateLabel;
    UILabel *senderLabel1;
    UITextView *contentView;
    
}
@property (nonatomic, strong) UIScrollView *backgroungScrollView;
@end

@implementation MyDetailCounsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.showTitle;
    
    _backgroungScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _backgroungScrollView.backgroundColor = kBackColor;
    _backgroungScrollView.userInteractionEnabled = YES;
    [self.view addSubview:_backgroungScrollView];
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:_backgroungScrollView];

    
    UITextView *titleLabel = [[UITextView alloc]init];
    titleLabel.text =self.ChTopic;
    titleLabel.textAlignment = 1;
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    [_backgroungScrollView addSubview:titleLabel];
    
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
    
    senderLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, height + 3, kScreenWidth, 40)];
    if (self.isRep) {
       senderLabel1.text =   [NSString stringWithFormat:@"  接收者:    %@",@""];
        
    }else {
    
        senderLabel1.text =   [NSString stringWithFormat:@"  发布者:    %@",@""];
    }
    
    //    titleLabel.textAlignment = 1;
    senderLabel1.backgroundColor = [UIColor whiteColor];
    [_backgroungScrollView addSubview:senderLabel1];
    
    dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, height+ 44, kScreenWidth, 40)];
    dateLabel.text = [NSString stringWithFormat:@"  发布时间:       %@",self.sendDate];
    //    titleLabel1.textAlignment = 1;
    dateLabel.backgroundColor = [UIColor whiteColor];
    [_backgroungScrollView addSubview:dateLabel];
    
    [self handleRequsetDetaiDate];
    
    [self NotiDetailWithType:self.dataType chid:[self.chID integerValue]];
    
}


- (void)configAfterData:(NSDictionary *)dict {
    
    NSString *conten = [dict objectForKey:@"chContent"];
    
    if (self.isRep) {
        
        
         senderLabel1.text =   [NSString stringWithFormat:@"  接收者:    %@",[dict objectForKey:@"receivename"]];
        UITextView *showView = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(dateLabel.frame) + 1, kScreenWidth, (kScreenHeight- CGRectGetMaxY(dateLabel.frame) - 1 - 64 ) / 2)];
        
        //    [showWebView sizeToFit];
        //    showWebView.scalesPageToFit = YES;
        //        [showWebView sizeToFit];
        //        showWebView.scalesPageToFit = YES;
        showView.text = conten;
        showView.font = OPFont(16);
        [showView setEditable:NO];
        [_backgroungScrollView addSubview:showView];
        
        
        UILabel *senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(showView.frame) + 5, kScreenWidth, 40)];
        senderLabel.text =   [NSString stringWithFormat:@"  目前状态:    %@",[dict objectForKey:@"acceptStatus"]];
        //    titleLabel.textAlignment = 1;
        senderLabel.backgroundColor = [UIColor whiteColor];
        [_backgroungScrollView addSubview:senderLabel];
        
        UILabel *ccLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(senderLabel.frame) + 1, kScreenWidth, 40)];
        ccLabel.text = @"  回复内容:";
        //    titleLabel.textAlignment = 1;
        ccLabel.backgroundColor = [UIColor whiteColor];
        [_backgroungScrollView addSubview:ccLabel];
        
        UITextView *titleLabel = [[UITextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(ccLabel.frame) + 1, kScreenWidth, kScreenHeight - 65 - CGRectGetMaxY(ccLabel.frame))];
        titleLabel.text =[dict objectForKey:@"replycontent"];
        titleLabel.textAlignment = 1;
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:17];
        [_backgroungScrollView addSubview:titleLabel];
        
        
    }else {
    
        senderLabel1.text =   [NSString stringWithFormat:@"  发布者:    %@",[dict objectForKey:@"senderName"]];
        UITextView *showView = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(dateLabel.frame) + 1, kScreenWidth, kScreenHeight- CGRectGetMaxY(dateLabel.frame) - 1 - 64   - 150 - 50)];
        
        //    [showWebView sizeToFit];
        //    showWebView.scalesPageToFit = YES;
        //        [showWebView sizeToFit];
        //        showWebView.scalesPageToFit = YES;
        showView.text = conten;
        showView.font = OPFont(16);
        [showView setEditable:NO];
        [_backgroungScrollView addSubview:showView];
        
        UIView *textBackView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(showView.frame) + 2, kScreenWidth - 20, 150)];
        textBackView.backgroundColor = [UIColor blackColor];
        textBackView.layer.cornerRadius = 4;
        textBackView.layer.masksToBounds = 1;
         [_backgroungScrollView addSubview:textBackView];
        [_backgroungScrollView addSubview:textBackView];
        contentView = [[UITextView alloc] initWithFrame:CGRectMake(1, 1, kScreenWidth - 22,148)];
    
        contentView.font = OPFont(16);
        [textBackView addSubview:contentView];
        
        UIButton  *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.backgroundColor = kTestColor;
        submitBtn.tag = 888 + 1;
        //    [submitBtn setBackgroundImage:[UIImage imageNamed:@"矩形-9"] forState:UIControlStateNormal];
        submitBtn.backgroundColor = kBtnColor;
        [submitBtn setTitle:@"回复" forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(allBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        submitBtn.layer.cornerRadius = 4;
        submitBtn.layer.masksToBounds = 1;
        submitBtn.frame = CGRectMake(20, CGRectGetMaxY(textBackView.frame) + 5, kScreenWidth - 40, 40);
        [_backgroungScrollView addSubview:submitBtn];
        
        
    
    }

    
    
    
    
}

- (void)allBtnClicked {
    
    if ([AppDelegate isNetworkConecting]) {
        
        
        NSDictionary *keyAndValues = @{@"logincookie":[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],@"datatype":@"neibuzixun",@"id":self.chID};
        
        if ([AlertTipsViewTool isEmptyWillSubmit:@[contentView]]) {
            
        }else {

            NSString *xmlString =  [JHXMLParser generateXMLString:keyAndValues
                                                         hostName:@"Net.GongHuiTong"
                                                  startElementKey:@"EditAppInfo" xmlInfo:YES
                                                     resouresInfo:@{
                                                                    @"ReplyContent":contentView.text,
                                                                    }fileNames:nil fileExtNames:nil fileDesc:nil fileData:nil];
            
            [self submitAddUserWithXmlString:xmlString];
            
        }
        
        
    }else {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无网络连接,请检查网络!" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            
        }];
        
        [alertController addAction:okAction];
        
        [self.navigationController  presentViewController:alertController animated:YES completion:nil];
        
    }
    
    
}

- (void)submitAddUserWithXmlString:(NSString *)xmlString
{
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showInfoWithStatus:@"增在提交..."];
    
    __weak typeof(self) weakSelf = self;
    ReturnValueBlock returnBlockPost = ^(id resultValue){
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"AddAppInfoResult::%@",[[resultValue lastObject] objectForKey:@"EditAppInfoResult"]);
            
            if ([[[resultValue lastObject] objectForKey:@"EditAppInfoResult"] isEqualToString:@"操作失败！"]) {
                
                [SVProgressHUD showErrorWithStatus:@"提交失败!"];
                
                
            }else {
                
                //                weakSelf.submitBtnBlock( YES);
                [SVProgressHUD showSuccessWithStatus:@"提交成功！"];
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
            }
            
            
            
        });
        
        
        
        
        
    };
    
    
    [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:xmlString parseParameters:@[@"EditAppInfoResult"] WithReturnValeuBlock:returnBlockPost WithErrorCodeBlock:nil];
    
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [_backgroungScrollView endEditing:YES];
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
- (void)viewWillDisappear:(BOOL)animated {
    
    [DaiDodgeKeyboard removeRegisterTheViewNeedDodgeKeyboard];
}

@end

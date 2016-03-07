//
//  NotiDetialViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/3/1.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "NotiDetialViewController.h"

#define kRealityH  [UIScreen mainScreen].bounds.size.height - 64
#define kTitleH    ([UIScreen mainScreen].bounds.size.height - 64) / 3 * (0.4)
#define kLabelH    ([UIScreen mainScreen].bounds.size.height - 64) / 3 * 0.6  / 3
#define kContentH  ([UIScreen mainScreen].bounds.size.height - 64) / 3 * 2 / 3
#define kAnswerH   ([UIScreen mainScreen].bounds.size.height - 64) / 3 * 2 / 3
#define kSubmitH   ([UIScreen mainScreen].bounds.size.height - 64) / 3 * 2 / 3

@interface NotiDetialViewController ()
{
    
    ReturnValueBlock returnBlock;
    UITextView *titleView;
    UILabel *dateLabel;
    UILabel *publicDateLabel;
    UITextView *contentView;
    
    UIView *contentBackView;
    UIView *backView;
    UIButton *quickSelectedBtn;
    UIView *textBackView;
    
    UIButton *okBtn;
    UIButton *quckBtn;
}
@property (nonatomic, strong) UIScrollView *backgroungScrollView;
@property (nonatomic, strong)UILabel *senderLabel;


@property (nonatomic, strong) UITextView   *taskContentTView;

@property (nonatomic, strong) NSArray      *elementArray;
@property (nonatomic, strong) UIView       *coverView;
@property (nonatomic, strong) UIView       *topView;
@property (nonatomic, assign) NSInteger     moduleTag;
@end

@implementation NotiDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_modelTag == 0) {
       
          self.title = @"通知详情";
        
    }else {
    
          self.title = @"任务详情";
        
    }
  
    self.view.backgroundColor = [UIColor whiteColor];

    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:self.view];

   
        
        titleView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTitleH)];
        titleView.textAlignment = 1;
        titleView.font = [UIFont boldSystemFontOfSize:17];
        titleView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:titleView];

        _senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), kScreenWidth, kLabelH)];
        _senderLabel.text =   [NSString stringWithFormat:@"  通知发送者:    %@",@""];
        //    titleLabel.textAlignment = 1;
        _senderLabel.font = OPFont(16);
        _senderLabel.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_senderLabel];
        
        UIView  *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        lineView.backgroundColor = [UIColor orangeColor];
        [_senderLabel addSubview:lineView];
        

        
        dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_senderLabel.frame), kScreenWidth, kLabelH)];
        dateLabel.text = [NSString stringWithFormat:@"  发送时间:         %@",@""];
        //    titleLabel1.textAlignment = 1;
        dateLabel.font = OPFont(16);
        dateLabel.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:dateLabel];

        
        publicDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(dateLabel.frame), kScreenWidth, kLabelH)];
        
        if (_modelTag == 0) {
            
             publicDateLabel.text = [NSString stringWithFormat:@"  回执时间:         %@",@""];
        }
        if (_modelTag == 1) {
            
             publicDateLabel.text = [NSString stringWithFormat:@"  完成期限:         %@",@""];
        }
        publicDateLabel.font = OPFont(16);
        publicDateLabel.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:publicDateLabel];

        
        contentBackView = [[UIView alloc]initWithFrame:CGRectMake(1, CGRectGetMaxY(publicDateLabel.frame), kScreenWidth - 2, kContentH)];
        contentBackView.backgroundColor = [UIColor grayColor];
        contentBackView.layer.cornerRadius = 4;
        contentBackView.layer.masksToBounds = 1;
        [self.view addSubview:contentBackView];

        
        
        
        contentView = [[UITextView alloc]initWithFrame:CGRectMake(1, 1, kScreenWidth - 2, kContentH - 2)];
        contentView.text =[NSString stringWithFormat:@"  %@",@""] ;
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.font = OPFont(15);
        [contentView setEditable:NO];
        [contentBackView addSubview:contentView];


        quickSelectedBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/3 * 2 - 5, CGRectGetMaxY(contentBackView.frame) + 3, kScreenWidth / 3, kAnswerH / 4)];
        [quickSelectedBtn setBackgroundImage:[UIImage imageNamed:@"形状副本-拷贝"] forState:UIControlStateNormal];
        quickSelectedBtn.layer.cornerRadius = 4;
        quickSelectedBtn.layer.masksToBounds = 1;
        [quickSelectedBtn setTitle:@"快速回复" forState:UIControlStateNormal];
        quickSelectedBtn.titleLabel.font = OPFont(16);
        quickSelectedBtn.tag = 200;
        [quickSelectedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [quickSelectedBtn addTarget:self action:@selector(shouBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:quickSelectedBtn];
        
        textBackView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(quickSelectedBtn.frame)+3, kScreenWidth - 20, kAnswerH * 0.75 - 6)];
        textBackView.backgroundColor = [UIColor grayColor];
        textBackView.layer.cornerRadius = 4;
        textBackView.layer.masksToBounds = 1;
        [self.view addSubview:textBackView];
        
        _taskContentTView = [[UITextView alloc]init];
        //    _contentTView.backgroundColor = kTestColor;
        _taskContentTView.frame = CGRectMake(1, 1, kScreenWidth - 22, CGRectGetHeight(textBackView.frame) - 2);
        _taskContentTView.font = [UIFont systemFontOfSize:14];
        _taskContentTView.layer.cornerRadius = 4;
        _taskContentTView.layer.masksToBounds = 1;
        [textBackView addSubview:_taskContentTView];

    
    if (_modelTag == 0) {
    
        
        okBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(textBackView.frame) + kSubmitH / 2 - kSubmitH / 10 * 3.5 / 2, kScreenWidth - 40, kSubmitH / 10 * 3.5)];
        okBtn.backgroundColor = kBtnColor;
        [okBtn setTitle:@"回复" forState:UIControlStateNormal];
        //    deleteBtn.layer.cornerRadius = 25;
        //    deleteBtn.layer.masksToBounds = 1;
        okBtn.titleLabel.font = OPFont(16);
        okBtn.tag = 201;
        [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        okBtn.layer.cornerRadius = 4;
        okBtn.layer.masksToBounds = 1;
        [okBtn addTarget:self action:@selector(shouBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:okBtn];
        
    }
    if (_modelTag == 1) {
    
        okBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(textBackView.frame) + kSubmitH / 10, kScreenWidth - 40, kSubmitH / 10 * 3.5)];
        okBtn.backgroundColor = kBtnColor;
        [okBtn setTitle:@"回复" forState:UIControlStateNormal];
        //    deleteBtn.layer.cornerRadius = 25;
        //    deleteBtn.layer.masksToBounds = 1;
        okBtn.titleLabel.font = OPFont(16);
        okBtn.tag = 202;
        [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        okBtn.layer.cornerRadius = 4;
        okBtn.layer.masksToBounds = 1;
        [okBtn addTarget:self action:@selector(shouBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:okBtn];
        
        quckBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(okBtn.frame) + kSubmitH / 10, kScreenWidth - 40, kSubmitH / 10 * 3.5)];
        quckBtn.backgroundColor = kBtnColor;
        [quckBtn setTitle:@"回复并完成" forState:UIControlStateNormal];
        quckBtn.titleLabel.font = OPFont(16);
        quckBtn.tag = 203;
        [quckBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        quckBtn.layer.cornerRadius = 4;
        quckBtn.layer.masksToBounds = 1;
        [quckBtn addTarget:self action:@selector(shouBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:quckBtn];

    
    
    }

        [self handleRequsetDetaiDate];
    
    if (_modelTag == 0) {
        
         [self NotiDetailWithType:@"qitatongzhi" chid:[self.ChID integerValue]];
    }
    if (_modelTag == 1) {
        
         [self NotiDetailWithType:@"shoudaodegongzuorenwu" chid:[self.ChID integerValue]];
    }
    
    
    
    
   
}
- (void)configAfterData:(NSDictionary *)dict {


        
        titleView.text = [dict objectForKey:@"ChTopic"];
        _senderLabel.text = [NSString stringWithFormat:@"  通知发送者:    %@",[dict objectForKey:@"senderName"]];
        dateLabel.text = [NSString stringWithFormat:@"  发送时间:    %@",[dict objectForKey:@"sendDate"]];
        
        if (_modelTag == 0) {
            
            publicDateLabel.text = [NSString stringWithFormat:@"  回执时间:       %@",[dict objectForKey:@"receiptDate"]];
        }
        if (_modelTag == 1) {
            
            publicDateLabel.text = [NSString stringWithFormat:@"  完成期限:       %@",[dict objectForKey:@"ExpDate"]];
        }
        
        NSString *str = [[dict objectForKey:@"chContent"] stringByReplacingOccurrencesOfString:@"\n" withString:@" "];

        contentView.text = [dict objectForKey:@"chContent"];
        
        UIView  *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        lineView1.backgroundColor = [ConfigUITools colorWithR:77 G:184 B:73 A:1];
        [backView addSubview:lineView1];

}


- (void)shouBtnClicked:(UIButton *)sender {

    switch (sender.tag - 200) {
        case 0:
        {
        
            if (_modelTag == 0) {
                
                NSArray *contentArr = @[@"  你好,已收到通知,我们将准时参加!",@"  你好,已收到通知,我们确定安排后,会及时回复!",@"  你好,已收到通知,因故无法参加,请知悉!"];
                [self showSelectedWithTitle:@"请选择回复内容" subTitles:contentArr];
            }else {
            
                NSArray *contentArr = @[@"  收到",@"  我知道了",@"  好的"];
                [self showSelectedWithTitle:@"请选择回复内容" subTitles:contentArr];
            }
//            NSArray *contentArr = @[@"  你好,已收到通知,我们将准时参加!",@"  你好,已收到通知,我们确定安排后,会及时回复!",@"  你好,已收到通知,因故无法参加,请知悉!"];
//            [self showSelectedWithTitle:@"请选择回复内容" subTitles:contentArr];
        }
            
            break;
        case 1://通知的回复
        {

//            [SVProgressHUD showSuccessWithStatus:@"回复哦"];

            
            if ([AppDelegate isNetworkConecting]) {
               
                    
                    NSDictionary *keyAndValues = @{@"logincookie":[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],@"datatype":@"tongzhigonggao",@"id":@([self.ChID integerValue])};
                
                   self.moduleTag = 100;
                    NSDateFormatter *df = [[NSDateFormatter alloc]init];
                    //设置转换格式
                    df.dateFormat = @"yyyy-MM-dd HH:mm";
                    NSString *str = [df stringFromDate:[NSDate date]];

                    NSString *xmlString =  [JHXMLParser generateXMLString:keyAndValues hostName:@"Net.GongHuiTong" startElementKey:@"EditAppInfo" xmlInfo:YES resouresInfo:@{@"fld_35_6":@(1),@"fld_35_7":str,@"fld_35_8":_taskContentTView.text} fileNames:nil fileExtNames:nil fileDesc:nil fileData:nil];
                    OPLog(@"---xml    %@",xmlString);
                    [self submitAddUserWithXmlString:xmlString];
            
            }else {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无网络连接,请检查网络!" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    
                    
                }];
                
                [alertController addAction:okAction];
                
                [self.navigationController  presentViewController:alertController animated:YES completion:nil];
                
            }

            
            
        
        }
            
            
            break;
        case 2://任务的回复
        {

          
            if ([AppDelegate isNetworkConecting]) {
                
                self.moduleTag = 101;
                NSDictionary *keyAndValues = @{@"logincookie":[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],@"datatype":@"gongzuorenwu",@"id":@([self.ChID integerValue])};
                
                NSDateFormatter *df = [[NSDateFormatter alloc]init];
                //设置转换格式
                df.dateFormat = @"yyyy-MM-dd HH:mm";
                NSString *str = [df stringFromDate:[NSDate date]];
                
                NSString *xmlString =  [JHXMLParser generateXMLString:keyAndValues hostName:@"Net.GongHuiTong" startElementKey:@"EditAppInfo" xmlInfo:YES resouresInfo:@{@"fld_29_6":str,@"fld_29_10":@"0",@"fld_29_14":_taskContentTView.text} fileNames:nil fileExtNames:nil fileDesc:nil fileData:nil];
                OPLog(@"---xml    %@",xmlString);
                [self submitAddUserWithXmlString:xmlString];
                
            }else {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无网络连接,请检查网络!" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    
                    
                }];
                
                [alertController addAction:okAction];
                
                [self.navigationController  presentViewController:alertController animated:YES completion:nil];
                
            }

            
            
            
        }
            
            
            break;
            
        case 3://任务的恢复并完成
        {
            
            if ([AppDelegate isNetworkConecting]) {
                self.moduleTag = 102;
//                self.enum_type = ENUM_DetailTypeShouldRefresh;
                NSDictionary *keyAndValues = @{@"logincookie":[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],@"datatype":@"gongzuorenwu",@"id":@([self.ChID integerValue])};
                
                NSDateFormatter *df = [[NSDateFormatter alloc]init];
                //设置转换格式
                df.dateFormat = @"yyyy-MM-dd HH:mm";
                NSString *str = [df stringFromDate:[NSDate date]];
                
                NSString *xmlString =  [JHXMLParser generateXMLString:keyAndValues hostName:@"Net.GongHuiTong" startElementKey:@"EditAppInfo" xmlInfo:YES resouresInfo:@{@"fld_29_6":str,@"fld_29_10":@"1",@"fld_29_14":_taskContentTView.text} fileNames:nil fileExtNames:nil fileDesc:nil fileData:nil];
                OPLog(@"---xml    %@",xmlString);
                [self submitAddUserWithXmlString:xmlString];
                
            }else {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无网络连接,请检查网络!" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    
                    
                }];
                
                [alertController addAction:okAction];
                
                [self.navigationController  presentViewController:alertController animated:YES completion:nil];
                
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
                
                NSLog(@"EditAppInfoResult::%@",[[resultValue lastObject] objectForKey:@"EditAppInfoResult"]);
                
                if ([[[resultValue lastObject] objectForKey:@"EditAppInfoResult"] isEqualToString:@"操作失败！"]) {
                    
                    [SVProgressHUD showErrorWithStatus:@"操作失败!"];
                    
                    
                }else {
                    
                    
                    [SVProgressHUD showSuccessWithStatus:@"回执成功!"];
                    switch (weakSelf.moduleTag - 100) {
                        case 0:
                            
                            
                            
                            break;
                            
                        case 1:
                            
                            
                            break;
                            
                        case 2:
                            weakSelf.refreshBlock( YES);
                            
                            break;
                            
                        default:
                            break;
                    }
                    
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
                
                
            });
            
            
        };
        
        
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:xmlString parseParameters:@[@"EditAppInfoResult"] WithReturnValeuBlock:returnBlockPost WithErrorCodeBlock:nil];
        
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
    }
    
    
}

- (void)showSelectedWithTitle:(NSString *)title subTitles:(NSArray *)array {
    
    
    _coverView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0.7;
    
    // 添加单击手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePopupView:)];
    _coverView.userInteractionEnabled = YES;
    [_coverView addGestureRecognizer:gesture];
    [[UIApplication sharedApplication].keyWindow addSubview:_coverView];
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(10, ([UIScreen mainScreen].bounds.size.height - (array.count * 45 + array.count + 1)) / 2 - 32, kScreenWidth - 20, array.count * 45 + array.count + 1 + 61)];
    _topView.backgroundColor = [UIColor whiteColor];
    _topView.layer.cornerRadius = 4;
    _topView.layer.masksToBounds = 1;
    
    [[UIApplication sharedApplication].keyWindow addSubview:_topView];
    
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_topView.frame), 60)];
    infoLabel.font = [UIFont systemFontOfSize:20];
    infoLabel.textAlignment = 1;
    infoLabel.textColor = [ConfigUITools colorWithR:90 G:173 B:243 A:1];
    infoLabel.text = title;
    [_topView addSubview:infoLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth - 20, 1)];
    line.backgroundColor = [ConfigUITools colorWithR:90 G:173 B:243 A:1];
    
    [_topView addSubview:line];
    
    
    for (int i = 0 ; i < array.count; i ++) {
        
        UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        typeBtn.tag = i;
        [typeBtn setTitle:array[i] forState:UIControlStateNormal];
        [typeBtn addTarget:self action:@selector(typeTipBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        typeBtn.frame = CGRectMake(0, 61 + i * 47, kScreenWidth - 20, 45);
        typeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        typeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

        [_topView addSubview:typeBtn];
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(typeBtn.frame), kScreenWidth  - 20, 1)];
        line1.backgroundColor = [UIColor lightGrayColor];
        
        [_topView addSubview:line1];
        
        
    }
    
    
    
}

- (void)hidePopupView:(UITapGestureRecognizer*)gesture {
    
    [_coverView removeFromSuperview];
    [_topView removeFromSuperview];
}

- (void)typeTipBtnClicked:(UIButton *)sender {
    
    [_coverView removeFromSuperview];
    [_topView removeFromSuperview];
    NSString *btnTitle = @"";
    switch (sender.tag) {
        case 0:
            
            btnTitle = sender.titleLabel.text;
            
            break;
        case 1:
            
            btnTitle = sender.titleLabel.text;
            
            break;
        case 2:
            
            btnTitle = sender.titleLabel.text;
            
            break;
            
        default:
            break;
    }

    _taskContentTView.text = [btnTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    
    
    
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
                NSString *str  =   [[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"] ;
//                NSLog(@"ssss %@",str);
                str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                NSDictionary * result = [jsonParser objectWithString:str
                                                               error:&parseError];
                NSLog(@"jsonParserresult:%@",[result objectForKey:@"rows"]);
                NSDictionary *detailDict = [result objectForKey:@"rows"][0];
                
                
                [weakSelf configAfterData:detailDict];
                
                
                
//                OPLog(@"----far--%@----------",[[result objectForKey:@"rows"][0] class ]);
//                NSString *replace = [[result objectForKey:@"rows"][0] objectForKey:@"receiveNames"];
//                replace = [replace stringByReplacingOccurrencesOfString:@"," withString:@" "];
//                weakSelf.senderLabel.text = [NSString stringWithFormat:@"  通知接收者:    %@",replace];;
//                
                
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];

}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:YES];
    [DaiDodgeKeyboard removeRegisterTheViewNeedDodgeKeyboard];


}


@end

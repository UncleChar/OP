//
//  NotiDetialViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/3/1.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "NotiDetialViewController.h"

@interface NotiDetialViewController ()
{
    
    ReturnValueBlock returnBlock;
    UILabel *titleLabel;
    
    UILabel *dateLabel;
    UILabel *repeatLabel;
    UILabel *contentLabel;
    UIView *backView;
    UIButton *deleteBtn;
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
@end

@implementation NotiDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知详情";
    
    
    _backgroungScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _backgroungScrollView.backgroundColor = [UIColor whiteColor];
    _backgroungScrollView.userInteractionEnabled = YES;
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:_backgroungScrollView];
    [self.view addSubview:_backgroungScrollView];
    

    
    
    if (self.headTag == 0) {
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, kScreenWidth, 50)];
        titleLabel.text =[NSString stringWithFormat:@"%@",@""];
        titleLabel.textAlignment = 1;
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        titleLabel.backgroundColor = [UIColor whiteColor];
        [self.backgroungScrollView addSubview:titleLabel];
        
        UIView  *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 51, kScreenWidth, 2)];
        lineView.backgroundColor = [UIColor orangeColor];
        [titleLabel addSubview:lineView];
        
        _senderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 53, kScreenWidth, 40)];
        _senderLabel.text =   [NSString stringWithFormat:@"  通知发送者:    %@",@""];
        //    titleLabel.textAlignment = 1;
        _senderLabel.font = OPFont(16);
        _senderLabel.backgroundColor = [UIColor whiteColor];
        [self.backgroungScrollView addSubview:_senderLabel];
        
        dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 94, kScreenWidth, 40)];
        dateLabel.text = [NSString stringWithFormat:@"  发送时间:       %@",@""];
        //    titleLabel1.textAlignment = 1;
        dateLabel.font = OPFont(16);
        dateLabel.backgroundColor = [UIColor whiteColor];
        [self.backgroungScrollView addSubview:dateLabel];
        
        
        repeatLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 135, kScreenWidth, 40)];
        repeatLabel.text = [NSString stringWithFormat:@"  回执时间:       %@",@""];

        repeatLabel.font = OPFont(16);
        repeatLabel.backgroundColor = [UIColor whiteColor];
        [self.backgroungScrollView addSubview:repeatLabel];
        
        
        
        contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 176, kScreenWidth , 40)];
        
        contentLabel.text =[NSString stringWithFormat:@"  %@",@""] ;
        contentLabel.backgroundColor = [UIColor whiteColor];
        contentLabel.font = OPFont(16);
        [self.backgroungScrollView addSubview:contentLabel];
        
        backView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(contentLabel.frame)+ 1, kScreenWidth, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.backgroungScrollView addSubview:backView];
        
        
        
        
        
        deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/3 * 2 - 5, 5, kScreenWidth / 3, 40)];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"形状副本-拷贝"] forState:UIControlStateNormal];
        deleteBtn.layer.cornerRadius = 4;
        deleteBtn.layer.masksToBounds = 1;
        [deleteBtn setTitle:@"快速回复" forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = OPFont(16);
        deleteBtn.tag = 200;
        [deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(shouBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:deleteBtn];
        
        textBackView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(backView.frame)+1, kScreenWidth - 20, 100)];
        textBackView.backgroundColor = [UIColor grayColor];
        textBackView.layer.cornerRadius = 4;
        textBackView.layer.masksToBounds = 1;
        [_backgroungScrollView addSubview:textBackView];
        
        _taskContentTView = [[UITextView alloc]init];
        //    _contentTView.backgroundColor = kTestColor;
        _taskContentTView.frame = CGRectMake(1, 1, kScreenWidth - 22, CGRectGetHeight(textBackView.frame) - 2);
        _taskContentTView.font = [UIFont systemFontOfSize:14];
        _taskContentTView.layer.cornerRadius = 4;
        _taskContentTView.layer.masksToBounds = 1;
        [textBackView addSubview:_taskContentTView];
        
        
        if (self.headTag == 0) {
            
            
        }
        
        if (self.headTag == 1) {
            
            
        }
        
        
        okBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(textBackView.frame) + 5, kScreenWidth - 40, 40)];
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
        [_backgroungScrollView addSubview:okBtn];
        
        
        [ConfigUITools sizeToScroll:_backgroungScrollView withStandardElementMaxY:CGRectGetMaxY(okBtn.frame) + 25 forStepsH:0];
        
        
        [self handleRequsetDetaiDate];
        [self NotiDetailWithType:@"qitatongzhi" chid:[self.ChID integerValue]];
        
    }
    
    if (self.headTag == 1) {
        
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
        _senderLabel.text =   [NSString stringWithFormat:@"  通知发送者:    %@",@"---"];
        //    titleLabel.textAlignment = 1;
        _senderLabel.font = OPFont(16);
        _senderLabel.backgroundColor = [UIColor whiteColor];
        [self.backgroungScrollView addSubview:_senderLabel];
        
        dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 94, kScreenWidth, 40)];
        dateLabel.text = [NSString stringWithFormat:@"  发送时间:       %@",self.aSendDate];
        //    titleLabel1.textAlignment = 1;
        dateLabel.font = OPFont(16);
        dateLabel.backgroundColor = [UIColor whiteColor];
        [self.backgroungScrollView addSubview:dateLabel];
        
        
        repeatLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 135, kScreenWidth, 40)];
     
        repeatLabel.text = [NSString stringWithFormat:@"  完成期限:       %@",self.ExpDate];
       
        
        repeatLabel.font = OPFont(16);
        repeatLabel.backgroundColor = [UIColor whiteColor];
        [self.backgroungScrollView addSubview:repeatLabel];
        
        // 计算model.desc文字的高度
        CGFloat descLabelHeight = [ConfigUITools calculateTextHeight:self.chContent size:CGSizeMake(kScreenWidth, MAXFLOAT) font:OPFont(16)];
        
        CGFloat height;
        if (descLabelHeight <40.0) {
            
            height = 40;
            
        }else {
            
            height = descLabelHeight;
            
        }
        contentLabel = [[UILabel alloc]init];
        contentLabel.frame =CGRectMake(0, 176, kScreenWidth , height);
        contentLabel.text =self.chContent;
        contentLabel.backgroundColor = [UIColor whiteColor];
        contentLabel.font = OPFont(16);
        [self.backgroungScrollView addSubview:contentLabel];
        OPLog(@"ff %f",CGRectGetMaxY(contentLabel.frame));
        backView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(contentLabel.frame)+ 1, kScreenWidth, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.backgroungScrollView addSubview:backView];
        

        deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/3 * 2 - 5, 5, kScreenWidth / 3, 40)];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"形状副本-拷贝"] forState:UIControlStateNormal];
        deleteBtn.layer.cornerRadius = 4;
        deleteBtn.layer.masksToBounds = 1;
        [deleteBtn setTitle:@"快速回复" forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = OPFont(16);
        deleteBtn.tag = 200;
        [deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(shouBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:deleteBtn];
        
        textBackView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(backView.frame)+1, kScreenWidth - 20, 100)];
        textBackView.backgroundColor = [UIColor grayColor];
        textBackView.layer.cornerRadius = 4;
        textBackView.layer.masksToBounds = 1;
        [_backgroungScrollView addSubview:textBackView];
        
        _taskContentTView = [[UITextView alloc]init];
        //    _contentTView.backgroundColor = kTestColor;
        _taskContentTView.frame = CGRectMake(1, 1, kScreenWidth - 22, CGRectGetHeight(textBackView.frame) - 2);
        _taskContentTView.font = [UIFont systemFontOfSize:14];
        _taskContentTView.layer.cornerRadius = 4;
        _taskContentTView.layer.masksToBounds = 1;
        [textBackView addSubview:_taskContentTView];

        
        okBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(textBackView.frame) + 5, kScreenWidth - 40, 40)];
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
        [_backgroungScrollView addSubview:okBtn];
        
        
        quckBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(okBtn.frame) + 5, kScreenWidth - 40, 40)];
        quckBtn.backgroundColor = kBtnColor;
        [quckBtn setTitle:@"回复并完成" forState:UIControlStateNormal];
        quckBtn.titleLabel.font = OPFont(16);
        quckBtn.tag = 202;
        [quckBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        quckBtn.layer.cornerRadius = 4;
        quckBtn.layer.masksToBounds = 1;
        [quckBtn addTarget:self action:@selector(shouBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_backgroungScrollView addSubview:quckBtn];
        [ConfigUITools sizeToScroll:_backgroungScrollView withStandardElementMaxY:CGRectGetMaxY(quckBtn.frame) + 25 forStepsH:0];

    }
   
}
- (void)configAfterData:(NSDictionary *)dict {

    if (self.headTag == 0) {
        
        titleLabel.text = [dict objectForKey:@"ChTopic"];
        _senderLabel.text = [NSString stringWithFormat:@"  通知发送者:    %@",[dict objectForKey:@"senderName"]];
        dateLabel.text = [NSString stringWithFormat:@"  发送时间:    %@",[dict objectForKey:@"sendDate"]];
        repeatLabel.text =[NSString stringWithFormat:@"  回执时间:    %@",[dict objectForKey:@"receiptDate"]];
        
        CGFloat descLabelHeight = [ConfigUITools calculateTextHeight:[dict objectForKey:@"chContent"] size:CGSizeMake(kScreenWidth, MAXFLOAT) font:OPFont(16)];
        
        CGFloat height;
        if (descLabelHeight <40.0) {
            
            height = 40;
            
        }else {
            
            height = descLabelHeight;
            
        }
        contentLabel.frame =CGRectMake(0, 176, kScreenWidth , height);
        contentLabel.text = [dict objectForKey:@"chContent"];
        backView.frame =CGRectMake(0, CGRectGetMaxY(contentLabel.frame)+ 1, kScreenWidth, 50);
        UIView  *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        lineView1.backgroundColor = [ConfigUITools colorWithR:77 G:184 B:73 A:1];
        [backView addSubview:lineView1];
        
        textBackView.frame =CGRectMake(10, CGRectGetMaxY(backView.frame)+1, kScreenWidth - 20, 100);
        
        okBtn.frame = CGRectMake(20, CGRectGetMaxY(textBackView.frame) + 5, kScreenWidth - 40, 40);
        
        [ConfigUITools sizeToScroll:_backgroungScrollView withStandardElementMaxY:CGRectGetMaxY(okBtn.frame) + 25 forStepsH:0];
   
    }
    
    if (self.headTag == 1) {
        
        
    }
}


- (void)shouBtnClicked:(UIButton *)sender {

    switch (sender.tag - 200) {
        case 0:
        {
        
            NSArray *contentArr = @[@"  你好,已收到通知,我们将准时参加!",@"  你好,已收到通知,我们确定安排后,会及时回复!",@"  你好,已收到通知,因故无法参加,请知悉!"];
            [self showSelectedWithTitle:@"请选择回复内容" subTitles:contentArr];
        }
            
            break;
        case 1:
        {

            [SVProgressHUD showSuccessWithStatus:@"回复哦"];
        
        }
            
            
            break;
        case 2:
        {

            [SVProgressHUD showSuccessWithStatus:@"回复并完成哦"];
            
        }
            
            
            break;
            
        default:
            break;
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
    
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 2 / 3, 60)];
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
                NSDictionary * result = [jsonParser objectWithString:[[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"]
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

    [_backgroungScrollView endEditing:YES];

}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:YES];
    [DaiDodgeKeyboard removeRegisterTheViewNeedDodgeKeyboard];


}


@end

//
//  ResignReportViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/3/14.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "ResignReportViewController.h"
#import "UserDeptViewController.h"
#import "UUDatePicker.h"
#define kHeight 40
#define kFont  15
#define kLabelWidth 75
#define kContentStart 105
#define kContentWidth  [UIScreen mainScreen].bounds.size.width - kContentStart - 10
@interface ResignReportViewController ()<UUDatePickerDelegate,UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic, strong) UIScrollView *backgroungScrollView;

@property (nonatomic, strong) NSArray      *elementArray;
@property (nonatomic, strong) UIView       *coverView;
@property (nonatomic, strong) UIView       *topView;

@property (nonatomic, strong) UITextField  *reporterPhoneTF;
@property (nonatomic, strong) UITextField  *reporterTF;
@property (nonatomic, strong) UIButton     *notiTypeBtn;
@property (nonatomic, strong) UIButton     *sendToBtn;
@property (nonatomic, strong) UUDatePicker *datePicker;
@property (nonatomic, strong) UIButton     *meetingTimeBtn;
@property (nonatomic, strong) UIView       *datePickerView;
@property (nonatomic, strong) UITextField  *jiaojierenTF;
@property (nonatomic, strong) UITextField  *jiaojierenPhoneTF;

@property (nonatomic, strong) UITextView   *contentTView;

@property (nonatomic, assign) float         lastElementMaxY;

@property (nonatomic, strong) NSString  *idString;
@property (nonatomic, strong) NSString  *nameString;
@end

@implementation ResignReportViewController
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"离职报告";
    
    _backgroungScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _backgroungScrollView.backgroundColor = kBackColor;
    _backgroungScrollView.userInteractionEnabled = YES;
    [self.view addSubview:_backgroungScrollView];
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:_backgroungScrollView];
    
    [self initElement];
    
}


- (void)initElement{
    
    if (!_elementArray) {//90 173 243
        
        _elementArray = @[@"报告人:",@"联系电话:", @"是否交接:",@"交接人:",@"联系电话:",@"交接日期:"];
    }
    
    for (int i = 0; i < 6; i ++) {

        UIView *view = [[UIView alloc]init];
        
        [_backgroungScrollView addSubview:view];
        view.backgroundColor = kBackColor;


        UILabel *titleLabel1 = [[UILabel alloc]init];
        
        titleLabel1.text = _elementArray[i];
        titleLabel1.font = [UIFont systemFontOfSize:kFont];
        [view addSubview:titleLabel1];
 
        view.frame = CGRectMake(0, i * (kHeight + 1), kScreenWidth, kHeight);
        titleLabel1.frame = CGRectMake(10, 0, kLabelWidth, 40);
        if (i == 5) {
           
            _lastElementMaxY = CGRectGetMaxY(view.frame);
            
        }
    
    }
    
    [self addNotiSubviews];
    
}

- (void)addNotiSubviews {
//
    
    
    
    _reporterTF = [[UITextField alloc]init];
    _reporterTF.backgroundColor = kTestColor;
    _reporterTF.frame = CGRectMake(kContentStart,0, kContentWidth, kHeight);
    _reporterTF.font = [UIFont systemFontOfSize:kFont];
    _reporterTF.layer.cornerRadius = 4;
    _reporterTF.layer.masksToBounds = 1;
    _reporterTF.delegate = self;
    _reporterTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"xingming"];
    _reporterTF.keyboardType = UIKeyboardTypePhonePad;
    [_backgroungScrollView addSubview:_reporterTF];
    
    
    
//    _sendToBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _sendToBtn.tag = 1000 + 0;
//    _sendToBtn.backgroundColor = kTestColor;
//    [_sendToBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_sendToBtn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    _sendToBtn.frame = CGRectMake(kContentStart, 0, kContentWidth, kHeight);
//    _sendToBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    _sendToBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
//    _sendToBtn.layer.cornerRadius = 4;
//    _sendToBtn.layer.masksToBounds = 1;
//    [_backgroungScrollView addSubview:_sendToBtn];
    
    _reporterPhoneTF = [[UITextField alloc]init];
    _reporterPhoneTF.backgroundColor = kTestColor;
    _reporterPhoneTF.frame = CGRectMake(kContentStart, kHeight + 1, kContentWidth, kHeight);
    _reporterPhoneTF.font = [UIFont systemFontOfSize:kFont];
    _reporterPhoneTF.layer.cornerRadius = 4;
    _reporterPhoneTF.layer.masksToBounds = 1;
    _reporterPhoneTF.delegate = self;
    _reporterPhoneTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"shouji"];
    _reporterPhoneTF.keyboardType = UIKeyboardTypePhonePad;
    [_backgroungScrollView addSubview:_reporterPhoneTF];
    
    _notiTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _notiTypeBtn.tag = 1000 + 1;
    _notiTypeBtn.backgroundColor = kTestColor;
    [_notiTypeBtn setTitle:@"未交接" forState:UIControlStateNormal];
    [_notiTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_notiTypeBtn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _notiTypeBtn.frame = CGRectMake(kContentStart, 2 * kHeight + 2, kContentWidth, kHeight);
    _notiTypeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _notiTypeBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
    _notiTypeBtn.layer.cornerRadius = 4;
    _notiTypeBtn.layer.masksToBounds = 1;
    [_backgroungScrollView addSubview:_notiTypeBtn];
    
    _jiaojierenTF = [[UITextField alloc]init];
    _jiaojierenTF.backgroundColor = kTestColor;
    _jiaojierenTF.frame = CGRectMake(kContentStart,3 * kHeight + 3, kContentWidth, kHeight);
    _jiaojierenTF.font = [UIFont systemFontOfSize:kFont];
    _jiaojierenTF.layer.cornerRadius = 4;
    _jiaojierenTF.layer.masksToBounds = 1;
    _jiaojierenTF.delegate = self;
    [_backgroungScrollView addSubview:_jiaojierenTF];
    
    
    _jiaojierenPhoneTF = [[UITextField alloc]init];
    _jiaojierenPhoneTF.backgroundColor = kTestColor;
    _jiaojierenPhoneTF.frame = CGRectMake(kContentStart,4 * kHeight + 4, kContentWidth, kHeight);
    _jiaojierenPhoneTF.font = [UIFont systemFontOfSize:kFont];
    _jiaojierenPhoneTF.layer.cornerRadius = 4;
    _jiaojierenPhoneTF.layer.masksToBounds = 1;
    _jiaojierenPhoneTF.delegate = self;
    _jiaojierenPhoneTF.keyboardType = UIKeyboardTypePhonePad;
    [_backgroungScrollView addSubview:_jiaojierenPhoneTF];
    

    _meetingTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _meetingTimeBtn.tag = 1000 + 2;
    _meetingTimeBtn.backgroundColor = kTestColor;
    [_meetingTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_meetingTimeBtn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _meetingTimeBtn.frame = CGRectMake(kContentStart, 5 * kHeight + 5, kContentWidth, kHeight);
    _meetingTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _meetingTimeBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
    _meetingTimeBtn.layer.cornerRadius = 4;
    _meetingTimeBtn.layer.masksToBounds = 1;
    [_backgroungScrollView addSubview:_meetingTimeBtn];
    

    
    UILabel *conetntLabrl = [[UILabel alloc]init];
    conetntLabrl.backgroundColor = kBackColor;
    conetntLabrl.frame = CGRectMake(10, 6 * kHeight+  6, kContentWidth, kHeight);
    conetntLabrl.text = @"内容:";
    conetntLabrl.textColor = [UIColor orangeColor];
    [_backgroungScrollView addSubview:conetntLabrl];
    
    UIView *textBackView = [[UIView alloc]initWithFrame:CGRectMake(10, 7 * kHeight+  7, kScreenWidth - 20, 3.5 * kHeight)];
    textBackView.backgroundColor = [UIColor blackColor];
    textBackView.layer.cornerRadius = 4;
    textBackView.layer.masksToBounds = 1;
    
    [_backgroungScrollView addSubview:textBackView];
    
    
    _contentTView = [[UITextView alloc]init];
    //    _contentTView.backgroundColor = kTestColor;
    _contentTView.frame = CGRectMake(1, 1, kScreenWidth - 22, CGRectGetHeight(textBackView.frame) - 2);
    _contentTView.font = [UIFont systemFontOfSize:kFont];
    _contentTView.delegate = self;
    _contentTView.layer.cornerRadius = 4;
    _contentTView.layer.masksToBounds = 1;
    [textBackView addSubview:_contentTView];

    
    UIButton  *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.backgroundColor = kTestColor;
    submitBtn.tag = 1000 + 3;
    //    [submitBtn setBackgroundImage:[UIImage imageNamed:@"矩形-9"] forState:UIControlStateNormal];
    submitBtn.backgroundColor = kBtnColor;
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius = 4;
    submitBtn.layer.masksToBounds = 1;
    submitBtn.frame = CGRectMake(20, CGRectGetMaxY(textBackView.frame) + 15, kScreenWidth - 40, 40);
    [_backgroungScrollView addSubview:submitBtn];

    _lastElementMaxY = CGRectGetMaxY(submitBtn.frame);
    NSLog(@"---dd%f",_lastElementMaxY);
    
    [ConfigUITools sizeToScroll:_backgroungScrollView withStandardElementMaxY:_lastElementMaxY + 25 forStepsH:0];
    
}



- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
    if (_datePickerView) {
        
        _datePickerView.hidden = 1;
    }
    
}

- (void)allBtnClicked:(UIButton *)sender {
    
    switch (sender.tag - 1000) {
        case 0:
        {
            UserDeptViewController *de = [[UserDeptViewController alloc]init];
            de.isJump = YES;
            de.selectedBlock = ^(NSMutableArray *array){
                
                _idString = @"";
                _nameString = @"";
                NSMutableArray  *idStringArr = [[NSMutableArray alloc]init];
                NSMutableArray  *nameStringArr = [[NSMutableArray alloc]init];
                for (NSDictionary *dict in array) {
                    
                    [idStringArr addObject:[dict objectForKey:@"id"]];
                    [nameStringArr addObject:[dict objectForKey:@"name"]];
                }
                
                if (idStringArr.count > 0) {
                    
                    if (idStringArr.count >= 2 ) {
                        
                        _idString = idStringArr[0];
                        _nameString = nameStringArr[0];
//                        
//                        _idString = [idStringArr componentsJoinedByString:@","];
//                        _nameString = [nameStringArr componentsJoinedByString:@","];
                        
                    }else {
                        
                        _idString = idStringArr[0];
                        _nameString = nameStringArr[0];
                    }
                    
                }else {
                    
                    
                }
                
                OPLog(@"string %@",_idString);
                OPLog(@"stringName %@",_nameString);
                
                
                NSString *title = @"";
                if (array.count > 0) {
                    NSMutableArray *arr = [[NSMutableArray alloc]init];
                    for (NSDictionary *dict in array) {
                        
                        [arr addObject:[dict objectForKey:@"name"]];
                        
                        
                    }
                    
                    title = [(NSArray *)arr componentsJoinedByString:@"、"];
                }
                
                [_sendToBtn setTitle:_nameString forState:UIControlStateNormal];
                [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:_backgroungScrollView];
                
            };
            [self.navigationController pushViewController:de animated:YES];
            
        }

            
            break;
        case 1:
            
            
            [self showSelectedWithTitle:@"是否交接" subTitles:@[@"已交接",@"未交接"]];

            break;
        case 2:
        {
            
            [self meetingDateSelected];
            
        }
            
            
            break;
        case 3:
        {
            
            if ([AppDelegate isNetworkConecting]) {
                
                
                
                if ([AlertTipsViewTool isEmptyWillSubmit:@[_reporterTF,
                                                           _reporterPhoneTF,
                                                           _notiTypeBtn,
                                                           _jiaojierenTF,
                                                           _jiaojierenPhoneTF,
                                                           _meetingTimeBtn,
                                                           _contentTView]]) {
                    
                    
                }else {
//
                    NSDictionary *keyAndValues = @{@"logincookie":[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],@"datatype":@"lizhibaogao"};
                    
                    //usercode
                    NSString *xmlString =  [JHXMLParser generateXMLString:keyAndValues hostName:@"Net.GongHuiTong" startElementKey:@"AddAppInfo" xmlInfo:YES resouresInfo:@{@"MemberCode":[[NSUserDefaults standardUserDefaults] objectForKey:@"usercode"],@"MemberName":_reporterTF.text,@"MemberPhone":_reporterPhoneTF.text,@"jiaojierenName":_jiaojierenTF.text,@"jiaojierenPhone":_jiaojierenPhoneTF.text,@"isjiaojie":_notiTypeBtn.titleLabel.text,@"jiaojiedate":_meetingTimeBtn.titleLabel.text,@"Content":_contentTView.text} fileNames:nil fileExtNames:nil fileDesc:nil fileData:nil];
                    
                    
                    OPLog(@"---xml    %@",xmlString);
                    [self submitAddUserWithXmlString:xmlString];
//
//                    
                }
                
            }else {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无网络连接,请检查网络!" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    
                    
                }];
                
                [alertController addAction:okAction];
                
                [self.navigationController  presentViewController:alertController animated:YES completion:nil];
                
            }
            
        }
            
            break;
        case 5:
            
            
            break;
            
        default:
            break;
    }
    
}

- (void)submitAddUserWithXmlString:(NSString *)xmlString
{
    
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showInfoWithStatus:@"增在提交..."];
    
    __weak typeof(self) weakSelf = self;
    ReturnValueBlock returnBlockPost = ^(id resultValue){
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"AddAppInfoResult::%@",[[resultValue lastObject] objectForKey:@"AddAppInfoResult"]);
            
            if ([[[resultValue lastObject] objectForKey:@"AddAppInfoResult"] isEqualToString:@"操作失败！"]) {
                
                [SVProgressHUD showErrorWithStatus:@"提交失败!"];
                
                
            }else {
                
                //                weakSelf.submitBtnBlock( YES);
                [SVProgressHUD showSuccessWithStatus:@"提交成功！"];
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
            }
            
            
            
        });
        
        
        
        
        
    };
    
    
    [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:xmlString parseParameters:@[@"AddAppInfoResult"] WithReturnValeuBlock:returnBlockPost WithErrorCodeBlock:nil];
    
    
    
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
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth / 6, ([UIScreen mainScreen].bounds.size.height - (array.count * 45 + array.count + 1)) / 2, kScreenWidth * 2 / 3, array.count * 45 + array.count + 1 + 61)];
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
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth * 2 / 3, 1)];
    line.backgroundColor = [ConfigUITools colorWithR:90 G:173 B:243 A:1];
    
    [_topView addSubview:line];
    
    
    for (int i = 0 ; i < array.count; i ++) {
        
        UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        typeBtn.tag = i;
        [typeBtn setTitle:array[i] forState:UIControlStateNormal];
        [typeBtn addTarget:self action:@selector(typeTipBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        typeBtn.frame = CGRectMake(0, 61 + i * 47, kScreenWidth * 2 / 3, 45);
        typeBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_topView addSubview:typeBtn];
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(typeBtn.frame), kScreenWidth * 2 / 3, 1)];
        line1.backgroundColor = [UIColor lightGrayColor];
        
        [_topView addSubview:line1];
        
        
    }
    
    
    
}

- (void)hidePopupView:(UITapGestureRecognizer*)gesture {
    
    [_coverView removeFromSuperview];
    [_topView removeFromSuperview];
}
- (void)typeTipBtnClicked:(UIButton *)sender {
    [self.view endEditing:YES];
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
        case 3:
            
            btnTitle = sender.titleLabel.text;
            
            break;
            
        default:
            break;
    }
    [_notiTypeBtn setTitle:btnTitle forState:UIControlStateNormal];
   
    
}

- (void)meetingDateSelected {
    
    NSDate *now = [NSDate date];
    
    [_backgroungScrollView endEditing:YES];
    if (!_datePickerView) {
        
        _datePickerView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 300, kScreenHeight, 300)];
        _datePickerView.backgroundColor = kBackColor;
        
        [_backgroungScrollView addSubview:_datePickerView];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.tag = 11 + 0;
        cancelBtn.backgroundColor = [ConfigUITools colorWithR:90 G:173 B:243 A:1];
        [cancelBtn addTarget:self action:@selector(timeClicked:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.frame = CGRectMake(1, 0, kScreenWidth / 2 - 1.5, 35);
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_datePickerView addSubview:cancelBtn];
        
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        doneBtn.tag = 11 + 1;
        doneBtn.backgroundColor = [ConfigUITools colorWithR:90 G:173 B:243 A:1];
        [doneBtn addTarget:self action:@selector(timeClicked:) forControlEvents:UIControlEventTouchUpInside];
        doneBtn.frame = CGRectMake(kScreenWidth / 2 + 0.5, 0, kScreenWidth / 2 - 1.5, 35);
        doneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_datePickerView addSubview:doneBtn];
        
        
        
        
        _datePicker= [[UUDatePicker alloc]initWithframe:CGRectMake(1, 36, kScreenWidth - 2, 216)
                                               Delegate:self
                                            PickerStyle:UUDateStyle_YearMonthDayHourMinute];
        _datePicker.ScrollToDate = now;
        _datePicker.minLimitDate = now;
        [_datePickerView addSubview:_datePicker];
        
        
    }else {
        
        _datePickerView.hidden = NO;
    }
    
    
    
    
}

#pragma mark - UUDatePicker's delegate
- (void)uuDatePicker:(UUDatePicker *)datePicker
                year:(NSString *)year
               month:(NSString *)month
                 day:(NSString *)day
                hour:(NSString *)hour
              minute:(NSString *)minute
             weekDay:(NSString *)weekDay
{
    NSLog(@"66 %@",[NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,month,day,hour,minute]);
    [_meetingTimeBtn setTitle:[NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,month,day,hour,minute] forState:UIControlStateNormal];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [_backgroungScrollView endEditing:YES];
}


- (void)timeClicked:(UIButton *)sender {
    
    switch (sender.tag - 11) {
        case 0:
        {
            
            _datePickerView.hidden = 1;
            [_meetingTimeBtn setTitle:@"" forState:UIControlStateNormal];
            
        }
            
            break;
            
        case 1:
        {
            
            _datePickerView.hidden = 1;
            
        }
            
            
            break;
            
        default:
            break;
    }
    
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [DaiDodgeKeyboard removeRegisterTheViewNeedDodgeKeyboard];
}


@end

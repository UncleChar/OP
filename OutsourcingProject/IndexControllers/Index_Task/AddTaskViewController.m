//
//  AddTaskViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/2/23.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "AddTaskViewController.h"
#import "UserDeptViewController.h"
#import "UUDatePicker.h"
#define kHeight  40
#define kFont  17
@interface AddTaskViewController ()<UUDatePickerDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, strong) UIScrollView *backgroungScrollView;

@property (nonatomic, strong) UITextField  *taskTitleTF;
@property (nonatomic, strong) UIButton     *receivedBtn;
@property (nonatomic, strong) UUDatePicker *datePicker;
@property (nonatomic, strong) UIButton     *startTimeBtn;
@property (nonatomic, strong) UIButton     *endTimeBtn;
@property (nonatomic, strong) UITextView   *taskContentTView;
@property (nonatomic, strong) UIButton     *cancelBtn;
@property (nonatomic, strong) UIButton     *saveBtn;
@property (nonatomic, strong) UIView       *datePickerView;
@property (nonatomic, assign) NSInteger     tagBtn;

@property (nonatomic, strong) NSString  *idString;
@property (nonatomic, strong) NSString  *nameString;


@end

@implementation AddTaskViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.ENUMShowType == ENUM_ShowWithEditInfo) {
        
        self.title = @"新建任务";
    }else {
    
        self.title = @"任务详情";
    
    }
    
    _idString = @"";
    
    _backgroungScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _backgroungScrollView.backgroundColor = kBackColor;
    _backgroungScrollView.userInteractionEnabled = YES;
    [self.view addSubview:_backgroungScrollView];
    
    
    NSLog(@"ddffd%@",NSStringFromCGRect(_backgroungScrollView.frame));
    
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:_backgroungScrollView];
    
    [self initElement];
    
    
}


- (void)initElement{

//        biaoti  jieshouren 开始时间 要求办结时间 任务内msg_labels_t
  
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(10, 1, 75, kHeight);
    titleLabel.text = @"标题:";
    [_backgroungScrollView addSubview:titleLabel];
    titleLabel.textColor = [UIColor orangeColor];
    titleLabel.font = [UIFont systemFontOfSize:kFont];
    
    _taskTitleTF = [[UITextField alloc]init];
    _taskTitleTF.layer.cornerRadius = 4;
    _taskTitleTF.layer.masksToBounds = 1;
    _taskTitleTF.delegate = self;
    _taskTitleTF.placeholder = @"请输入任务标题";
    _taskTitleTF.backgroundColor = kTestColor;
    _taskTitleTF.frame = CGRectMake(85, 1, kScreenWidth - 95, kHeight);
    [_backgroungScrollView addSubview:_taskTitleTF];
    _taskTitleTF.font = [UIFont systemFontOfSize:kFont];

    
    UILabel *receiveLabel = [[UILabel alloc]init];
    receiveLabel.frame = CGRectMake(10, 2 + kHeight, 75, kHeight);
    receiveLabel.text = @"接收人:";
    receiveLabel.textColor = [UIColor orangeColor];
    [_backgroungScrollView addSubview:receiveLabel];
    receiveLabel.font = [UIFont systemFontOfSize:kFont];
    
    _receivedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _receivedBtn.tag = 777 + 0;
    _receivedBtn.backgroundColor = kTestColor;
    _receivedBtn.layer.cornerRadius = 4;
    _receivedBtn.layer.masksToBounds = 1;
    [_receivedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_receivedBtn addTarget:self action:@selector(taskBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _receivedBtn.frame = CGRectMake(85, kHeight + 2, kScreenWidth - 95, kHeight);
    _receivedBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _receivedBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
    [_backgroungScrollView addSubview:_receivedBtn];
    
    UILabel *startLabel = [[UILabel alloc]init];
    startLabel.frame = CGRectMake(10, 3 + 2 * kHeight, kScreenWidth - 20, kHeight);
    startLabel.text = @"开始时间:";
    startLabel.textColor = [UIColor orangeColor];
    startLabel.font = [UIFont systemFontOfSize:kFont];
    [_backgroungScrollView addSubview:startLabel];
    
    
    _startTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _startTimeBtn.tag = 777 + 1;
    _startTimeBtn.layer.cornerRadius = 4;
    _startTimeBtn.layer.masksToBounds = 1;
    _startTimeBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
    _startTimeBtn.backgroundColor = kTestColor;
    [_startTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_startTimeBtn addTarget:self action:@selector(taskBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _startTimeBtn.frame = CGRectMake(10, CGRectGetMaxY(startLabel.frame)+1, kScreenWidth - 20, kHeight);
    _startTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_backgroungScrollView addSubview:_startTimeBtn];
    
    UILabel *endLabel = [[UILabel alloc]init];
    endLabel.font = [UIFont systemFontOfSize:kFont];
    endLabel.textColor = [UIColor orangeColor];
    endLabel.frame = CGRectMake(10, CGRectGetMaxY(_startTimeBtn.frame)+1, kScreenWidth - 20, kHeight);
    endLabel.text = @"要求结办时间:";
    [_backgroungScrollView addSubview:endLabel];
    
    
    _endTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _endTimeBtn.tag = 777 + 2;
    _endTimeBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
    _endTimeBtn.layer.cornerRadius = 4;
    _endTimeBtn.layer.masksToBounds = 1;
    _endTimeBtn.backgroundColor = kTestColor;
    [_endTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_endTimeBtn addTarget:self action:@selector(taskBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _endTimeBtn.frame = CGRectMake(10, CGRectGetMaxY(endLabel.frame)+1, kScreenWidth - 20, kHeight);
    _endTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_backgroungScrollView addSubview:_endTimeBtn];
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.frame = CGRectMake(10, CGRectGetMaxY(_endTimeBtn.frame)+1, kScreenWidth - 20, kHeight);
    contentLabel.text = @"任务内容描述:";
    contentLabel.textColor = [UIColor orangeColor];
    contentLabel.font = [UIFont systemFontOfSize:kFont];
    [_backgroungScrollView addSubview:contentLabel];
    
    
    
    UIView *textBackView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(contentLabel.frame), kScreenWidth - 20, 3.5 * kHeight)];
    textBackView.backgroundColor = [UIColor blackColor];
    textBackView.layer.cornerRadius = 4;
    textBackView.layer.masksToBounds = 1;
    [_backgroungScrollView addSubview:textBackView];
    
    _taskContentTView = [[UITextView alloc]init];
    //    _contentTView.backgroundColor = kTestColor;
    _taskContentTView.frame = CGRectMake(1, 1, kScreenWidth - 22, CGRectGetHeight(textBackView.frame) - 2);

    _taskContentTView.delegate = self;
    _taskContentTView.font = [UIFont systemFontOfSize:kFont];
    _taskContentTView.layer.cornerRadius = 4;
    _taskContentTView.layer.masksToBounds = 1;
    [textBackView addSubview:_taskContentTView];
    
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.tag = 777 + 3;
    [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"形状副本-拷贝"] forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(taskBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _cancelBtn.frame = CGRectMake(kScreenWidth / 4 - 50, CGRectGetMaxY(textBackView.frame) + 20, 100, kHeight);
    [_backgroungScrollView addSubview:_cancelBtn];
    _cancelBtn.layer.cornerRadius = 4;
    _cancelBtn.layer.masksToBounds = 1;
    
    
    _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveBtn.tag = 777 + 4;
    _saveBtn.backgroundColor = kBtnColor;
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_saveBtn addTarget:self action:@selector(taskBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _saveBtn.frame = CGRectMake(kScreenWidth / 4 * 3 - 50, CGRectGetMaxY(textBackView.frame) + 20, 100, kHeight);
    [_backgroungScrollView addSubview:_saveBtn];
    _saveBtn.layer.cornerRadius = 4;
    _saveBtn.layer.masksToBounds = 1;
    
    
    [ConfigUITools sizeToScroll:_backgroungScrollView withStandardElementMaxY:CGRectGetMaxY(_saveBtn.frame) + 25 forStepsH:0];
    
    switch (self.ENUMShowType) {
        case ENUM_ShowWithExistInfo:
        {
            
            
            _taskTitleTF.text = self.titleTopc;

            [_receivedBtn setTitle:self.receiveNamess forState:UIControlStateNormal];

            _nameString = _receivedBtn.titleLabel.text;

            [_startTimeBtn setTitle:self.sendDate forState:UIControlStateNormal];
 
            [_endTimeBtn setTitle:self.extDate forState:UIControlStateNormal];

       
 
             _taskContentTView.text = self.content;
            
            _taskContentTView.text = [self.content htmlEntityDecode];
            _taskContentTView.font = OPFont(15);
//            [_taskContentTView setEditable:NO];

            
            
            
            
        }
            break;
        case ENUM_ShowWithEditInfo:
            
            
            break;
            
        default:
            break;
    }
    
}
    





- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
    if (_datePickerView) {
        
        _datePickerView.hidden = 1;
    }
    
}

- (void)taskBtnClicked:(UIButton *)sender {
    
    switch (sender.tag - 777) {
        case 0:
            
        {
            UserDeptViewController *de = [[UserDeptViewController alloc]init];
            de.isJump = YES;
            de.isBlock = YES;
            _isChongxin = YES;
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
                    
//                    if (idStringArr.count >= 2 ) {
//                        
//                        
//                        //                        _idString = [idStringArr componentsJoinedByString:@","];
//                        //                        _nameString = [nameStringArr componentsJoinedByString:@","];
//                        
//                    }else {
                    
                        _idString = idStringArr[0];
                        _nameString = nameStringArr[0];
//                    }
                    
                }else {
                    
                    
                }
                
                OPLog(@"string %@",_idString);
                OPLog(@"stringName %@",_nameString);

                
//                NSString *title = @"";
//                if (array.count > 0) {
//                    NSMutableArray *arr = [[NSMutableArray alloc]init];
//                    for (NSDictionary *dict in array) {
//                        
//                        [arr addObject:[dict objectForKey:@"name"]];
//                        
//
//                    }
//                    
//                    title = [(NSArray *)arr componentsJoinedByString:@","];
//                }
                
                [_receivedBtn setTitle:_nameString forState:UIControlStateNormal];
                [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:_backgroungScrollView];
                
            };
            [self.navigationController pushViewController:de animated:YES];
            
        }

            break;
        case 1:
            
        {
            _tagBtn = 11;
            [self meetingDateSelected];
            
        }
            
            break;
        case 2:

        {
            
            
            _tagBtn = 22;
            [self meetingDateSelected];
            
        }
            
            
            break;
        case 3:

            
            break;
        case 4:
        {
            
            if ([AppDelegate isNetworkConecting]) {
                
                
                switch (self.ENUMShowType) {
                        
                    case ENUM_ShowWithExistInfo:
                    {
                    
                        
//                        NSDictionary *keyAndValues = @{@"logincookie":[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],@"datatype":@"gongzuorenwu"};
                     
                      
                        if (_isChongxin) {
                           
                            NSDictionary *keyAndValues = @{@"logincookie":[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],@"datatype":@"gongzuorenwu",@"id":@([self.postID integerValue])};
                            OPLog(@"dict  %@",keyAndValues);
                            NSString *xmlString =  [JHXMLParser generateXMLString:keyAndValues hostName:@"Net.GongHuiTong" startElementKey:@"EditAppInfo" xmlInfo:YES resouresInfo:@{@"fld_29_1":_taskTitleTF.text,@"fld_29_2":_taskContentTView.text,@"fld_29_3":_idString,@"fld_29_4":_nameString,@"fld_29_5":_endTimeBtn.titleLabel.text} fileNames:nil fileExtNames:nil fileDesc:nil fileData:nil];
                            OPLog(@"---xml    %@",xmlString);
                            [self submitAddUserWithXmlString:xmlString];

                            
                            
                        }else {
                        
                        
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请重新选择接收人" message:nil preferredStyle:UIAlertControllerStyleAlert];
                            
                            
                            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                
                                
                                
                            }];
                            
                            [alertController addAction:okAction];
                            
                            [self.navigationController  presentViewController:alertController animated:YES completion:nil];
                        
                        }
                        

                        
                    }
                        
                        break;
                        
                    case ENUM_ShowWithEditInfo:
                    {
                    
                        NSDictionary *keyAndValues = @{@"logincookie":[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],@"datatype":@"gongzuorenwu"};
                        
                        //                NSDateFormatter *df = [[NSDateFormatter alloc]init];
                        //                //设置转换格式
                        //                df.dateFormat = @"yyyy-MM-dd HH:mm";
                        //                NSString *str = [df stringFromDate:[NSDate date]];
                        
                        NSString *xmlString =  [JHXMLParser generateXMLString:keyAndValues hostName:@"Net.GongHuiTong" startElementKey:@"AddAppInfo" xmlInfo:YES resouresInfo:@{@"fld_29_1":_taskTitleTF.text,@"fld_29_2":_taskContentTView.text,@"fld_29_3":_idString,@"fld_29_4":_nameString,@"fld_29_5":_endTimeBtn.titleLabel.text} fileNames:nil fileExtNames:nil fileDesc:nil fileData:nil];
                        OPLog(@"---xml    %@",xmlString);
                        [self submitAddUserWithXmlString:xmlString];
                    
                    }
                        
                        break;
                        
                    default:
                        break;
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

            
        default:
            break;
    }
    
}


- (void)submitAddUserWithXmlString:(NSString *)xmlString
{
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        
        switch (self.ENUMShowType) {
                            
                        case ENUM_ShowWithExistInfo:
                        {
                            
                            __weak typeof(self) weakSelf = self;
                            ReturnValueBlock returnBlockPost = ^(id resultValue){
                            
                              dispatch_async(dispatch_get_main_queue(), ^{
                              
                              
                              
                                  NSLog(@"EditAppInfoResult::%@",[[resultValue lastObject] objectForKey:@"EditAppInfoResult"]);
                                  
                                  if ([[[resultValue lastObject] objectForKey:@"EditAppInfoResult"] isEqualToString:@"操作失败！"]) {
                                      
                                      [SVProgressHUD showErrorWithStatus:@"编辑任务失败!"];
                                      
                                      
                                  }else {
                                      
                                      [SVProgressHUD showSuccessWithStatus:@"编辑任务成功!"];
                                  }
                              
                                   [weakSelf.navigationController popViewControllerAnimated:YES];
                              
                              });
 
                            };
                            
                          
                            
                            [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:xmlString parseParameters:@[@"EditAppInfoResult"] WithReturnValeuBlock:returnBlockPost WithErrorCodeBlock:nil];
                         
                            
                        }
                            
                            break;
                            
                        case ENUM_ShowWithEditInfo:
                        {
                            
                            
                            __weak typeof(self) weakSelf = self;
                            ReturnValueBlock returnBlockPost = ^(id resultValue){
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    
                                    
                                    NSLog(@"AddAppInfoResult::%@",[[resultValue lastObject] objectForKey:@"AddAppInfoResult"]);
                                    
                                    if ([[[resultValue lastObject] objectForKey:@"AddAppInfoResult"] isEqualToString:@"操作失败！"]) {
                                        
                                        [SVProgressHUD showErrorWithStatus:@"添加任务失败!"];
                                        
                                        
                                    }else {
                                        
                                        [SVProgressHUD showSuccessWithStatus:@"添加任务成功!"];
                                    }
                                    
                                     [weakSelf.navigationController popViewControllerAnimated:YES];
                                    
                                });
                                
                            };
                            
                           
                            
                            [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:xmlString parseParameters:@[@"AddAppInfoResult"] WithReturnValeuBlock:returnBlockPost WithErrorCodeBlock:nil];
                            
                        }
                            
                            break;
                            
                        default:
                            break;
                    }
                    
     
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
    }
    
    
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

- (void)timeClicked:(UIButton *)sender {
    
    switch (sender.tag - 11) {
        case 0:
        {
            
            _datePickerView.hidden = 1;
            if (_tagBtn == 11) {
                
                [_startTimeBtn setTitle:@"" forState:UIControlStateNormal];
                
            }
            if (_tagBtn == 22) {
           
                [_endTimeBtn setTitle:@"" forState:UIControlStateNormal];
                
            }
            
            
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_backgroungScrollView endEditing:YES];

    return 1;
    
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
    
    if (_tagBtn == 11) {
        
        [_startTimeBtn setTitle:[NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,month,day,hour,minute] forState:UIControlStateNormal];
        
    }
    
    
    if (_tagBtn == 22) {

        [_endTimeBtn setTitle:[NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,month,day,hour,minute]forState:UIControlStateNormal];
        
    }

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [_backgroungScrollView endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated {

  [DaiDodgeKeyboard removeRegisterTheViewNeedDodgeKeyboard];
}


@end

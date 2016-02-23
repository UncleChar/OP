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


@end

@implementation AddTaskViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建任务";
    
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
    _saveBtn.tag = 777 + 3;
    _saveBtn.backgroundColor = kBtnColor;
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_saveBtn addTarget:self action:@selector(taskBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _saveBtn.frame = CGRectMake(kScreenWidth / 4 * 3 - 50, CGRectGetMaxY(textBackView.frame) + 20, 100, kHeight);
    [_backgroungScrollView addSubview:_saveBtn];
    _saveBtn.layer.cornerRadius = 4;
    _saveBtn.layer.masksToBounds = 1;
    
    
    [ConfigUITools sizeToScroll:_backgroungScrollView withStandardElementMaxY:CGRectGetMaxY(_saveBtn.frame) + 25 forStepsH:0];
    
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
            de.selectedBlock = ^(NSMutableArray *array){
                NSString *title = @"";
                if (array.count > 0) {
                    NSMutableArray *arr = [[NSMutableArray alloc]init];
                    for (NSDictionary *dict in array) {
                        
                        [arr addObject:[dict objectForKey:@"name"]];
                        
                        
                    }
                    
                    title = [(NSArray *)arr componentsJoinedByString:@"、"];
                }
                
                [_receivedBtn setTitle:title forState:UIControlStateNormal];
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

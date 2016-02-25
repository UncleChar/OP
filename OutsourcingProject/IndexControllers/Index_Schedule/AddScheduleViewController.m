//
//  AddScheduleViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/2/24.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "AddScheduleViewController.h"
#import "UserDeptViewController.h"
#import "UUDatePicker.h"
#define kHeight 40
#define kFont  15
#define kLabelWidth 75
#define kContentStart 105
#define kContentWidth  [UIScreen mainScreen].bounds.size.width - kContentStart - 10

@interface AddScheduleViewController ()<UUDatePickerDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, strong) UIScrollView *backgroungScrollView;

@property (nonatomic, strong) NSArray      *elementArray;
@property (nonatomic, strong) UIView       *coverView;
@property (nonatomic, strong) UIView       *topView;

@property (nonatomic, strong) UIButton     *urgentLevelBtn;
@property (nonatomic, strong) UIButton     *timeIntervalBtn;
@property (nonatomic, strong) UIButton     *sendToBtn;
@property (nonatomic, strong) UUDatePicker *datePicker;


@property (nonatomic, strong) UIButton     *startTimeBtn;
@property (nonatomic, strong) UIButton     *endTimeBtn;
@property (nonatomic, strong) UIButton     *remindBtn;
@property (nonatomic, strong) UIView       *datePickerView;



@property (nonatomic, strong) UITextField  *meetingAddress;
@property (nonatomic, strong) UITextField  *leaderTF;
@property (nonatomic, strong) UITextView   *contentTView;
@property (nonatomic, strong) UIButton     *receiptTypeBtn;
@property (nonatomic, assign) float         lastElementMaxY;
@property (nonatomic, assign) BOOL          btnSelectedStatus;
@property (nonatomic, assign) NSInteger     btnTimeStatus;
@property (nonatomic, strong) NSString      *selectedTimeStr;



@end

@implementation AddScheduleViewController

- (void)viewWillAppear:(BOOL)animated {


    [super viewWillAppear:YES];
//    if (_backgroungScrollView) {
//        
//        [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:_backgroungScrollView];
//        
//    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建日程";
    
    _backgroungScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _backgroungScrollView.backgroundColor = kBackColor;
    _backgroungScrollView.userInteractionEnabled = YES;
    [self.view addSubview:_backgroungScrollView];
    
    
    NSLog(@"ddffd%@",NSStringFromCGRect(_backgroungScrollView.frame));
    
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:_backgroungScrollView];
    
    [self initElement];
    
    
}


- (void)initElement{
    
    if (!_elementArray) {//90 173 243
        
        _elementArray = @[@"iconfont-jinrujinjishijianliebiao",@"紧急程度:", @"iconfont-time",@"开始日期:",@"iconfont-banshizhinan",@"结束日期:",@"iconfont-changriqi",@"提醒日期:",@"iconfont-shijian",@"提醒间隔:",@"iconfont-people",@"参与人:"];
    }
    
    for (int i = 0; i < 6; i ++) {
        
        
        
        
        UIView *view = [[UIView alloc]init];
        
        [_backgroungScrollView addSubview:view];
        view.backgroundColor = kBackColor;
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 11 , 18, 18)];
        img.image = [UIImage imageNamed:_elementArray[2 * i]];
        [view addSubview:img];
        
        
        UILabel *titleLabel1 = [[UILabel alloc]init];
        
        titleLabel1.text = _elementArray[i * 2 + 1];
        titleLabel1.font = [UIFont systemFontOfSize:kFont];
        [view addSubview:titleLabel1];
        
        
        view.frame = CGRectMake(0, i * (kHeight + 1), kScreenWidth, kHeight);
        titleLabel1.frame = CGRectMake(38, 10, kLabelWidth, 20);
        
         _lastElementMaxY = CGRectGetMaxY(view.frame);
   
    }
    
    [self addSechduleSubviews];
    
    
    
    
}

- (void)addSechduleSubviews {
    
    _urgentLevelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _urgentLevelBtn.tag = 888 + 0;
    _urgentLevelBtn.backgroundColor = kTestColor;
    [_urgentLevelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_urgentLevelBtn addTarget:self action:@selector(allSechduleClicked:) forControlEvents:UIControlEventTouchUpInside];
    _urgentLevelBtn.frame = CGRectMake(kContentStart, 0, kContentWidth, kHeight);
    _urgentLevelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _urgentLevelBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
    [_backgroungScrollView addSubview:_urgentLevelBtn];
    _urgentLevelBtn.layer.cornerRadius = 4;
    _urgentLevelBtn.layer.masksToBounds = 1;
    

    _startTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _startTimeBtn.tag = 888 + 1;
    _startTimeBtn.backgroundColor = kTestColor;
    [_startTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_startTimeBtn addTarget:self action:@selector(allSechduleClicked:) forControlEvents:UIControlEventTouchUpInside];
    _startTimeBtn.frame = CGRectMake(kContentStart, kHeight + 1, kContentWidth, kHeight);
    _startTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _startTimeBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
    [_backgroungScrollView addSubview:_startTimeBtn];
    _startTimeBtn.layer.cornerRadius = 4;
    _startTimeBtn.layer.masksToBounds = 1;
    
    _endTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _endTimeBtn.tag = 888 + 2;
    _endTimeBtn.backgroundColor = kTestColor;
    [_endTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_endTimeBtn addTarget:self action:@selector(allSechduleClicked:) forControlEvents:UIControlEventTouchUpInside];
    _endTimeBtn.frame = CGRectMake(kContentStart, 2 * (kHeight + 1), kContentWidth, kHeight);
    _endTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _endTimeBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
    [_backgroungScrollView addSubview:_endTimeBtn];
    _endTimeBtn.layer.cornerRadius = 4;
    _endTimeBtn.layer.masksToBounds = 1;
//    _endTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _endTimeBtn.tag = 888 + 2;
//    _endTimeBtn.backgroundColor = kTestColor;
//    [_endTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_endTimeBtn addTarget:self action:@selector(allSechduleClicked:) forControlEvents:UIControlEventTouchUpInside];
//    _endTimeBtn.frame = CGRectMake(kContentStart, 2 * (kHeight + 1), kContentWidth, kHeight);
//    _endTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    _endTimeBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
//    [_backgroungScrollView addSubview:_endTimeBtn];

    
    

    
    
    _remindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _remindBtn.tag = 888 + 3;
    _remindBtn.backgroundColor = kTestColor;
    [_remindBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_remindBtn addTarget:self action:@selector(allSechduleClicked:) forControlEvents:UIControlEventTouchUpInside];
    _remindBtn.frame = CGRectMake(kContentStart, 3 * (kHeight + 1), kContentWidth, kHeight);
    _remindBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _remindBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
    [_backgroungScrollView addSubview:_remindBtn];
    _remindBtn.layer.cornerRadius = 4;
    _remindBtn.layer.masksToBounds = 1;
    
    
    _timeIntervalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _timeIntervalBtn.tag = 888 + 4;
    _timeIntervalBtn.backgroundColor = kTestColor;
    [_timeIntervalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_timeIntervalBtn addTarget:self action:@selector(allSechduleClicked:) forControlEvents:UIControlEventTouchUpInside];
    _timeIntervalBtn.frame = CGRectMake(kContentStart, 4 * (kHeight + 1), kContentWidth, kHeight);
    _timeIntervalBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _timeIntervalBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
    [_backgroungScrollView addSubview:_timeIntervalBtn];
    _timeIntervalBtn.layer.cornerRadius = 4;
    _timeIntervalBtn.layer.masksToBounds = 1;
    
    
    _sendToBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendToBtn.tag = 888 + 5;
    _sendToBtn.backgroundColor = kTestColor;
    [_sendToBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_sendToBtn addTarget:self action:@selector(allSechduleClicked:) forControlEvents:UIControlEventTouchUpInside];
    _sendToBtn.frame = CGRectMake(kContentStart, 5 * (kHeight + 1), kContentWidth, kHeight);
    _sendToBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _sendToBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
    [_backgroungScrollView addSubview:_sendToBtn];
    _sendToBtn.layer.cornerRadius = 4;
    _sendToBtn.layer.masksToBounds = 1;
    
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_sendToBtn.frame), kScreenWidth - 20, 40)];
    tipLabel.text = @"日程内容";
    [_backgroungScrollView addSubview:tipLabel];
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.textColor = [UIColor orangeColor];
    
    
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
    submitBtn.tag = 888 + 6;
    //    [submitBtn setBackgroundImage:[UIImage imageNamed:@"矩形-9"] forState:UIControlStateNormal];
    submitBtn.backgroundColor = kBtnColor;
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(allSechduleClicked:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius = 4;
    submitBtn.layer.masksToBounds = 1;
    submitBtn.frame = CGRectMake(20, CGRectGetMaxY(textBackView.frame) + 15, kScreenWidth - 40, 40);
    [_backgroungScrollView addSubview:submitBtn];
;
    
    [ConfigUITools sizeToScroll:_backgroungScrollView withStandardElementMaxY:CGRectGetMaxY(submitBtn.frame) + 25 forStepsH:0];
    
}



- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
    if (_datePickerView) {
        
        _datePickerView.hidden = 1;
    }
    
}

- (void)allSechduleClicked:(UIButton *)sender {
    
    switch (sender.tag - 888) {
        case 0:
        {
            _btnSelectedStatus = YES;
            [self showSelectedWithTitle:@"选择紧急程度" subTitles:@[@"紧急",@"急",@"一般"]];
            
        }
            break;
        case 1:
        {
            _btnTimeStatus = 1;
            [self meetingDateSelected];
            
        }
            
            break;
        case 2:
        {
              _btnTimeStatus = 2;
            [self meetingDateSelected];
            
        }
            
            
            break;
        case 3:
        {
              _btnTimeStatus = 3;
            [self meetingDateSelected];
            
        }
            
            break;
        case 4:
        {
            _btnSelectedStatus = NO;
            [self showSelectedWithTitle:@"选择提醒间隔" subTitles:@[@"不提醒",@"15分钟",@"30分钟",@"60分钟"]];

//            if ([AppDelegate isNetworkConecting]) {
//                
//                
//                
//                
//            }else {
//                
//                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无网络连接,请检查网络!" message:nil preferredStyle:UIAlertControllerStyleAlert];
//                
//                
//                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                    
//                    
//                    
//                }];
//                
//                [alertController addAction:okAction];
//                
//                [self.navigationController  presentViewController:alertController animated:YES completion:nil];
//                
//            }
            
        }
            
            break;
        case 5:
        {
        
            UserDeptViewController *de = [[UserDeptViewController alloc]init];
            de.isJump = YES;
            de.isBlock = YES;
            de.selectedBlock = ^(NSMutableArray *array){
                NSString *title = @"";
                if (array.count > 0) {
                    NSMutableArray *arr = [[NSMutableArray alloc]init];
                    for (NSDictionary *dict in array) {
                        
                        [arr addObject:[dict objectForKey:@"name"]];
                        
                    }
                    
                    title = [(NSArray *)arr componentsJoinedByString:@"、"];
                }
                
                [_sendToBtn setTitle:title forState:UIControlStateNormal];
                [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:_backgroungScrollView];
                
            };
            [self.navigationController pushViewController:de animated:YES];

        
        }
            
            break;
        case 6:
        {

            
            if ([AppDelegate isNetworkConecting]) {


                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"我要提交了！" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    
                    
                }];
                
                [alertController addAction:okAction];
                
                [self.navigationController  presentViewController:alertController animated:YES completion:nil];


            }else {

                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无网络连接,请检查网络!" message:nil preferredStyle:UIAlertControllerStyleAlert];


                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {



                }];

                [alertController addAction:okAction];
                
                [self.navigationController  presentViewController:alertController animated:YES completion:nil];
                
            }
            
        }

            
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
    
    if (_btnSelectedStatus) {
        
        [_urgentLevelBtn setTitle:btnTitle forState:UIControlStateNormal];
        
    }else {
        
        [_timeIntervalBtn setTitle:btnTitle forState:UIControlStateNormal];
        
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
        [cancelBtn addTarget:self action:@selector(timeSchClicked:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.frame = CGRectMake(1, 0, kScreenWidth / 2 - 1.5, 35);
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_datePickerView addSubview:cancelBtn];
        
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        doneBtn.tag = 11 + 1;
        doneBtn.backgroundColor = [ConfigUITools colorWithR:90 G:173 B:243 A:1];
        [doneBtn addTarget:self action:@selector(timeSchClicked:) forControlEvents:UIControlEventTouchUpInside];
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
    _selectedTimeStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,month,day,hour,minute];
    if (_btnTimeStatus == 1) {
        
        [_startTimeBtn setTitle:_selectedTimeStr forState:UIControlStateNormal];
        
    }else if (_btnTimeStatus == 2){
        
        
        [_endTimeBtn setTitle:_selectedTimeStr forState:UIControlStateNormal];
        
    }else {
        
        [_remindBtn setTitle:_selectedTimeStr forState:UIControlStateNormal];
        
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [_backgroungScrollView endEditing:YES];
}


- (void)timeSchClicked:(UIButton *)sender {
    
    switch (sender.tag - 11) {
        case 0:
        {
            
            _datePickerView.hidden = 1;
            if (_btnTimeStatus == 1) {
                
                [_startTimeBtn setTitle:@"" forState:UIControlStateNormal];
                
            }else if (_btnTimeStatus == 2){
                
                
                [_endTimeBtn setTitle:@"" forState:UIControlStateNormal];
                
            }else {
                
                
                [_remindBtn setTitle:@"" forState:UIControlStateNormal];
                
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

- (void)viewWillDisappear:(BOOL)animated {
    
    [DaiDodgeKeyboard removeRegisterTheViewNeedDodgeKeyboard];
}



@end

//
//  SendNotifiactionViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/21.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "SendNotifiactionViewController.h"
#import "UserDeptViewController.h"
#import "UUDatePicker.h"
#define kHeight 40
#define kFont  15
#define kLabelWidth 75
#define kContentStart 105
#define kContentWidth  [UIScreen mainScreen].bounds.size.width - kContentStart - 10
@interface SendNotifiactionViewController ()<UUDatePickerDelegate,UITextFieldDelegate,UITextViewDelegate>

{
      UITextField *YMDHM;
      UITextField *YMD;
      UITextField *MDHM;
      UITextField *HM;
      UITextField *Max;
      UITextField *Min;
      UITextField *SpecifiedTime;
}
@property (nonatomic, strong) UIScrollView *backgroungScrollView;

@property (nonatomic, strong) NSArray      *elementArray;
@property (nonatomic, strong) UIView       *coverView;
@property (nonatomic, strong) UIView       *topView;

@property (nonatomic, strong) UITextField  *meetingTitleTF;
@property (nonatomic, strong) UIButton     *notiTypeBtn;
@property (nonatomic, strong) UIButton     *sendToBtn;
@property (nonatomic, strong) UUDatePicker *datePicker;
@property (nonatomic, strong) UIButton     *meetingTimeBtn;
@property (nonatomic, strong) UIView       *datePickerView;
@property (nonatomic, strong) UITextField  *meetingAddress;
@property (nonatomic, strong) UITextField  *leaderTF;
@property (nonatomic, strong) UITextView   *contentTView;
@property (nonatomic, strong) UIButton     *receiptTypeBtn;
@property (nonatomic, assign) float         lastElementMaxY;

//@property (nonatomic, strong) UIButton     *submitBtn;


@end

@implementation SendNotifiactionViewController

- (void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:YES];
    if (_backgroungScrollView) {
        
        [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:_backgroungScrollView];
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发通知";

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
        
        _elementArray = @[@"iconfont-biaoti",@"标       题:", @"iconfont-leixing",@"通知类型:",@"iconfont-zhidingfanwei",@"发送范围:",@"iconfont-banshizhinan",@"会议时间:",@"iconfont-18didian",@"会议地点:",@"iconfont-people",@"与会领导:",@"iconfont-zixun(1)",@"内       容:",@"iconfont-leixing(1)",@"回执类型:"];
    }
    
    for (int i = 0; i < 8; i ++) {
        

        
            
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
        
        if (i != 7) {
            
            view.frame = CGRectMake(0, i * (kHeight + 1), kScreenWidth, kHeight);
            titleLabel1.frame = CGRectMake(38, 10, kLabelWidth, 20);
            
            
        }else {
            view.frame = CGRectMake(0, i * (kHeight + 1) + 3.5 * kHeight +2, kScreenWidth, kHeight);
            titleLabel1.frame = CGRectMake(38, 10, kLabelWidth, 20);
            _lastElementMaxY = CGRectGetMaxY(view.frame);
            
        }
        
       
        

    }
    
    [self addNotiSubviews];
    
    


}

- (void)addNotiSubviews {

    
    _meetingTitleTF = [[UITextField alloc]init];
    _meetingTitleTF.backgroundColor = kTestColor;
    _meetingTitleTF.frame = CGRectMake(kContentStart, 0, kContentWidth, kHeight);
    _meetingTitleTF.font = [UIFont systemFontOfSize:kFont];
    _meetingTitleTF.delegate = self;
    _meetingTitleTF.layer.cornerRadius = 4;
    _meetingTitleTF.layer.masksToBounds = 1;
    [_backgroungScrollView addSubview:_meetingTitleTF];

    _notiTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _notiTypeBtn.tag = 888 + 0;
    _notiTypeBtn.backgroundColor = kTestColor;
    [_notiTypeBtn setTitle:@"会议通知" forState:UIControlStateNormal];
    [_notiTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_notiTypeBtn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _notiTypeBtn.frame = CGRectMake(kContentStart, kHeight + 1, kContentWidth, kHeight);
    _notiTypeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _notiTypeBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
    _notiTypeBtn.layer.cornerRadius = 4;
    _notiTypeBtn.layer.masksToBounds = 1;
    [_backgroungScrollView addSubview:_notiTypeBtn];
    
    
    _sendToBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendToBtn.tag = 888 + 1;
    _sendToBtn.backgroundColor = kTestColor;
    [_sendToBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_sendToBtn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _sendToBtn.frame = CGRectMake(kContentStart, 2 * (kHeight + 1), kContentWidth, kHeight);
    _sendToBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _sendToBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
    _sendToBtn.layer.cornerRadius = 4;
    _sendToBtn.layer.masksToBounds = 1;
    [_backgroungScrollView addSubview:_sendToBtn];
    
    
    _meetingTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _meetingTimeBtn.tag = 888 + 2;
    _meetingTimeBtn.backgroundColor = kTestColor;
    [_meetingTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_meetingTimeBtn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _meetingTimeBtn.frame = CGRectMake(kContentStart, 3 * kHeight + 3, kContentWidth, kHeight);
    _meetingTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _meetingTimeBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
    _meetingTimeBtn.layer.cornerRadius = 4;
    _meetingTimeBtn.layer.masksToBounds = 1;
    [_backgroungScrollView addSubview:_meetingTimeBtn];
    
    
    _meetingAddress = [[UITextField alloc]init];
    _meetingAddress.backgroundColor = kTestColor;
    _meetingAddress.frame = CGRectMake(kContentStart, 4 * kHeight+  4, kContentWidth, kHeight);
    _meetingAddress.font = [UIFont systemFontOfSize:kFont];
    _meetingAddress.delegate = self;
    _meetingAddress.layer.cornerRadius = 4;
    _meetingAddress.layer.masksToBounds = 1;
    [_backgroungScrollView addSubview:_meetingAddress];

    
    _leaderTF = [[UITextField alloc]init];
    _leaderTF.backgroundColor = kTestColor;
    _leaderTF.frame = CGRectMake(kContentStart, 5 * kHeight+  5, kContentWidth, kHeight);
    _leaderTF.font = [UIFont systemFontOfSize:kFont];
    _leaderTF.delegate = self;
    _leaderTF.layer.cornerRadius = 4;
    _leaderTF.layer.masksToBounds = 1;
    [_backgroungScrollView addSubview:_leaderTF];
    
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
    
    _receiptTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _receiptTypeBtn.tag = 888 + 3;
    _receiptTypeBtn.selected = NO;
    _receiptTypeBtn.backgroundColor = kTestColor;
    [_receiptTypeBtn setTitle:@"无需回执" forState:UIControlStateNormal];
    [_receiptTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_receiptTypeBtn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _receiptTypeBtn.frame = CGRectMake(kContentStart, 7 * (kHeight + 1) + 3.5 * kHeight +2, kContentWidth, kHeight);
    _receiptTypeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _receiptTypeBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
    _receiptTypeBtn.layer.cornerRadius = 4;
    _receiptTypeBtn.layer.masksToBounds = 1;
    [_backgroungScrollView addSubview:_receiptTypeBtn];
    
    
    
    UIButton  *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.backgroundColor = kTestColor;
    submitBtn.tag = 888 + 4;
//    [submitBtn setBackgroundImage:[UIImage imageNamed:@"矩形-9"] forState:UIControlStateNormal];
    submitBtn.backgroundColor = kBtnColor;
    [submitBtn setTitle:@"提交通知" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius = 4;
    submitBtn.layer.masksToBounds = 1;
    submitBtn.frame = CGRectMake(20, CGRectGetMaxY(_receiptTypeBtn.frame) + 15, kScreenWidth - 40, 40);
    [_backgroungScrollView addSubview:submitBtn];
    
    _lastElementMaxY = CGRectGetMaxY(_receiptTypeBtn.frame);
    NSLog(@"---%f",_lastElementMaxY);
    
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

    switch (sender.tag - 888) {
        case 0:
            
            [self showNotiTypeView];
            
            break;
        case 1:
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

                [_sendToBtn setTitle:title forState:UIControlStateNormal];
                [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:_backgroungScrollView];
            
            };
            [self.navigationController pushViewController:de animated:YES];
            
        }
            
            break;
        case 2:
        {
        
            [self meetingDateSelected];
        
        }
            
            
            break;
        case 3:
        {
        
            sender.selected = !sender.selected;
            if (sender.selected) {
                
                [_receiptTypeBtn setTitle:@"需要回执" forState:UIControlStateNormal];
                
            }else {
            
                [_receiptTypeBtn setTitle:@"无需回执" forState:UIControlStateNormal];
            
            }
        
        }
            
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
        case 5:
            
            
            break;
            
        default:
            break;
    }

}

- (void)showNotiTypeView {


    _coverView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0.7;
    
    // 添加单击手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePopupView:)];
    _coverView.userInteractionEnabled = YES;
    [_coverView addGestureRecognizer:gesture];
    [[UIApplication sharedApplication].keyWindow addSubview:_coverView];
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth / 6, [UIScreen mainScreen].bounds.size.height / 2 - 76.5, kScreenWidth * 2 / 3, 153)];
    _topView.backgroundColor = [UIColor whiteColor];
    _topView.layer.cornerRadius = 4;
    _topView.layer.masksToBounds = 1;

    
    [[UIApplication sharedApplication].keyWindow addSubview:_topView];
    
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 2 / 3, 60)];
    infoLabel.font = [UIFont systemFontOfSize:20];
    infoLabel.textAlignment = 1;
    infoLabel.textColor = [ConfigUITools colorWithR:90 G:173 B:243 A:1];
    infoLabel.text = @"选择类型";
    [_topView addSubview:infoLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth * 2 / 3, 1)];
    line.backgroundColor = [ConfigUITools colorWithR:90 G:173 B:243 A:1];

    [_topView addSubview:line];
    
    
    UIButton *meetingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [meetingBtn setTitle:@"会议通知" forState:UIControlStateNormal];
    [meetingBtn addTarget:self action:@selector(typeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    meetingBtn.frame = CGRectMake(0, 61, kScreenWidth * 2 / 3, 45);
    meetingBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [meetingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_topView addSubview:meetingBtn];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 106, kScreenWidth * 2 / 3, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    
    [_topView addSubview:line1];
    
    
    UIButton *usuralBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [usuralBtn setTitle:@"一般通知" forState:UIControlStateNormal];
    [usuralBtn addTarget:self action:@selector(typeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    usuralBtn.frame = CGRectMake(0, 108, kScreenWidth * 2 / 3, 45);
    usuralBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [usuralBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_topView addSubview:usuralBtn];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 152, kScreenWidth * 2 / 3, 1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    
    [_topView addSubview:line2];
    
    
    
}

- (void)hidePopupView:(UITapGestureRecognizer*)gesture {
    
    [_coverView removeFromSuperview];
    [_topView removeFromSuperview];
}

- (void)typeBtnClicked:(UIButton *)sender {

//    _notiTypeBtn.titleLabel.text = sender.titleLabel.text;
    [_notiTypeBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
    [_coverView removeFromSuperview];
    [_topView removeFromSuperview];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_backgroungScrollView endEditing:YES];

    return 1;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [DaiDodgeKeyboard removeRegisterTheViewNeedDodgeKeyboard];
}

@end

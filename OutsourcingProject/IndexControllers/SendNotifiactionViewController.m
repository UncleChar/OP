//
//  SendNotifiactionViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/21.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "SendNotifiactionViewController.h"
#import "UUDatePicker.h"
#define kHeight 40
@interface SendNotifiactionViewController ()<UUDatePickerDelegate,UITextFieldDelegate>

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

@property (nonatomic, strong) NSArray  *elementArray;
@property (nonatomic, strong) UIView   *coverView;
@property (nonatomic, strong) UIView   *topView;
@property (nonatomic, strong) UIButton  *notiTypeBtn;
@property (nonatomic, strong) UUDatePicker *datePicker;
@property (nonatomic, strong) UIButton  *meetingTimeBtn;
@property (nonatomic, strong) UIView    *datePickerView;
@property (nonatomic, strong) UITextField  *meetingAddress;



@end

@implementation SendNotifiactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发通知";

    _backgroungScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _backgroungScrollView.backgroundColor = kBackColor;
    _backgroungScrollView.userInteractionEnabled = YES;
    [self.view addSubview:_backgroungScrollView];
    [self initElement];
    
    
}


- (void)initElement{

    if (!_elementArray) {//90 173 243
        
        _elementArray = @[@"iconfont-leixing",@"通知类型:",@"iconfont-zhidingfanwei",@"发送范围:",@"iconfont-banshizhinan",@"会议时间:",@"iconfont-18didian",@"会议地点:",@"iconfont-people",@"与会领导:",@"iconfont-zixun(1)",@"内       容:"];
    }
    
    for (int i = 0; i < 6; i ++) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, i * (kHeight + 1), kScreenWidth, kHeight)];
        [_backgroungScrollView addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 11 , 18, 18)];
        img.image = [UIImage imageNamed:_elementArray[2 * i]];
        [view addSubview:img];
        
        UILabel *titleLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(38, 10, 60, 20)];
        titleLabel1.text = _elementArray[i * 2 + 1];
        titleLabel1.font = [UIFont systemFontOfSize:12];
        [view addSubview:titleLabel1];
    }
    
    [self addNotiSubviews];
    
    


}

- (void)addNotiSubviews {


    _notiTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _notiTypeBtn.tag = 888 + 0;
    _notiTypeBtn.backgroundColor = kTestColor;
    [_notiTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_notiTypeBtn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _notiTypeBtn.frame = CGRectMake(95, 0, kScreenWidth - 120, 40);
    _notiTypeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _notiTypeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_backgroungScrollView addSubview:_notiTypeBtn];
    
    
    _meetingTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _meetingTimeBtn.tag = 888 + 2;
    _meetingTimeBtn.backgroundColor = kTestColor;
    [_meetingTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_meetingTimeBtn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _meetingTimeBtn.frame = CGRectMake(95, 2 * kHeight + 2, kScreenWidth - 120, 40);
    _meetingTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _meetingTimeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_backgroungScrollView addSubview:_meetingTimeBtn];
    
    
    _meetingAddress = [[UITextField alloc]init];

    _meetingAddress.backgroundColor = kTestColor;
    _meetingAddress.frame = CGRectMake(95, 3 * kHeight+  3, kScreenWidth - 120, 40);
    _meetingAddress.font = [UIFont systemFontOfSize:12];
    _meetingAddress.delegate = self;
    [_backgroungScrollView addSubview:_meetingAddress];
    

    


}

//- (UIScrollView *)backgScrollView {
//    
//    _backgroungScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    _backgroungScrollView.backgroundColor = [UIColor redColor];
////    _backgroungScrollView.contentSize = CGSizeMake(0, 0);
//    
//    return _backgroungScrollView;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [_backgroungScrollView endEditing:YES];
    return 1;

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
            
            
            break;
        case 2:
        {
        
            [self meetingDateSelected];
        
        }
            
            
            break;
        case 3:
            
            
            break;
        case 4:
            
            
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
//     [_backgroungScrollView addSubview:_datePickerView];
   

    
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

@end

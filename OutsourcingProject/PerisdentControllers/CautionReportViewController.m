//
//  CautionReportViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/3/11.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "CautionReportViewController.h"
#define kHeight 40
#define kFont  15
#define kLabelWidth 75
#define kContentStart 105
#define kContentWidth  [UIScreen mainScreen].bounds.size.width - kContentStart - 10
@interface CautionReportViewController ()
@property (nonatomic, strong) UIScrollView *backgroungScrollView;

@property (nonatomic, strong) NSArray      *elementArray;
@property (nonatomic, strong) UIView       *coverView;
@property (nonatomic, strong) UIView       *topView;

@property (nonatomic, strong) UITextField  *cautionTitleTF;
@property (nonatomic, strong) UIButton     *notiTypeBtn;

@property (nonatomic, strong) UITextField  *companyNameTF;
@property (nonatomic, strong) UITextField  *eventAddressTF;

@property (nonatomic, strong) UITextView   *contentTView;
@property (nonatomic, assign) float         lastElementMaxY;
@end

@implementation CautionReportViewController

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
        
        _elementArray = @[@"警示标题:",@"警示类型:", @"涉嫌公司名称:",@"时间地址:"];
    }
    
    for (int i = 0; i < 4; i ++) {
        
        
        
        
        UIView *view = [[UIView alloc]init];
        view.frame = CGRectMake(0,  i * (kHeight + 1) , kScreenWidth, kHeight);
        [_backgroungScrollView addSubview:view];
        view.backgroundColor = kBackColor;
        
        UILabel *titleLabel1 = [[UILabel alloc]init];
        
        titleLabel1.text = _elementArray[i];
        titleLabel1.frame = CGRectMake(10, 0, kLabelWidth + 30, 40);
        titleLabel1.font = [UIFont systemFontOfSize:kFont];
        titleLabel1.font = OPFont(14);
        [view addSubview:titleLabel1];
        
        [_backgroungScrollView addSubview:view];
        if (i == 3) {
           
            _lastElementMaxY = CGRectGetMaxY(view.frame);
            
        }
        
    }
    
    [self addCouationSubviews];
    
}

- (void)addCouationSubviews {
    
    
    _cautionTitleTF = [[UITextField alloc]init];
    _cautionTitleTF.backgroundColor = kTestColor;
    _cautionTitleTF.frame = CGRectMake(kContentStart, 0, kContentWidth, kHeight);
    _cautionTitleTF.font = [UIFont systemFontOfSize:kFont];
    _cautionTitleTF.layer.cornerRadius = 4;
    _cautionTitleTF.layer.masksToBounds = 1;
    [_backgroungScrollView addSubview:_cautionTitleTF];
    
    _notiTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _notiTypeBtn.tag = 678 + 0;
    _notiTypeBtn.backgroundColor = kTestColor;
    [_notiTypeBtn setTitle:@"一般类型" forState:UIControlStateNormal];
    [_notiTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_notiTypeBtn addTarget:self action:@selector(cautionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _notiTypeBtn.frame = CGRectMake(kContentStart, kHeight + 1, kContentWidth, kHeight);
    _notiTypeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _notiTypeBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
    _notiTypeBtn.layer.cornerRadius = 4;
    _notiTypeBtn.layer.masksToBounds = 1;
    [_backgroungScrollView addSubview:_notiTypeBtn];
    
    
    _companyNameTF = [[UITextField alloc]init];
    _companyNameTF.backgroundColor = kTestColor;
    _companyNameTF.frame = CGRectMake(kContentStart, 2 * (kHeight + 1), kContentWidth, kHeight);
    _companyNameTF.font = [UIFont systemFontOfSize:kFont];
    _companyNameTF.layer.cornerRadius = 4;
    _companyNameTF.layer.masksToBounds = 1;
    [_backgroungScrollView addSubview:_companyNameTF];
    
    
    
    _eventAddressTF = [[UITextField alloc]init];
    _eventAddressTF.backgroundColor = kTestColor;
    _eventAddressTF.frame = CGRectMake(kContentStart, 3 * kHeight + 3, kContentWidth, kHeight);
    _eventAddressTF.font = [UIFont systemFontOfSize:kFont];
    _eventAddressTF.layer.cornerRadius = 4;
    _eventAddressTF.layer.masksToBounds = 1;
    [_backgroungScrollView addSubview:_eventAddressTF];
    
    
    
    
//    _sendToBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _sendToBtn.tag = 888 + 1;
//    _sendToBtn.backgroundColor = kTestColor;
//    [_sendToBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_sendToBtn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    _sendToBtn.frame = CGRectMake(kContentStart, 2 * (kHeight + 1), kContentWidth, kHeight);
//    _sendToBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    _sendToBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
//    _sendToBtn.layer.cornerRadius = 4;
//    _sendToBtn.layer.masksToBounds = 1;
//    [_backgroungScrollView addSubview:_sendToBtn];
//    
//    
//    _meetingTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _meetingTimeBtn.tag = 888 + 2;
//    _meetingTimeBtn.backgroundColor = kTestColor;
//    [_meetingTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_meetingTimeBtn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    _meetingTimeBtn.frame = CGRectMake(kContentStart, 3 * kHeight + 3, kContentWidth, kHeight);
//    _meetingTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    _meetingTimeBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
//    _meetingTimeBtn.layer.cornerRadius = 4;
//    _meetingTimeBtn.layer.masksToBounds = 1;
//    [_backgroungScrollView addSubview:_meetingTimeBtn];
//    
//    
//    _meetingAddress = [[UITextField alloc]init];
//    _meetingAddress.backgroundColor = kTestColor;
//    _meetingAddress.frame = CGRectMake(kContentStart, 4 * kHeight+  4, kContentWidth, kHeight);
//    _meetingAddress.font = [UIFont systemFontOfSize:kFont];
//    _meetingAddress.delegate = self;
//    _meetingAddress.layer.cornerRadius = 4;
//    _meetingAddress.layer.masksToBounds = 1;
//    [_backgroungScrollView addSubview:_meetingAddress];
//    
//    
//    _leaderTF = [[UITextField alloc]init];
//    _leaderTF.backgroundColor = kTestColor;
//    _leaderTF.frame = CGRectMake(kContentStart, 5 * kHeight+  5, kContentWidth, kHeight);
//    _leaderTF.font = [UIFont systemFontOfSize:kFont];
//    _leaderTF.delegate = self;
//    _leaderTF.layer.cornerRadius = 4;
//    _leaderTF.layer.masksToBounds = 1;
//    [_backgroungScrollView addSubview:_leaderTF];
//    
//    UIView *textBackView = [[UIView alloc]initWithFrame:CGRectMake(10, 7 * kHeight+  7, kScreenWidth - 20, 3.5 * kHeight)];
//    textBackView.backgroundColor = [UIColor blackColor];
//    textBackView.layer.cornerRadius = 4;
//    textBackView.layer.masksToBounds = 1;
//    
//    [_backgroungScrollView addSubview:textBackView];
//    
//    
//    _contentTView = [[UITextView alloc]init];
//    //    _contentTView.backgroundColor = kTestColor;
//    _contentTView.frame = CGRectMake(1, 1, kScreenWidth - 22, CGRectGetHeight(textBackView.frame) - 2);
//    _contentTView.font = [UIFont systemFontOfSize:kFont];
//    _contentTView.delegate = self;
//    _contentTView.layer.cornerRadius = 4;
//    _contentTView.layer.masksToBounds = 1;
//    [textBackView addSubview:_contentTView];
//    
//    _receiptTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _receiptTypeBtn.tag = 888 + 3;
//    _receiptTypeBtn.selected = NO;
//    _receiptTypeBtn.backgroundColor = kTestColor;
//    [_receiptTypeBtn setTitle:@"无需回执" forState:UIControlStateNormal];
//    [_receiptTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_receiptTypeBtn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    _receiptTypeBtn.frame = CGRectMake(kContentStart, 7 * (kHeight + 1) + 3.5 * kHeight +2, kContentWidth, kHeight);
//    _receiptTypeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    _receiptTypeBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
//    _receiptTypeBtn.layer.cornerRadius = 4;
//    _receiptTypeBtn.layer.masksToBounds = 1;
//    [_backgroungScrollView addSubview:_receiptTypeBtn];
//    
    
    
    UIButton  *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.backgroundColor = kTestColor;
    submitBtn.tag = 678 + 2;
    //    [submitBtn setBackgroundImage:[UIImage imageNamed:@"矩形-9"] forState:UIControlStateNormal];
    submitBtn.backgroundColor = kBtnColor;
    [submitBtn setTitle:@"提交通知" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(cautionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius = 4;
    submitBtn.layer.masksToBounds = 1;
    submitBtn.frame = CGRectMake(20, 400 + 15, kScreenWidth - 40, 40);
    [_backgroungScrollView addSubview:submitBtn];

    
    _lastElementMaxY = CGRectGetMaxY(submitBtn.frame);
    NSLog(@"---dd%f",_lastElementMaxY);
    
    [ConfigUITools sizeToScroll:_backgroungScrollView withStandardElementMaxY:_lastElementMaxY + 25 forStepsH:0];
    
}

- (void)cautionBtnClicked:(UIButton *)sender {

    switch (sender.tag - 678) {
        case 0:
            
            [self showSelectedWithTitle:@"选择类型" subTitles:@[@"一般类型",@"其他类型"]];
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
        case 3:
            
            btnTitle = sender.titleLabel.text;
            
            break;
            
        default:
            break;
    }
    
    
    
    
}


@end

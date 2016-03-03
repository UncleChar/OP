//
//  ForgetPwdViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/3/2.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "AuthcodeView.h"

#define   WIN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define   WIN_HEIGHT [[UIScreen mainScreen] bounds].size.height
// 登录界面颜色
#define   COLOR_LOGIN_VIEW [UIColor colorWithRed:0 green:114/255.0 blue:183/255.0 alpha:1]
// 注册界面颜色
#define   COLOR_ZC_VIEW [UIColor colorWithRed:0 green:114/255.0 blue:183/255.0 alpha:1]
// 注释的颜色
#define COLOR_BLUE_LOGIN [UIColor colorWithRed:78/255.0 green:198/255.0 blue:56/255.0 alpha:1];
#define SET_PLACE(text) [text  setValue:[UIFont boldSystemFontOfSize:(13)] forKeyPath:@"_placeholderLabel.font"];
#define   FONT(size)  ([UIFont systemFontOfSize:size])

@interface ForgetPwdViewController ()<UITextFieldDelegate, UIAlertViewDelegate>
{


    UITextField  *numberTF;
    UITextField  *verifyTF;
    UITextField  *picVerifyTF;
    
    double _minHeight;
    UIButton *hqBtn;           //获取验证码按钮
    UIButton *nextBtn;        //下一步按钮
    BOOL _isTime;
    NSTimer *_timer;
    int timecount;
    UITextField *accText;     //手机号输入框
    UITextField *captchaText; //验证码输入框
    
    AuthcodeView *authCodeView;
    UITextField *_input;

}
@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView  *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line1];
    
    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 12, 140, 40)];
    numberLabel.text = @"输入您的手机号码:";
//    numberLabel.textAlignment = 2;
    numberLabel.font = OPFont(15);
    [self.view addSubview:numberLabel];
    
    numberTF = [[UITextField alloc]initWithFrame:CGRectMake(150, 12, kScreenWidth - 160, 40)];
    [self.view addSubview:numberTF];
    numberTF.keyboardType= UIKeyboardTypeNumberPad;
    numberTF.borderStyle = UITextBorderStyleRoundedRect;
    
    
    UIView  *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 53, kScreenWidth, 1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line2];
    
    
//    UILabel *picLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 55, kScreenWidth / 3, 40)];
//    picLabel.text = @"输入验证码:";
////    picLabel.textAlignment = 2;
//    picLabel.font = OPFont(15);
//    [self.view addSubview:picLabel];
    
//    picVerifyTF = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth /3 + 5, 55, kScreenWidth / 3 - 10, 40)];
//    [self.view addSubview:picVerifyTF];
//    picVerifyTF.borderStyle = UITextBorderStyleRoundedRect;
//    
    
        _input = [[UITextField alloc] initWithFrame:CGRectMake(5, 55, kScreenWidth / 2 - 7.5, 40)];
//        _input.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        _input.layer.borderWidth = 2.0;
//        _input.layer.cornerRadius = 5.0;
//        _input.font = [UIFont systemFontOfSize:21];
        _input.placeholder = @"请输入验证码";
//        _input.clearButtonMode = UITextFieldViewModeWhileEditing;
//        _input.backgroundColor = [UIColor clearColor];
//        _input.textAlignment = NSTextAlignmentCenter;
        _input.returnKeyType = UIReturnKeyDone;
        _input.delegate = self;
        _input.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:_input];
    
    
    
    authCodeView = [[AuthcodeView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 + 2.5, 55, kScreenWidth / 2 - 7.5, 40)];
    [self.view addSubview:authCodeView];
    
    
    UIView  *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, 96, kScreenWidth, 1)];
    line3.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line3];
    
    
    // 验证码
    captchaText = [[UITextField alloc] initWithFrame:CGRectMake(5, 98, kScreenWidth / 2 - 7.5, 40)];
    [self.view addSubview:captchaText];
    captchaText.placeholder = @"请输入验证码";
    captchaText.keyboardType= UIKeyboardTypeNumberPad;
//    SET_PLACE(captchaText);
//    captchaText.tag = 201;
    captchaText.borderStyle = UITextBorderStyleRoundedRect;

    
    hqBtn = [UIButton buttonWithType:0];
    hqBtn.frame = CGRectMake(WIN_WIDTH / 2 + 2.5, 98, kScreenWidth / 2 - 7.5, 40);
    [hqBtn setTitle:@"获取验证码" forState:0];
    hqBtn.backgroundColor = COLOR_BLUE_LOGIN;
    [self.view addSubview:hqBtn];
    hqBtn.clipsToBounds = YES;
    hqBtn.layer.cornerRadius = 5.0f;
    [hqBtn addTarget:self action:@selector(hqBtnClick) forControlEvents:7];
    hqBtn.titleLabel.font = FONT(13);
    
    

    
    UIView  *line5 = [[UIView alloc]initWithFrame:CGRectMake(0, 139, kScreenWidth, 1)];
    line5.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line5];
    
    
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    exitBtn.frame = CGRectMake(20, 160, (kScreenWidth - 40) , 40);
    //    [exitBtn setBackgroundImage:[UIImage imageNamed:@"矩形-9"] forState:UIControlStateNormal];
    exitBtn.backgroundColor = kBtnColor;
    [exitBtn addTarget:self action:@selector(nextBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [exitBtn setTitle:@"下一步" forState:UIControlStateNormal];
    exitBtn.layer.cornerRadius = 4;
    exitBtn.layer.masksToBounds = 1;
    [self.view addSubview:exitBtn];
    
    
    [self configAuthCoe];
    
    // Do any additional setup after loading the view.
}


- (void)configAuthCoe {


    //显示验证码界面
//    authCodeView = [[AuthcodeView alloc] initWithFrame:CGRectMake(30, 200, self.view.frame.size.width-60, 40)];
//    [self.view addSubview:authCodeView];
    
//    //提示文字
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 260, self.view.frame.size.width-100, 40)];
//    label.text = @"点击图片换验证码";
//    label.font = [UIFont systemFontOfSize:12];
//    label.textColor = [UIColor grayColor];
//    [self.view addSubview:label];
//    
    //添加输入框
//    _input = [[UITextField alloc] initWithFrame:CGRectMake(30, 320, self.view.frame.size.width-60, 40)];
//    _input.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    _input.layer.borderWidth = 2.0;
//    _input.layer.cornerRadius = 5.0;
//    _input.font = [UIFont systemFontOfSize:21];
//    _input.placeholder = @"请输入验证码!";
//    _input.clearButtonMode = UITextFieldViewModeWhileEditing;
//    _input.backgroundColor = [UIColor clearColor];
//    _input.textAlignment = NSTextAlignmentCenter;
//    _input.returnKeyType = UIReturnKeyDone;
//    _input.delegate = self;
//    [self.view addSubview:_input];

}
//手机号正则验证
#pragma mark - 手机号正则验证
- (BOOL)checkTel:(NSString *)str
{
    if ([str length] == 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"号码不能为空" message:NSLocalizedString(@"tel_no_null", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        return NO;
        
    }
    //^(86)?0?1\\d{10}$
    //^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$    18226615044
    NSString *regex = @"^(86)?0?1\\d{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        accText.text = @"";
        [alert show];
        return NO;
        
    }
    
    return YES;
}
#pragma mark - 获取验证码按钮并倒计时60'
- (void)hqBtnClick
{
    
    if ([self checkTel:numberTF.text]) {
        
//        _phoneNumber = accText.text;
        timecount = 60;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
        
        [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(time) userInfo:nil repeats:NO];
        hqBtn.backgroundColor = [UIColor grayColor];
        hqBtn.userInteractionEnabled = NO;
        _isTime = YES;
        
        [NSTimer scheduledTimerWithTimeInterval:5*60.0 target:self selector:@selector(endTime) userInfo:nil repeats:NO];
//        [self sendSMSNoVerificationRequest];
        
    }
}

- (void)timerFired
{
        [hqBtn setTitle:[NSString stringWithFormat:@"(%ds)重新获取",timecount--] forState:0];
        if (timecount==1||timecount<1) {
    
            [_timer invalidate];
            [hqBtn setTitle:@"获取验证码" forState:0];
    
        }
}
- (void)time
{
    hqBtn.backgroundColor = COLOR_BLUE_LOGIN;
    hqBtn.userInteractionEnabled = YES;
}
- (void)endTime
{
    _isTime = NO;
}

#pragma mark 输入框代理，点击return 按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //判断输入的是否为验证图片中显示的验证码
    if ([_input.text isEqualToString:authCodeView.authCodeStr])
    {
        //正确弹出警告款提示正确
        UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"恭喜您 ^o^" message:@"验证成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alview show];
        
    }
    else
    {
        //验证不匹配，验证码和输入框抖动
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20,@20,@-20];
        //        [authCodeView.layer addAnimation:anim forKey:nil];
        [_input.layer addAnimation:anim forKey:nil];
    }
    
    return YES;
}

#pragma mark 警告框中方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //清空输入框内容，收回键盘
    if (buttonIndex==0)
    {
//        _input.text = @"";
        [_input resignFirstResponder];
    }
}

- (void)nextBtnClicked {

    

}
@end

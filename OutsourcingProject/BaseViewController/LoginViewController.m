//
//  LoginViewController.m
//  UncleCharDemos
//
//  Created by LingLi on 16/1/7.
//  Copyright © 2016年 hailong.xie. All rights reserved.
//

#import "LoginViewController.h"
#import "MainTabBarController.h"
#import <UIKit/UIKit.h>

#define kPadding  [UIScreen mainScreen].bounds.size.width / 5 
@interface LoginViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

{
    
    UITextField         *_accountTF;
    NSArray             *_usersArray;
    UITableView         *_showHistoryTableView;
    NSMutableArray      *_transferArray;
    NSString            *_userInputAccount;
    BOOL                 _isAleradySelected;
    NSInteger            _lengthOfHistory;
}

@property (nonatomic, strong) UITextField  *userAccount;
@property (nonatomic, strong) UITextField  *userPassword;
//@property (nonatomic, strong) UITextField  *userPhone;
//@property (nonatomic, strong) UITextField  *userEmail;

@property (nonatomic, strong) UITextField  *firstResponderTF;
@property (nonatomic, strong) UIButton     *loginBtn;
@property (nonatomic, strong) UIButton     *resetBtn;
@property (nonatomic, strong) UIView       *baseView;

@property (nonatomic, strong) UIImageView    *loginHeadImg;
@property (nonatomic, strong) UIView         *lineAccount;
@property (nonatomic, strong) UIView         *linePassword;

@property (nonatomic, strong) UILabel       *label;

@property (nonatomic, assign) CGFloat       btnMaxY;


@end

@implementation LoginViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = 1;
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    self.view.backgroundColor = [ConfigUITools colorWithR:209 G:34 B:52 A:1];

    [self configLoginVCUI];
    
  
}


- (void)configLoginVCUI {
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    _baseView = [[UIView alloc]initWithFrame:self.view.frame];
    _baseView.alpha = 1;
    _baseView.backgroundColor = [ConfigUITools colorWithR:209 G:34 B:52 A:1];
    [self.view addSubview:_baseView];

    _loginHeadImg = [[UIImageView alloc]init];
    _loginHeadImg.frame = CGRectMake(kPadding * 2, kPadding, kPadding, kPadding * 125 / 135);
    _loginHeadImg.image = [UIImage imageNamed:@"图层-2"];

    
    _label = [[UILabel alloc]init];
    _label.text = @"浦东新区工会通";
    _label.font = [UIFont boldSystemFontOfSize:17];
    _label.textAlignment = 1;
    _label.textColor = [UIColor whiteColor];
    _label.frame = CGRectMake(10 , CGRectGetMaxY(_loginHeadImg.frame) + 10, kScreenWidth - 20, 30);
   

    
    _userAccount = [[UITextField alloc]init];
    _userAccount.placeholder = @"  请输入工会会员号";
    _userAccount.delegate = self;
    _userAccount.textColor = [UIColor whiteColor];
    _userAccount.backgroundColor = [ConfigUITools colorWithR:209 G:34 B:52 A:1];
    _userAccount.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userAccount.frame = CGRectMake(kScreenWidth / 6, CGRectGetMaxY(_label.frame) + kPadding, kScreenWidth * 4 / 6, 35);
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user"]];
    imgView.frame = CGRectMake(2, 7.5, 20 * 32 / 38, 20);
    _userAccount.leftView = imgView;
    _userAccount.leftViewMode = UITextFieldViewModeAlways;


    _lineAccount = [[UIView alloc]init];
    _lineAccount.frame = CGRectMake(kScreenWidth / 6, CGRectGetMaxY(_userAccount.frame) - 1, kScreenWidth * 4 / 6, 1);
    _lineAccount.backgroundColor = [UIColor whiteColor];
    _lineAccount.alpha = 0.6;
    
    
    _userPassword = [[UITextField alloc]init];
    _userPassword.placeholder = @"  请输入密码 ";
    _userPassword.delegate = self;
    _userPassword.textColor = [UIColor whiteColor];
    _userPassword.backgroundColor = [ConfigUITools colorWithR:209 G:34 B:52 A:1];
    _userPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userPassword.frame = CGRectMake(kScreenWidth / 6, CGRectGetMaxY(_userAccount.frame) + 10, kScreenWidth * 4 / 6, 35);
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"locked"]];
    imgView1.frame = CGRectMake(2, 7.5, 20 * 32 / 38, 20);
    _userPassword.leftView = imgView1;
    _userPassword.leftViewMode = UITextFieldViewModeAlways;
   
    
    
    _linePassword = [[UIView alloc]init];
    _linePassword.frame = CGRectMake(kScreenWidth / 6, CGRectGetMaxY(_userPassword.frame) - 1, kScreenWidth * 4 / 6, 1);
    _linePassword.backgroundColor = [UIColor whiteColor];
     _linePassword.alpha = 0.6;

    
        _loginBtn = [[UIButton alloc]init];
    _loginBtn.frame = CGRectMake(kScreenWidth / 6, CGRectGetMaxY(_linePassword.frame) + 20, kScreenWidth * 4 / 6, 35);
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
     [_loginBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形-4"] forState:UIControlStateNormal];
        _loginBtn.tag = 100 + 1;
    
    
    
    
    
    _resetBtn = [[UIButton alloc]init];
    _resetBtn.frame = CGRectMake(kScreenWidth / 6, CGRectGetMaxY(_loginBtn.frame) + 20, kScreenWidth / 4, 35);
    [_resetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    _resetBtn.alpha = 0.6;
    _resetBtn.tag = 100 + 2;
    
 
    
    UIImageView *bottomImg = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth / 6, kScreenHeight * 0.9 , 35, 35 * 69 / 75)];
    bottomImg.image = [UIImage imageNamed:@"图层-30-拷贝"];
    
    
    UILabel *bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bottomImg.frame) + 5, kScreenHeight * 0.9 + 2.5 , kScreenWidth * 5 / 6 - CGRectGetMaxX(bottomImg.frame) - 5  , 30)];
    bottomLabel.text = @"上海市浦东区新区总工会";
    bottomLabel.font = [UIFont boldSystemFontOfSize:14];
    bottomLabel.textColor = [ConfigUITools colorWithR:228 G:172 B:23 A:1];
    bottomLabel.textAlignment = 1;

    [_baseView addSubview:_loginHeadImg];
    [_baseView addSubview:_label];
    [_baseView addSubview:_userAccount];
    [_baseView addSubview:_lineAccount];
    [_baseView addSubview:_userPassword];
    [_baseView addSubview:_linePassword];

    [_baseView addSubview:_loginBtn];
    [_baseView addSubview:_resetBtn];
    
    [_baseView addSubview:bottomImg];
    [_baseView addSubview:bottomLabel];

    
            [_loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
            [_resetBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
////        __weak typeof(self) weakSelf = self;
//    int padding = 20;
////    *5 / 7
//    [_loginHeadImg mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.centerX.mas_equalTo(_baseView.mas_centerX);
//        make.left.equalTo(_baseView.mas_left).with.offset(2 * kPadding);
//        make.right.equalTo(_baseView.mas_right).with.offset(- 2 * kPadding);
//        make.bottom.equalTo(_label.mas_top).with.offset(- padding / 2);
//        make.top.equalTo(_baseView.mas_top).with.offset(kPadding);
//        make.height.mas_equalTo(@(kPadding * 125 / 135));
//        make.width.mas_equalTo(@(kPadding));
//    
//        
//    }];
// 
//    
//    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(_baseView.mas_centerX);
//        make.left.equalTo(_loginHeadImg.mas_left).with.offset(-2 *padding);
//        make.right.equalTo(_loginHeadImg.mas_right).with.offset(2 *padding);
//        make.bottom.equalTo(_userAccount.mas_top).with.offset(- 1.5 * padding);
//        make.top.equalTo(_loginHeadImg.mas_bottom).with.offset(padding);
//        make.height.mas_equalTo(@30);
//    }];
//    
//    [_userAccount mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(_baseView.mas_centerX);
//        make.left.equalTo(_baseView.mas_left).with.offset(padding);
//        make.right.equalTo(_baseView.mas_right).with.offset(-padding);
//        make.bottom.equalTo(_userPassword.mas_top).with.offset(- 1.5 * padding);
//        make.top.equalTo(_loginHeadImg.mas_bottom).with.offset(padding);
//        make.height.mas_equalTo(@40);
//        make.width.equalTo(_userPassword);
//    }];
//    
//    [_lineAccount mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(_baseView.mas_centerX);
//        make.left.equalTo(_baseView.mas_left).with.offset(padding);
//        make.right.equalTo(_baseView.mas_right).with.offset(-padding);
//        make.top.equalTo(_userAccount.mas_bottom).with.offset(-2);
//        make.height.mas_equalTo(@2);
//        make.width.equalTo(_userAccount);
//    }];
//
//    
//    [_userPassword mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(_baseView.mas_centerX);
//        make.left.equalTo(_baseView.mas_left).with.offset(padding);
//        make.right.equalTo(_baseView.mas_right).with.offset(-padding);
//        make.top.equalTo(_userAccount.mas_bottom).with.offset(1.5 * padding);
//        make.height.mas_equalTo(@40);
//        make.width.equalTo(_loginBtn);
//    }];
//    
//    [_linePassword mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(_baseView.mas_centerX);
//        make.left.equalTo(_baseView.mas_left).with.offset(padding);
//        make.right.equalTo(_baseView.mas_right).with.offset(-padding);
//        make.top.equalTo(_userPassword.mas_bottom).with.offset(-2);
//        make.height.mas_equalTo(@2);
//        make.width.equalTo(_userPassword);
//    }];
//
//    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(_baseView.mas_centerX);
//        make.left.equalTo(_baseView.mas_left).with.offset(padding);
//        make.right.equalTo(_baseView.mas_right).with.offset(-padding);
//        make.top.equalTo(_userPassword.mas_bottom).with.offset(1.5 * padding);
//        make.height.mas_equalTo(@40);
//        make.width.equalTo(_userAccount);
//        
//    }];
//    
//
//    
    
//    _accountTF = [[UITextField alloc]init];
//    _accountTF.frame = CGRectMake(CGRectGetMinX(_userAccount.frame), CGRectGetMaxY(_userAccount.frame), _userAccount.frame.size.width, 30);
//    _accountTF.borderStyle = UITextBorderStyleRoundedRect;
//    _accountTF.delegate = self;
//    [self.view addSubview:_accountTF];
    
//    [UIView animateWithDuration:2.0 animations:^{
//        
//        _baseView.alpha = 1.0;
//        
//    } completion:^(BOOL finished) {
//        
////                [_loginHeadGif startGIF];
//        [_registerBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [_loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        
//    }];
  
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {

    
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    
    return YES;
   
}










- (void)contactBackBtn {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)loginBtnClicked:(UIButton *)sender {

    switch (sender.tag - 100) {
        case 0:
            
            
            break;
        case 1:
        {
            [self.view endEditing:YES];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
            [SVProgressHUD showWithStatus:@"Logging..."];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               
                
                [NSThread sleepForTimeInterval:2];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
//                    [AppDelegate getAppDelegate].window.rootViewController = [[MainTabBarController alloc]init];

                    
                    if ([_userAccount.text isEqualToString:@"tflb"] && [_userPassword.text isEqualToString:@"123456"]) {
                        
                        [SVProgressHUD showSuccessWithStatus:@"Success"];
                        
                        [AppDelegate getAppDelegate].window.rootViewController = [[MainTabBarController alloc]init];
                        
                        NSUserDefaults *store = [NSUserDefaults standardUserDefaults];
                        [store setBool:YES forKey:kUserLoginStatus];
                        [store synchronize];
 
                    }else {
                    
                        [SVProgressHUD showErrorWithStatus:@"Account or password error"];

                    }
                    
                });
            });
            
        }
            break;
            
        default:
            break;
    }
    
}
#pragma mark - keyboard events

///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    
        _btnMaxY = CGRectGetMaxY(_loginBtn.frame);

    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSLog(@"login %f",kbHeight);
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if(_btnMaxY >(self.view.frame.size.height - kbHeight)) {
        
        [UIView animateWithDuration:duration + 0.3 animations:^{
            
            _baseView.frame = CGRectMake(_baseView.frame.origin.x,-( _btnMaxY - (self.view.frame.size.height - kbHeight) + 10), _baseView.frame.size.width, _baseView.frame.size.height);
            
        }];
    }
    //注明：这里不需要移除通知
}

- (void) keyboardWillHide:(NSNotification *)notify {
    
    _showHistoryTableView.hidden = YES;
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration + 0.3 animations:^{
        _baseView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}
//- (void)viewWillDisappear:(BOOL)animated {
//
//    [_loginHeadGif removeFromSuperview];
//    _loginHeadGif = nil;
////    [self.view removeFromSuperview];
////    self.view = nil;
//}

@end

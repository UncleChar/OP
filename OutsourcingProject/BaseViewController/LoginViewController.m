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

@property (nonatomic, strong) UIScrollView *inScrollerView;

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
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(messageVC)];
//    leftItem.image = [UIImage imageNamed:@"qq@3x"];
//    self.navigationItem.leftBarButtonItem = leftItem;
//    
//    self.navigationItem.title = @"Chat with me";
//    
//    UIImageView *leftRefresh = [[UIImageView alloc]initWithFrame:CGRectMake(55, 25, 34, 34)];
//    
//    leftRefresh.image = [UIImage imageNamed:@"basevc_refresh@2x"];
//    [self.navigationController.view addSubview:leftRefresh];

    [self configLoginVCUI];
    
  
}


- (void)configLoginVCUI {

    
    NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
    // 取出当前应用版本号
    NSString *currentVersion = [infoDict objectForKey:(NSString *)kCFBundleVersionKey];
    // 取出沙盒存储的应用版本号
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
    if (![currentVersion isEqualToString:saveVersion]) {
        // 如果是第一次进入新版本,进入介绍页面
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"version"];
        [self goIntroduceView];
    } else { 
        [self loginAction];
    }
 
}

- (void)goIntroduceView {

    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < 4; i ++) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        iv.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i.jpg", i + 1]];
        [scrollView addSubview:iv];
        
        if (3 == i) { // 创建进入应用按钮
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - 150) / 2, kScreenHeight - 60, 150, 40)];
            btn.backgroundColor = [ConfigUITools colorWithR:197 G:37 B:45 A:1];
            btn.layer.cornerRadius = 4;
            btn.layer.masksToBounds = 1;
            [btn setTitle:@"进入应用" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
            iv.userInteractionEnabled = YES;
            [iv addSubview:btn];
        }
    }
    
    scrollView.contentSize = CGSizeMake(kScreenWidth * 4, 0);
    [self.view addSubview:scrollView];
    _inScrollerView = scrollView;


}

- (void)loginAction {


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
    [_loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _loginBtn.tag = 100 + 1;
    
    
    
    
    
    _resetBtn = [[UIButton alloc]init];
    _resetBtn.frame = CGRectMake(kScreenWidth / 6, CGRectGetMaxY(_loginBtn.frame) + 20, kScreenWidth / 3, 35);
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
                
                NSString *requestBody = [NSString stringWithFormat:
                                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                                         "<soap12:Envelope "
                                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                                         "<soap12:Body>"
                                         "<CheckUserLogin xmlns=\"Net.GongHuiTong\">"
                                         "<username>%@</username>"
                                         "<userpass>%@</userpass>"
                                         "</CheckUserLogin>"
                                         "</soap12:Body>"
                                         "</soap12:Envelope>",_userAccount.text,_userPassword.text];
                ReturnValueBlock returnBlock = ^(id resultValue){
                    
                    NSLog(@"------%@----------",[[resultValue lastObject] objectForKey:@"CheckUserLoginResult"]);
                    
                    NSError *error;
                    NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"CheckUserLoginResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
                    
                    NSLog(@"------%@----------",[listDic objectForKey:@"rows"]);
                    Users *userModel = [[Users alloc]init];
                    for (NSDictionary *dict in [listDic objectForKey:@"rows"]) {
                       
                        [userModel setValuesForKeysWithDictionary:dict];
                        
                    }
                    
                    
                    NSLog(@"%@,444 %@",userModel.deptname,userModel.xingbie);
  
                    [[AppEngine GetAppEngine] saveUserLoginInfo:(NSMutableDictionary *)[listDic objectForKey:@"rows"][0]];
                    
                    
                      NSLog(@"%@,555 %@",[AppEngine GetAppEngine].owner.deptname,[AppEngine GetAppEngine].owner.xingbie);
                };
                [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"CheckUserLoginResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];

            
            
            
            
            
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
-(void) saveUserLoginInfo:(NSDictionary*) userDict
{
    Users *_owner = [[Users alloc]init];
    _owner.addr = [userDict objectForKey:@"addr"];
    _owner.deptcode = [userDict objectForKey:@"deptcode"];
    _owner.deptname = [userDict objectForKey:@"deptname"];
    _owner.email = [userDict objectForKey:@"email"];
    _owner.iconpic = [userDict objectForKey:@"iconpic"];
    _owner.logincookie = [userDict objectForKey:@"logincookie"];
    _owner.shengri = [userDict objectForKey:@"shengri"];
    _owner.shouji = [userDict objectForKey:@"shouji"];
    _owner.usercode = [userDict objectForKey:@"usercode"];
    _owner.usertype = [userDict objectForKey:@"usertype"];
    _owner.xingbie = [userDict objectForKey:@"xingbie"];
    _owner.xingming = [userDict objectForKey:@"xingming"];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:_owner.addr forKey:@"addr"];
    [defaults setObject:_owner.deptcode forKey:@"deptcode"];
    [defaults setObject:_owner.deptname forKey:@"deptname"];
    [defaults setObject:_owner.email forKey:@"email"];
    [defaults setObject:_owner.iconpic forKey:@"iconpic"];
    [defaults setObject:_owner.logincookie forKey:@"logincookie"];
    [defaults setObject:_owner.shengri forKey:@"shengri"];
    [defaults setObject:_owner.usercode forKey:@"usercode"];
    [defaults setObject:_owner.usertype forKey:@"usertype"];
    [defaults setObject:_owner.xingbie forKey:@"xingbie"];
    [defaults setObject:_owner.xingming forKey:@"xingming"];
    
    [defaults synchronize];//同步写入到文件
}


@end

//
//  ForgetPwdViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/3/2.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "ForgetPwdViewController.h"

@interface ForgetPwdViewController ()
{


    UITextField  *numberTF;
    UITextField  *verifyTF;
    UITextField  *picVerifyTF;

}
@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    
    
    UIView  *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line1];
    
    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 12, kScreenWidth / 2, 40)];
    numberLabel.text = @"输入您的手机号码:";
    [self.view addSubview:numberLabel];
    
    numberTF = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth / 2 + 5, 12, kScreenWidth /  2 - 20, 40)];
    [self.view addSubview:numberTF];
    
    
    UIView  *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 53, kScreenWidth, 1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line2];
    
    
    UILabel *picLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 55, kScreenWidth / 3, 40)];
    picLabel.text = @"输入验证码:";
    [self.view addSubview:picLabel];
    
    picVerifyTF = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth /3 + 5, 55, kScreenWidth / 3 - 20, 40)];
    [self.view addSubview:picVerifyTF];
    
    
    UIView  *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, 96, kScreenWidth, 1)];
    line3.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line3];
    
    
    
//    
//    UIView  *line4 = [[UIView alloc]initWithFrame:CGRectMake(0, 107, kScreenWidth, 1)];
//    line4.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:line4];
    
    
    
    //    UILabel *picLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 52, kScreenWidth / 4, 40)];
    //    picLabel.text = @"输入验证码:";
    //    [self.view addSubview:picLabel];
    
    verifyTF = [[UITextField alloc]initWithFrame:CGRectMake(5, 98, kScreenWidth / 3 * 2, 40)];
    [self.view addSubview:verifyTF];

    
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
    
    // Do any additional setup after loading the view.
}



- (void)nextBtnClicked {

    

}
@end

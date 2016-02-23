//
//  SetEmailViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/21.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "SetEmailViewController.h"

@interface SetEmailViewController ()
@property (nonatomic, strong) UITextField   *emailTF;
@end

@implementation SetEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改邮箱";
    _emailTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 40)];
    _emailTF.text = [NSString stringWithFormat:@"  %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"email"]];
    [self.view addSubview:_emailTF];
    _emailTF.backgroundColor = [UIColor whiteColor];
    
        UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        saveBtn.frame = CGRectMake(30, CGRectGetMaxY(_emailTF.frame) + 20, (kScreenWidth - 60) , 40);
//        [saveBtn setBackgroundImage:[UIImage imageNamed:@"矩形-9"] forState:UIControlStateNormal];
    saveBtn.backgroundColor = kBtnColor;
        [saveBtn addTarget:self action:@selector(saveBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [self.view addSubview:saveBtn];

}

- (void)saveBtnClicked:(UIButton *)sender {

    [self.navigationController  popViewControllerAnimated:YES];
    NSUserDefaults *store = [NSUserDefaults standardUserDefaults];
    [store setValue:_emailTF.text forKey:@"email"];

    [store synchronize];

}


@end

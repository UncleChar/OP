//
//  SetPasswordViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/20.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "SetPasswordViewController.h"

@interface SetPasswordViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView  *setPasswordTableView;
@property (nonatomic, strong) NSArray  *picsArray;
@property (nonatomic, strong) NSArray  *titlesArray;
@property (nonatomic, strong) NSMutableArray *tfArray;
@property (nonatomic, strong) UITextField  *oldpwTF;
@property (nonatomic, strong) UITextField  *newpwTF;
@property (nonatomic, strong) UITextField  *defpwTF;

@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackColor;
    [self initArray];
    [self.view addSubview:[self tableView]];
    
//
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(setpwVCBack)];
//        leftItem.image = [UIImage imageNamed:@"backk"];
//        self.navigationItem.leftBarButtonItem = leftItem;
    
        self.title = @"修改密码";

 
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(20, CGRectGetMaxY(_setPasswordTableView.frame) + 30, kScreenWidth - 40, 40);
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"矩形-9"] forState:UIControlStateNormal];
    [submitBtn setTitle:@"提交新密码" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    // Do any additional setup after loading the view.
}

- (void)initArray {

    if (!_picsArray) {
        
        _picsArray = @[@"iconfont-mimasuo",@"iconfont-mima",@"iconfont-mima"];
    }
    
    if (!_titlesArray) {
        
        _titlesArray = @[@"旧 密 码 :",@"新 密 码 :",@"确认密码:"];
    }
    if (!_tfArray) {
        
        _tfArray = [NSMutableArray arrayWithCapacity:0];
        
//        _oldpwTF = [UITextField alloc]initWithFrame:<#(CGRect)#>
        
    }
    
}

-(UITableView*)tableView
{
    if (!_setPasswordTableView) {
        _setPasswordTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth, 150) style:UITableViewStylePlain];
        
        _setPasswordTableView.delegate=self;
        _setPasswordTableView.dataSource=self;
        _setPasswordTableView.scrollEnabled = NO;
        
    }
    return _setPasswordTableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.imageView.image = [UIImage imageNamed:_picsArray[indexPath.row]];
        cell.textLabel.text = _titlesArray[indexPath.row];
        UITextField *input = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 30, 2, kScreenWidth / 2 + 20 , 40)];
        input.tag = indexPath.row;
        input.secureTextEntry = YES;
    
    [_tfArray addObject:input];
        [cell addSubview:input];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    UserInfoViewController  *use = [[UserInfoViewController alloc]init];
    //    [self.navigationController pushViewController:use animated:YES];
//    NSLog(@"dd%d",indexPath.row);
//    if (indexPath.row == 8) {
//        
//        [self.navigationController pushViewController:[[SetPasswordViewController alloc]init] animated:YES];
//        
//    }
    
}

- (void)submitBtnClicked:(UIButton *)sender {


    for (UITextField *input in _tfArray) {
        
        
        NSLog(@"input:%@",input.text);
    }
    
    
}

//- (void)setpwVCBack {
//
//    [self.navigationController popViewControllerAnimated:YES];
//}
@end

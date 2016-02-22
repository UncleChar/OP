//
//  SystemSettingViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/19.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "SystemSettingViewController.h"

@interface SystemSettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView  *setTableView;

@end

@implementation SystemSettingViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = 0;
    self.title = @"系统设置";
//    //    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
//    //    {
//            self.navigationController.navigationBar.translucent = NO;
//    //    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBackColor;
        [self.view addSubview:[self tableView]];
    
//    UIView
    
    
    
    
    
//    UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(50, 100, 20, 10)];
//    [switchButton setOn:YES];
//    [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:switchButton];
    
    // Do any additional setup after loading the view.
}

-(UITableView*)tableView
{
    
        _setTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth, 90) style:UITableViewStylePlain];
        
        _setTableView.delegate=self;
        _setTableView.dataSource=self;
    _setTableView.backgroundColor = [UIColor redColor];
        _setTableView.scrollEnabled = NO;
    
    return _setTableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell1";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"iconfont-tongzhia"];
        cell.textLabel.text = @"通知中心提示消息";
            UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth - 60, 9, 20, 15)];
            [switchButton setOn:YES];
            [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        switchButton.tag = 1010;
            [cell addSubview:switchButton];
        
        
        
    }else {
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.image = [UIImage imageNamed:@"iconfont-gengxinzhuanhuan1"];
        cell.textLabel.text = @"自动检查版本更新";
        
        UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth - 60, 9, 20, 15)];
        [switchButton setOn:YES];
        switchButton.tag = 1011;
        [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:switchButton];
    
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    UserInfoViewController  *use = [[UserInfoViewController alloc]init];
    //    [self.navigationController pushViewController:use animated:YES];
    
    //        if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    //        {
    //            self.navigationController.navigationBar.translucent = YES;
    //        }
//    [self.navigationController pushViewController:_controllersArray[indexPath.row] animated:YES];
    
}




-(void)switchAction:(UISwitch*)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    switch (sender.tag) {
        case 1010:
            if (isButtonOn) {
                NSLog(@"sheeei");
            }else {
                NSLog(@"foeeeeeu") ;
            }
            
            break;
        case 1011:
            
            if (isButtonOn) {
                NSLog(@"shi");
            }else {
                NSLog(@"fou") ;
            }
            break;
            
        default:
            break;
    }


}
@end
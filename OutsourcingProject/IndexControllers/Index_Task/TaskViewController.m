//
//  TaskViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/2/23.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "TaskViewController.h"
#import "AddTaskViewController.h"

@interface TaskViewController ()<HorizontalMenuDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView    *taskTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) HorizontalMenu *menu;//

//@property (nonatomic, strong) UIView         *organizeStructureView;
//@property (nonatomic, strong) UIView         *customStructureView;


@end

@implementation TaskViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"工作任务";
    _menu  = [[HorizontalMenu alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45) withTitles:@[@"我收到的任务", @"我发出的任务",@"结束的任务"]];
    _menu.delegate = self;
    [self.view addSubview:_menu];

    if (!_dataArray) {
        
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        
    }

    [self.view addSubview:[self taskTableView]];
    
    [self configAddBtn];


//    [self requestForUserDept];


}


- (UITableView *)taskTableView{
    
    if (!_taskTableView) {
        
        _taskTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, kScreenHeight - 45 - 64 - 50)];
        _taskTableView.backgroundColor = kBackColor;
        _taskTableView.dataSource = self;
        _taskTableView.delegate = self;
        [self.view addSubview:_taskTableView];
        
    }
    
    _taskTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
        for (int i = 0; i < 4; i ++) {
            
            //            [_userChatArrary addObject:MessaageVCRandomData];
            
        }
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            [NSThread sleepForTimeInterval:5];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                
                [_taskTableView.mj_header endRefreshing];
                [_taskTableView reloadData];
                
            });
        });
    }];
    
    
    return _taskTableView;
    
}

- (void)configAddBtn {
    
    UIButton  *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.backgroundColor = kTestColor;
    submitBtn.tag = 888 + 4;
//    [submitBtn setBackgroundImage:[UIImage imageNamed:@"矩形-9"] forState:UIControlStateNormal];
    submitBtn.backgroundColor = kBtnColor;
    [submitBtn setTitle:@"新建任务" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(addTaskBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius = 4;
    submitBtn.layer.masksToBounds = 1;
    submitBtn.frame = CGRectMake(20, CGRectGetMaxY(_taskTableView.frame) + 5, kScreenWidth - 40, 40);
    [self.view addSubview:submitBtn];
    
    OPLog(@" %f",CGRectGetMaxY(_taskTableView.frame));
    
    OPLog(@"v %f",CGRectGetMinY(submitBtn.frame));
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

    return 7;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
            static NSString *cellID = @"cell";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (nil == cell) {
                
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
            }
            
            //    cell.imageView.image = [UIImage imageNamed:@"icon"];
            cell.textLabel.text = @"我是测试cell行";

            cell.imageView.image = [UIImage imageNamed:@"iconfont-893renwumiaoshu-拷贝（合并）-拷贝-2"];
            //        cell.textLabel.text = _cellTitleArray[indexPath.row]
            
            
            cell.detailTextLabel.text  = @"李达      未读        2016 - 2 - 24";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
            cell.detailTextLabel.textColor = [UIColor lightGrayColor];

            
            
            
            return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}










#pragma mark - HorizontalMenuDelegate

- (void)clieckButton:(UIButton *)button
{
    OPLog(@"%@", button.titleLabel.text);
    
    switch (button.tag) {
        case 0:

            [self requestWithParameter:nil];

            break;
        case 1:
            
            [self requestWithParameter:nil];
            
            break;
            
        case 2:
            
            [self requestWithParameter:nil];
            
            break;
            
        default:
            break;
    }
    
    
}


- (void)requestWithParameter:(NSDictionary *)parameterDict {
    
    
    if ([AppDelegate isNetworkConecting]) {
        
        NSString * requestBody = [NSString stringWithFormat:
                                  @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                                  "<soap12:Envelope "
                                  "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                                  "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                                  "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                                  "<soap12:Body>"
                                  "<GetTreeUserSysDept xmlns=\"Net.GongHuiTong\">"
                                  "<logincookie>%@</logincookie>"
                                  "<checktype>%@</checktype>"
                                  " </GetTreeUserSysDept>"
                                  "</soap12:Body>"
                                  "</soap12:Envelope>",[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],@"checkbox"];
        
        ReturnValueBlock returnBlock = ^(id resultValue){
            
            //ui需要回到主线程！！！！！
            dispatch_async(dispatch_get_main_queue(), ^{
                
                OPLog(@"000:%@",[[resultValue lastObject] objectForKey:@"GetTreeUserSysDeptResult"]);
                OPLog(@"0class0:%@",[[[resultValue lastObject] objectForKey:@"GetTreeUserSysDeptResult"] class]);
                
                if ([[[resultValue lastObject] objectForKey:@"GetTreeUserSysDeptResult"] isEqualToString:@"用户未登录！"]) {
   
    
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"用户未登录,请重新登录" message:@"是否重新登录 " preferredStyle:UIAlertControllerStyleAlert];
    
                            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    
                                [self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
    
                            }];
    
                            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
    
                            }];
    
                            [alertController addAction:cancelAction];
                            [alertController addAction:okAction];

                            [self.navigationController presentViewController:alertController animated:YES completion:nil];
   
                }else if([NSNull null] ==[[resultValue lastObject] objectForKey:@"GetTreeUserSysDeptResult"]) {

                    OPLog(@"----error---%@---",[NSNull null]);
                    
                }else {
                    
                    NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetTreeUserSysDeptResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                    
                    OPLog(@"%@",listDic);
                    
                }
                
                
            });
            
        };
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"GetTreeUserSysDeptResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];
        
    }else {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无网络连接,请检查网络!" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        
        [alertController addAction:okAction];
        [self.navigationController  presentViewController:alertController animated:YES completion:nil];
        
    }
    
}



- (void)addTaskBtnClicked:(UIButton *)sender {

    [self.navigationController pushViewController:[[AddTaskViewController alloc]init] animated:YES];
    
    
}

@end

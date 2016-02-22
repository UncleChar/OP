//
//  UserDeptViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/2/22.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "UserDeptViewController.h"
#define kNamePlistPath2 [NSHomeDirectory() stringByAppendingString:@"/Documents/name1.plist"]

@interface UserDeptViewController ()<HorizontalMenuDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UITableView    *showTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView         *topSearchView;
@property (nonatomic, strong) UITextField    *meetingSearchTF;      //
@property (nonatomic, strong) UITextField    *activeSearchTF;      //
@property (nonatomic, strong) UITextField    *otherSearchTF;
@property (nonatomic, strong) HorizontalMenu *menu;//


@end

@implementation UserDeptViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editBtnClicked)];
//    leftItem.image = [UIImage imageNamed:@"backk"];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _menu  = [[HorizontalMenu alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30) withTitles:@[@"组织结构", @"自定义组"]];
    _menu.delegate = self;
    [self.view addSubview:_menu];

    [self requestForUserDept];
    
    
    
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    
    
}

- (void)requestForUserDept {
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {

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
            NSLog(@"000:%@",[[resultValue lastObject] objectForKey:@"GetTreeUserSysDeptResult"]);
            if ([NSNull null] ==[[resultValue lastObject] objectForKey:@"GetTreeUserSysDeptResult"]) {
                
                //                dispatch_async(dispatch_get_main_queue(), ^{
                
                
                //                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Account or password error!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                //                            [alert show];
                
                NSLog(@"rrrrrrrrrrrrrerror: account or password error !");
                //                    [SVProgressHUD showErrorWithStatus:@"Account or password error!"];
                //
                //                });
                
            }else {
                
                NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetTreeUserSysDeptResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                
//                NSLog(@"%@",listDic);
                
           
                BOOL isSuccess = [listDic writeToFile:@"/Users/lingli/Desktop/name.plist" atomically:YES];
                isSuccess ? NSLog(@"写入成功"):NSLog(@"写入失败");
                
                ///--------------------------------------------------------------------------
                //    由于ios应用是独立的，所以每个应用都有一个独立的沙盒（sandbox），不允许其他应用程序访问的
                //    我们自己创建的临时文件如果要放到沙盒，一般放到documents文件夹下面
                //    获取沙盒目录
                //    1.获取document路径
                NSString *documentPath =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSLog(@"documentPath:%@",documentPath);
                NSString *namePlistPath = [documentPath stringByAppendingString:@"/name.plist"];
                //[documentPath stringByAppendingPathComponent:@"name.plist"];
                BOOL b = [listDic writeToFile:namePlistPath atomically:YES];
                b ? NSLog(@"写入沙盒成功"):NSLog(@"写入沙盒失败");
                
                
                //2.获取沙盒目录
                //先获取到家目录。然后再拼接一个documents
                NSString *homePath = NSHomeDirectory();
                NSString *namePlitPath2 = [homePath stringByAppendingString:@"/Documents/name1.plist"];
                BOOL b1 = [listDic writeToFile:namePlitPath2 atomically:YES];
                b1 ? NSLog(@"方式二写入沙盒成功"):NSLog(@"方式二写入沙盒失败");
                
                NSArray *arr = [NSArray arrayWithContentsOfFile:[NSHomeDirectory() stringByAppendingString:@"/Documents/name1.plist"]];
                NSLog(@"arr%@",arr);
                NSLog(@"%@",kNamePlistPath2);
    
            }
            
        };
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"GetTreeUserSysDeptResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];
        
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
}

- (void)editBtnClicked {

//    [self.navigationController pushViewController:[[SendNotifiactionViewController alloc]init] animated:YES];

}

@end

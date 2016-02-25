//
//  UserDeptViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/2/22.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "UserDeptViewController.h"
#import "AddGroupsViewController.h"
#import "UserDetailInfoViewController.h"
#import "MKSelectArray.h"
#import "MKTreeView.h"
#define kPlistPath [NSHomeDirectory() stringByAppendingString:@"/Documents/usersTree.plist"]

@interface UserDeptViewController ()<HorizontalMenuDelegate,UITextFieldDelegate,TreeDelegate>
@property (nonatomic, strong) UITableView    *showTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView         *topSearchView;
@property (nonatomic, strong) UITextField    *meetingSearchTF;      //
@property (nonatomic, strong) UITextField    *activeSearchTF;      //
@property (nonatomic, strong) UITextField    *otherSearchTF;
@property (nonatomic, strong) HorizontalMenu *menu;//

@property (nonatomic, strong) UIView         *organizeStructureView;
@property (nonatomic, strong) UIView         *customStructureView;


@end

@implementation UserDeptViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通讯录";
    _menu  = [[HorizontalMenu alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45) withTitles:@[@"组织结构", @"自定义组"]];
    _menu.delegate = self;
    [self.view addSubview:_menu];
    
    [[[MKSelectArray sharedInstance] initObject].selectArray removeAllObjects];

    if (!_dataArray) {
        
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    
    [self configUIWith:self.isJump];
    
    [self requestForUserDept];
    
  
}

- (void)configUIWith:(BOOL)isJump {

 
    
    if (!self.isJump) {
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editBtnClicked)];
        self.navigationItem.rightBarButtonItem = rightItem;
        
        [self initViewsWithHeight:kScreenHeight - 110];
        
        
    }else {
        
        [self initViewsWithHeight:kScreenHeight - 110 - 50];
        
        UIButton *blockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [blockBtn addTarget:self action:@selector(blockBtn) forControlEvents:UIControlEventTouchUpInside];
        blockBtn.frame = CGRectMake(30, CGRectGetMaxY(_organizeStructureView.frame) + 5 , kScreenWidth - 60, 40);
//        [blockBtn setBackgroundImage:[UIImage imageNamed:@"矩形-9"] forState:UIControlStateNormal];
        blockBtn.backgroundColor = kBtnColor;
        [blockBtn setTitle:@"选择" forState:UIControlStateNormal];
        blockBtn.layer.cornerRadius = 4;
        blockBtn.layer.masksToBounds = 1;
        [self.view addSubview:blockBtn];
        
        
    }






}

- (void)initViewsWithHeight:(CGFloat)height {

    if (!_organizeStructureView) {
        
        _organizeStructureView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, height)];
        _organizeStructureView.backgroundColor = kBackColor;
        [self.view addSubview:_organizeStructureView];
        
    }
    
    
}

- (void)initSubViews{





}

- (void)requestForUserDept {
    
    
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

                    
                    
                    NSFileManager *file =  [NSFileManager defaultManager];
                    
                    if ([file fileExistsAtPath:kPlistPath]) {
                        
                        
                    }else {
                    
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"用户未登录,请重新登录" message:@"是否重新登录 " preferredStyle:UIAlertControllerStyleAlert];
                        
                        
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            
                            [self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
                            
                        }];
                        
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                            
                            
                            
                        }];
                        
                        [alertController addAction:cancelAction];
                        [alertController addAction:okAction];
                        
                        [self.navigationController presentViewController:alertController animated:YES completion:nil];
                    
                    }
                    
    
                }
                
                
                
                
                if ([NSNull null] ==[[resultValue lastObject] objectForKey:@"GetTreeUserSysDeptResult"]) {
                    
                    //                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    //                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Account or password error!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    //                            [alert show];
                    
                    OPLog(@"rrrrrrrrrrrrrerror: account or password error !");
                    //                    [SVProgressHUD showErrorWithStatus:@"Account or password error!"];
                    //
                    //                });
                    
                }else {
                    
                    NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetTreeUserSysDeptResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                    
                    //                OPLog(@"%@",listDic);
                    
                    //先获取到家目录。然后再拼接一个documents
                    NSString *homePath = NSHomeDirectory();
                    NSString *namePlitPath2 = [homePath stringByAppendingString:@"/Documents/usersTree.plist"];
                    BOOL b1 = [listDic writeToFile:namePlitPath2 atomically:YES];
                    b1 ? OPLog(@"写入沙盒成功"):OPLog(@"写入沙盒失败");
                    
                    OPLog(@"%@",kPlistPath);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        NSArray *dataArray = [[NSArray alloc] initWithContentsOfFile:kPlistPath];
                        //    OPLog(@"rrr %@",dataArray);
                        //frame 尺寸 dataArray 数据源 haveHiddenSelectBtn 是否隐藏选择按钮 haveHeadView 是否有head isEqualX每个cell的x是否相等
                        MKTreeView *view = [[MKTreeView instanceView] initTreeWithFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(_organizeStructureView.frame) + 45) dataArray:dataArray haveHiddenSelectBtn:NO haveHeadView:NO isEqualX:NO];
                        view.delegate = self;
                        [_organizeStructureView addSubview:view];
                    });
                    
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

#pragma mark - HorizontalMenuDelegate

- (void)clieckButton:(UIButton *)button
{
    OPLog(@"%ld", button.tag);
    
    switch (button.tag) {
        case 0:
            
        {
            if (_organizeStructureView) {
                
                _organizeStructureView.hidden = NO;
            }
            
            if (_customStructureView) {
                
                _customStructureView.hidden = YES;
            }
        
        
        }
            
            break;
        case 1:
            
            if (_organizeStructureView ) {
               
                _organizeStructureView.hidden = YES;
            }
            if (!_customStructureView) {
                
                _customStructureView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, kScreenHeight - 160)];
                _customStructureView.backgroundColor = kBackColor;
                [self.view addSubview:_customStructureView];
             
                
            }else {
            
                _customStructureView.hidden = NO;
            
            
            }
            
            [AppEngineManager showTipsWithTitle:@"暂无数据"];
            
            break;

            
        default:
            break;
    }
    
    
}


- (void)itemSelectInfo:(MKPeopleCellModel *)item
{
    OPLog(@"--%@",item.userID);
    UserDetailInfoViewController *userDetailVC = [[UserDetailInfoViewController alloc]init];
    userDetailVC.userName = item.name;
//    userDetailVC.userDept = item.
    [self.navigationController pushViewController:userDetailVC animated:YES];
}

- (void)blockBtn {

    _selectedBlock([[MKSelectArray sharedInstance] initObject].selectArray);
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)editBtnClicked {

    [self.navigationController pushViewController:[[AddGroupsViewController alloc]init] animated:YES];

}
- (void)backBack {

    if (_isBlock) {
       
        _selectedBlock([[MKSelectArray sharedInstance] initObject].selectArray);
        
    }

    [self.navigationController popViewControllerAnimated:YES];
    

}

@end

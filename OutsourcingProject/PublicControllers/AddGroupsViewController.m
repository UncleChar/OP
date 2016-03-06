//
//  AddGroupsViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/22.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "AddGroupsViewController.h"
#import "UserDeptViewController.h"
#define kHeight 40
#define kFont  14
@interface AddGroupsViewController ()<UITextFieldDelegate>
{
    
    ReturnValueBlock returnBlock;
}
@property (nonatomic, strong) NSArray  *elementArray;

@property (nonatomic, strong) UITextField  *groupNamesTF;
@property (nonatomic, strong) UITextField  *remarkTF;
@property (nonatomic, strong) UIButton  *usersSelectedBtn;

@end

@implementation AddGroupsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增分组";

    [self initElement];
    
    
}


- (void)initElement{
    
    if (!_elementArray) {//90 173 243
        
        _elementArray = @[@"iconfont-banshizhinan",@"组名:    ",@"iconfont-mingcheng（合并）",@"备注:    ",@"iconfont-people",@"选择人员:"];
    }
    
    for (int i = 0; i < 3; i ++) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, i * (kHeight + 1), kScreenWidth, kHeight)];
        [self.view addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 11 , 18, 18)];
        img.image = [UIImage imageNamed:_elementArray[2 * i]];
        [view addSubview:img];
        
        
        UILabel *titleLabel1 = [[UILabel alloc]init];
        if (i == 2) {
            titleLabel1.frame = CGRectMake(38, 0, 80, kHeight);
        }else {
        
          titleLabel1.frame = CGRectMake(38, 0, 60, kHeight);
        }
       
        titleLabel1.text = _elementArray[i * 2 + 1];
        titleLabel1.font = [UIFont systemFontOfSize:kFont];
        [view addSubview:titleLabel1];
    }
    
        UIButton  *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.backgroundColor = kTestColor;
        submitBtn.tag = 333 + 1;
//        [submitBtn setBackgroundImage:[UIImage imageNamed:@"矩形-9"] forState:UIControlStateNormal];

        submitBtn.backgroundColor = kBtnColor;
        [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        submitBtn.layer.cornerRadius = 4;
        submitBtn.layer.masksToBounds = 1;
        submitBtn.frame = CGRectMake(20, 140, kScreenWidth - 40, 40);
//        submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        submitBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:submitBtn];
    
    [self addSubviews];
    
    
    
    
}

- (void)addSubviews {
    
    
    _groupNamesTF = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, kScreenWidth - 120, kHeight)];
    [self.view addSubview:_groupNamesTF];
    
    _remarkTF = [[UITextField alloc]initWithFrame:CGRectMake(100, 1 * kHeight + 1, kScreenWidth - 120, kHeight)];
    [self.view addSubview:_remarkTF];
    

   
    _usersSelectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _usersSelectedBtn.backgroundColor = kTestColor;
    _usersSelectedBtn.tag = 333 + 0;
    [_usersSelectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_usersSelectedBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _usersSelectedBtn.frame = CGRectMake(100, 2 * kHeight + 2, kScreenWidth - 120, 40);
    _usersSelectedBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _usersSelectedBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_usersSelectedBtn];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    

    return 1;
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {

    
}







- (void)btnClicked:(UIButton *)sender {
    
    switch (sender.tag - 333) {
        case 0:
        {
           
            UserDeptViewController *userDep = [[UserDeptViewController alloc]init];
            userDep.isJump = YES;
            userDep.isBlock = YES;
            userDep.selectedBlock = ^(NSMutableArray *array){
                
                OPLog(@"block %@",array);
                
                NSString *title = @"";
                if (array.count > 0) {
                    NSMutableArray *arr = [[NSMutableArray alloc]init];
                    for (NSDictionary *dict in array) {

                        [arr addObject:[dict objectForKey:@"name"]];
                         
                        
                    }
                    
                    title = [(NSArray *)arr componentsJoinedByString:@"、"];
                }

               
                
                [_usersSelectedBtn setTitle:title forState:UIControlStateNormal];
                
            };
            
            [self.navigationController pushViewController:userDep animated:YES];
            
            
        }
            
            break;
            
        case 1:
        {
            
//            _submitBtnBlock( YES);
//            [self.navigationController popViewControllerAnimated:YES];

        
         
             NSDictionary *keyAndValues = @{@"logincookie":[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],@"datatype":@"tongxunlufenzu"};
             NSLog(@"%@",[JHXMLParser generateXMLString:keyAndValues hostName:@"Net.GongHuiTong" startElementKey:@"AddAppInfo" xmlInfo:YES resouresInfo:@{@"DataType":@"通讯录",@"MemberCode":@"0",@"RealName":@"破破破",@"Phone":@"233423422323",@"Content":@"测试",@"Topic":@"垃圾"} fileNames:@[@"1",@"2  "] fileExtNames:@[@".jpg",@".jpg"] fileDesc:@[@"ceshi1",@"ceshi2"] fileData:@[@"adadadda",@"sdfddssfsddsffsf"]]);

            
            
            [self handleRequsetDate];
            [self submitAddUserWithType:@"tongxunlufenzu" xmlString:@""];

        }
            break;
            
        default:
            break;
    }
    
}


- (void)handleRequsetDate {
    
    __weak typeof(self) weakSelf = self;
    returnBlock = ^(id resultValue){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            OPLog(@"-FF-%@",[[resultValue lastObject] objectForKey:@"AddAppInfoResult"]);
            OPLog(@"-show-%@",[[[resultValue lastObject] objectForKey:@"AddAppInfoResult"] class]);
            if ([NSNull null] ==[[resultValue lastObject] objectForKey:@"AddAppInfoResult"]) {
                
            
                
                [SVProgressHUD showErrorWithStatus:@"没有更多的数据哦"];
                
            }else {
                
                
                
                NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"AddAppInfoResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                
                OPLog(@"----far--%@----------",[listDic objectForKey:@"rows"]);
                
            }
        });
        
        
    };
    
}


- (void)submitAddUserWithType:(NSString *)type xmlString:(NSString *)xmlString
{
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        //        [SVProgressHUD showWithStatus:@"增在加载..."];
        NSString * requestBody = [NSString stringWithFormat:
                                  @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                                  "<soap12:Envelope "
                                  "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                                  "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                                  "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                                  "<soap12:Body>"
                                  "<AddAppInfo xmlns=\"Net.GongHuiTong\">"
                                  "<logincookie>%@</logincookie>"
                                  "<datatype>%@</datatype>"
                                  "<xmlinfo>%@</xmlinfo>"
                                  " </AddAppInfo>"
                                  "</soap12:Body>"
                                  "</soap12:Envelope>",[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],type,xmlString];
        
        
        
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"AddAppInfoResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];
        
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    
    
}




@end


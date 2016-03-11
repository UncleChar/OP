//
//  AddActivityViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/3/1.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "AddActivityViewController.h"
#import "UserDeptViewController.h"




#define kHeight 40
#define kFont  15
#define kLabelWidth 75
#define kContentStart 105
#define kContentWidth  [UIScreen mainScreen].bounds.size.width - kContentStart - 10

@interface AddActivityViewController ()<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, strong) UIScrollView *backgroungScrollView;

@property (nonatomic, strong) UITextField  *taskTitleTF;
@property (nonatomic, strong) UIButton     *receivedBtn;

@property (nonatomic, strong) UIButton     *startTimeBtn;
@property (nonatomic, strong) UIButton     *endTimeBtn;
@property (nonatomic, strong) UITextView   *taskContentTView;
@property (nonatomic, strong) UIButton     *cancelBtn;
@property (nonatomic, strong) UIButton     *saveBtn;
@property (nonatomic, strong) UIView       *datePickerView;
@property (nonatomic, assign) NSInteger     tagBtn;


@end
@implementation AddActivityViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建动态";
    
    _backgroungScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _backgroungScrollView.backgroundColor = kBackColor;
    _backgroungScrollView.userInteractionEnabled = YES;
    [self.view addSubview:_backgroungScrollView];
    
    
    NSLog(@"ddffd%@",NSStringFromCGRect(_backgroungScrollView.frame));
    
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:_backgroungScrollView];
    
    [self initElement];
    
    
}


- (void)initElement{
    
    
    NSArray *arr = @[@"iconfont-banshizhinan.png",@"标题:",@"iconfont-people",@"接收人:"];
    
    for (int i = 0; i < 2; i ++) {
        
        
        
        
        UIView *view = [[UIView alloc]init];
        
        [_backgroungScrollView addSubview:view];
        view.backgroundColor = kBackColor;
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 11 , 18, 18)];
        img.image = [UIImage imageNamed:arr[2 * i]];
        [view addSubview:img];
        
        
        UILabel *titleLabel1 = [[UILabel alloc]init];
        
        titleLabel1.text = arr[i * 2 + 1];
        titleLabel1.font = [UIFont systemFontOfSize:kFont];
        [view addSubview:titleLabel1];
        
        view.frame = CGRectMake(0, i * (kHeight + 1), kScreenWidth, kHeight);
        titleLabel1.frame = CGRectMake(38, 10, kLabelWidth, 20);
        
    }
    

    _taskTitleTF = [[UITextField alloc]init];
    _taskTitleTF.layer.cornerRadius = 4;
    _taskTitleTF.layer.masksToBounds = 1;
    _taskTitleTF.delegate = self;
    _taskTitleTF.backgroundColor = kTestColor;
    _taskTitleTF.frame = CGRectMake(kContentStart, 1, kContentWidth, kHeight);
    [_backgroungScrollView addSubview:_taskTitleTF];
    _taskTitleTF.font = [UIFont systemFontOfSize:kFont];
    
    
    _receivedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _receivedBtn.tag = 777 + 0;
    _receivedBtn.backgroundColor = kTestColor;
    _receivedBtn.layer.cornerRadius = 4;
    _receivedBtn.layer.masksToBounds = 1;
    [_receivedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_receivedBtn addTarget:self action:@selector(consultBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _receivedBtn.frame = CGRectMake(kContentStart,  (kHeight + 1) + 1, kContentWidth, kHeight);
    _receivedBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _receivedBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
    [_backgroungScrollView addSubview:_receivedBtn];
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.frame = CGRectMake(10, CGRectGetMaxY(_receivedBtn.frame)+1, kScreenWidth - 20, kHeight);
    contentLabel.text = @"动态内容:";
    contentLabel.textColor = [UIColor orangeColor];
    contentLabel.font = [UIFont systemFontOfSize:kFont];
    [_backgroungScrollView addSubview:contentLabel];
    
    
    
    UIView *textBackView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(contentLabel.frame), kScreenWidth - 20, 3.5 * kHeight)];
    textBackView.backgroundColor = [UIColor blackColor];
    textBackView.layer.cornerRadius = 4;
    textBackView.layer.masksToBounds = 1;
    [_backgroungScrollView addSubview:textBackView];
    
    _taskContentTView = [[UITextView alloc]init];
    //    _contentTView.backgroundColor = kTestColor;
    _taskContentTView.frame = CGRectMake(1, 1, kScreenWidth - 22, CGRectGetHeight(textBackView.frame) - 2);
    
    _taskContentTView.delegate = self;
    _taskContentTView.font = [UIFont systemFontOfSize:kFont];
    _taskContentTView.layer.cornerRadius = 4;
    _taskContentTView.layer.masksToBounds = 1;
    [textBackView addSubview:_taskContentTView];
    
    
    
    _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveBtn.tag = 777 + 1;
    _saveBtn.backgroundColor = kBtnColor;
    [_saveBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_saveBtn addTarget:self action:@selector(consultBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _saveBtn.frame = CGRectMake(20, CGRectGetMaxY(textBackView.frame) + 20, kScreenWidth - 40, kHeight);
    [_backgroungScrollView addSubview:_saveBtn];
    _saveBtn.layer.cornerRadius = 4;
    _saveBtn.layer.masksToBounds = 1;
    
    [ConfigUITools sizeToScroll:_backgroungScrollView withStandardElementMaxY:CGRectGetMaxY(_saveBtn.frame) + 25 forStepsH:0];
    
}






- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
    if (_datePickerView) {
        
        _datePickerView.hidden = 1;
    }
    
}

- (void)consultBtnClicked:(UIButton *)sender {
    
    switch (sender.tag - 777) {
        case 0:
            
        {
            UserDeptViewController *de = [[UserDeptViewController alloc]init];
            de.isJump = YES;
            de.isBlock = YES;
            de.selectedBlock = ^(NSMutableArray *array){
                NSString *title = @"";
                if (array.count > 0) {
                    NSMutableArray *arr = [[NSMutableArray alloc]init];
                    for (NSDictionary *dict in array) {
                        
                        [arr addObject:[dict objectForKey:@"name"]];
                        
                        
                    }
                    
                    title = [(NSArray *)arr componentsJoinedByString:@"、"];
                }
                
                [_receivedBtn setTitle:title forState:UIControlStateNormal];
                [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:_backgroungScrollView];
                
            };
            [self.navigationController pushViewController:de animated:YES];
            
        }
            
            break;
        case 1:
        {
            
            if ([AppDelegate isNetworkConecting]) {
                

                NSDictionary *keyAndValues = @{@"logincookie":[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],@"datatype":@"richenganpai"};

                if ([AlertTipsViewTool isEmptyWillSubmit:@[_taskTitleTF,_taskContentTView,_receivedBtn]]) {

                }
//                }else {
//                    
//                    NSString *xmlString =  [JHXMLParser generateXMLString:keyAndValues
//                                                                 hostName:@"Net.GongHuiTong"
//                                                          startElementKey:@"AddAppInfo" xmlInfo:YES
//                                                             resouresInfo:@{
//                                                                            @"fld_30_1":_contentTView.text,
//                                                                            @"fld_30_4":_urgentLevelBtn.titleLabel.text,
//                                                                            @"fld_30_5":_startT,
//                                                                            @"fld_30_6":_startH,
//                                                                            @"fld_30_7":_startM,
//                                                                            @"fld_30_8":_endT,
//                                                                            @"fld_30_9":_endH,
//                                                                            @"fld_30_10":_endM,
//                                                                            @"fld_30_11":_remindT,
//                                                                            @"fld_30_12":_remindH,
//                                                                            @"fld_30_13":_remindM,
//                                                                            @"fld_30_14":timeIntercval,
//                                                                            @"fld_30_16":_idString,
//                                                                            @"fld_30_17":_nameString
//                                                                            }fileNames:nil fileExtNames:nil fileDesc:nil fileData:nil];
//                    
//                    [self submitAddScheduleWithXmlString:xmlString];
//                    
//                }

                
            }else {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无网络连接,请检查网络!" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    
                    
                }];
                
                [alertController addAction:okAction];
                
                [self.navigationController  presentViewController:alertController animated:YES completion:nil];
                
            }
            
        }
            break;
            
            
        default:
            break;
    }
    
}






- (void)submitAddUserWithXmlString:(NSString *)xmlString
{
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        
        
        __weak typeof(self) weakSelf = self;
        ReturnValueBlock returnBlockPost = ^(id resultValue){
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSLog(@"AddAppInfoResult::%@",[[resultValue lastObject] objectForKey:@"AddAppInfoResult"]);
                NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"AddAppInfoResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                
                NSLog(@"AddAppInfoResult::%@",listDic);
//                weakSelf.submitBtnBlock( YES);
//                [weakSelf.navigationController popViewControllerAnimated:YES];
                
                
                
            });
            
            
            
            
            
        };
        
        
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:xmlString parseParameters:@[@"AddAppInfoResult"] WithReturnValeuBlock:returnBlockPost WithErrorCodeBlock:nil];
        
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_backgroungScrollView endEditing:YES];
    
    return 1;
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [_backgroungScrollView endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [DaiDodgeKeyboard removeRegisterTheViewNeedDodgeKeyboard];
}

@end

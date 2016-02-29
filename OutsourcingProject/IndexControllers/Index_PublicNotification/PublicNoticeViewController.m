//
//  PublicNoticeViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/20.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "PublicNoticeViewController.h"
#import "SendNotifiactionViewController.h"
#import "NotiTableViewCell.h"
#import "IndexNotiModel.h"
@interface PublicNoticeViewController ()<HorizontalMenuDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UITableView    *showTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView         *topSearchView;
@property (nonatomic, strong) UITextField    *meetingSearchTF;      //
@property (nonatomic, strong) UITextField    *activeSearchTF;      //
@property (nonatomic, strong) UITextField    *otherSearchTF;
@property (nonatomic, strong) HorizontalMenu *menu;//


@end

@implementation PublicNoticeViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = 0;
    
    //    //    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    //    //    {
    //            self.navigationController.navigationBar.translucent = NO;
    //    //    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知公告";
    self.view.backgroundColor = kBackColor;
    
    [self configUI];

     [self getUnionSubjectsDataWithType:@"huiyitongzhi" pageSize:0 navIndex:0 filter:@"" withTag:0 ];
}



- (void)configUI {

    _menu  = [[HorizontalMenu alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) withTitles:@[@"会议通知", @"其他通知", @"我发出的通知"]];
    _menu.delegate = self;
    [self.view addSubview:_menu];
    
    
    _topSearchView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, 40)];
    _topSearchView.backgroundColor = kBackColor;
    [self.view addSubview:_topSearchView];
    
    [_topSearchView addSubview:[self searchTextFieldWithTag:0]];
    [self initShowTableView];
    
    
    
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    
    
    
    
    UIButton *sendNotiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [sendNotiBtn setBackgroundImage:[UIImage imageNamed:@"send"] forState:UIControlStateNormal];
    sendNotiBtn.backgroundColor = kTinColor;
    sendNotiBtn.layer.cornerRadius = 4;
    sendNotiBtn.layer.masksToBounds = 1;
    sendNotiBtn.frame = CGRectMake(20, CGRectGetMaxY(_showTableView.frame) + 5.5 , kScreenWidth - 40, 40);
    //    sendNotiBtn.alpha = 0.7;
    [sendNotiBtn setTitle:@"发通知" forState:UIControlStateNormal];
    [sendNotiBtn addTarget:self action:@selector(sendNotiBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendNotiBtn];


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    
    NotiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[NotiTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }

 
    cell.model = _dataArray[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    UserInfoViewController  *use = [[UserInfoViewController alloc]init];
    //    [self.navigationController pushViewController:use animated:YES];
    //    [self.navigationController pushViewController:_controllersArray[indexPath.row] animated:NO];
    
}

- (void)initShowTableView{
    
    if (!_showTableView) {
        _showTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topSearchView.frame), kScreenWidth, kScreenHeight - 40 - CGRectGetMaxY(_topSearchView.frame) - 75) style:UITableViewStylePlain];
        _showTableView.backgroundColor = kBackColor;
        _showTableView.delegate=self;
        _showTableView.dataSource=self;
        
        
    }
    [self.view addSubview:_showTableView];
    
}


- (UITextField *)searchTextFieldWithTag:(NSInteger)tag {
    
    UITextField *tf;
    UIImageView *leftImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shape-4"]];
    leftImg.frame = CGRectMake(5, 7.5, 15, 15);
    
    switch (tag) {
        case 0:
        {
            if (nil == _meetingSearchTF) {
                
                _meetingSearchTF = [[UITextField alloc]initWithFrame:CGRectMake(5, 3, kScreenWidth - 10, 30)];
                _meetingSearchTF.delegate = self;
                _meetingSearchTF.backgroundColor = [UIColor whiteColor];
                _meetingSearchTF.leftView = leftImg;
//                _meetingSearchTF.text = @"";
                _meetingSearchTF.leftViewMode = UITextFieldViewModeUnlessEditing;
                _meetingSearchTF.borderStyle = UITextBorderStyleRoundedRect;
                _meetingSearchTF.clearButtonMode = UITextFieldViewModeAlways;
                
            }
            
            tf = _meetingSearchTF;
        }
            
            break;
            
        case 1:
        {
            if (nil == _activeSearchTF) {
                
                _activeSearchTF = [[UITextField alloc]initWithFrame:CGRectMake(5, 3, kScreenWidth - 10, 30)];
                _activeSearchTF.delegate = self;
                _activeSearchTF.backgroundColor = [UIColor whiteColor];
                _activeSearchTF.leftView = leftImg;
//                _activeSearchTF.text = @"_activeSearchTF";
                _activeSearchTF.leftViewMode = UITextFieldViewModeUnlessEditing;
                _activeSearchTF.borderStyle = UITextBorderStyleRoundedRect;
                _activeSearchTF.clearButtonMode = UITextFieldViewModeAlways;
                
            }
            
            tf = _activeSearchTF;
        }
            
            break;
        case 2:
        {
            if (nil == _otherSearchTF) {
                
                _otherSearchTF = [[UITextField alloc]initWithFrame:CGRectMake(5, 3, kScreenWidth - 10, 30)];
                _otherSearchTF.delegate = self;
                _otherSearchTF.backgroundColor = [UIColor whiteColor];
                _otherSearchTF.leftView = leftImg;
//                _otherSearchTF.text = @"_otherSearchTF";
                _otherSearchTF.leftViewMode = UITextFieldViewModeUnlessEditing;
                _otherSearchTF.borderStyle = UITextBorderStyleRoundedRect;
                _otherSearchTF.clearButtonMode = UITextFieldViewModeAlways;
                
            }
            
            tf = _otherSearchTF;
        }
            
            break;
            
        default:
            break;
    }
    
    return  tf;
    
}




- (MultiTextView *)richLabelWithFrame:(CGRect)frame withTitleArray:(NSArray *)array {
    
    NSMutableArray* setArray_f = [[NSMutableArray alloc] initWithCapacity:5];

    MultiTextView* showLable = [[MultiTextView alloc] initWithFrame:frame];
    showLable.alignmentType = Muti_Alignment_Left_Type;
    if ([array[0] isEqualToString:@"急"]) {
        
        [setArray_f addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],@"Color",[UIFont systemFontOfSize:15],@"Font",nil]];
        [setArray_f addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],@"Color",[UIFont systemFontOfSize:15],@"Font",nil]];

        [showLable setShowText:[NSString stringWithFormat:@"急|    %@     %@",array[1],array[2]]Setting:setArray_f];
    }else {
    
        [setArray_f addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],@"Color",[UIFont systemFontOfSize:15],@"Font",nil]];
        [setArray_f addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],@"Color",[UIFont systemFontOfSize:15],@"Font",nil]];
        [showLable setShowText:[NSString stringWithFormat:@"%@    %@     %@",array[0],array[1],array[2]] Setting:setArray_f];
    
    }
    
    

    return showLable;
    
}

#pragma mark - HorizontalMenuDelegate

- (void)clieckButton:(UIButton *)button
{
    OPLog(@"%ld", button.tag);
    
    switch (button.tag) {
        case 0:

            [_meetingSearchTF removeFromSuperview];
            [_topSearchView addSubview: [self searchTextFieldWithTag:0]];
            [self getUnionSubjectsDataWithType:@"huiyitongzhi" pageSize:0 navIndex:0 filter:@"" withTag:0 ];
            
            break;
        case 1:

            if (_activeSearchTF) {
                [_activeSearchTF removeFromSuperview];
            }
            [_topSearchView addSubview: [self searchTextFieldWithTag:1]];
            
            
            
            break;
        case 2:
            
            if (_otherSearchTF) {
                [_otherSearchTF removeFromSuperview];
            }
           [_topSearchView addSubview: [self searchTextFieldWithTag:2]];
            [self getUnionSubjectsDataWithType:@"qitatongzhi" pageSize:0 navIndex:0 filter:@"" withTag:0 ];
            
            break;
            
        default:
            break;
    }
   
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    OPLog(@"%@",_meetingSearchTF.text);
    [self.view endEditing:YES];
    return 1;
}

- (void)getUnionSubjectsDataWithType:(NSString *)type pageSize:(NSInteger)pageSize navIndex:(NSInteger)index filter:(NSString *)filter withTag:(NSInteger)Tag{
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD showWithStatus:@"增在加载..."];
        NSString * requestBody = [NSString stringWithFormat:
                                  @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                                  "<soap12:Envelope "
                                  "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                                  "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                                  "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                                  "<soap12:Body>"
                                  "<GetJsonListData xmlns=\"Net.GongHuiTong\">"
                                  "<logincookie>%@</logincookie>"
                                  "<datatype>%@</datatype>"
                                  "<pagesize>%ld</pagesize>"
                                  "<navindex>%ld</navindex>"
                                  "<filter>%@</filter>"
                                  " </GetJsonListData>"
                                  "</soap12:Body>"
                                  "</soap12:Envelope>",[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],type,(long)pageSize,(long)index,filter];
        
        ReturnValueBlock returnBlock = ^(id resultValue){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_dataArray removeAllObjects];
                
                OPLog(@"-FF-%@",[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]);
                OPLog(@"-show-%@",[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] class]);
                if ([NSNull null] ==[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]) {
                    
                    [SVProgressHUD showErrorWithStatus:@"没有更多的数据哦"];
                    
                    //                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您还没有发出的成果哦" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    //                    [alert show];
                    
                    OPLog(@"rrrrrrrrrrrrrerror: account or password error !");
                    
                    
                }else {
                    
                    NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                    [SVProgressHUD showSuccessWithStatus:@"加载完成"];
                    //                    OPLog(@"%@",listDic);
                    
                    OPLog(@"------%@----------",[listDic objectForKey:@"rows"]);
                    
                    for (NSDictionary *dict in [listDic objectForKey:@"rows"]) {
                        IndexNotiModel  *model = [[IndexNotiModel alloc]init];
                        
                        [model setValuesForKeysWithDictionary:dict];
                        [_dataArray addObject:model];
                        
                    }
                    
                    for (IndexNotiModel *model in _dataArray) {
                        
                        OPLog(@"%@   %@",model.senderName,model.chContent);
                    }
                    
                    [_showTableView reloadData];
                    
                    
                    
                    
                    
                    
                }
                
                
                
            });
            
            
        };
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"GetJsonListDataResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];
        
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    
    
}

- (void)sendNotiBtnClicked:(UIButton *)sender {

    [self.navigationController pushViewController:[[SendNotifiactionViewController alloc]init] animated:YES];
    
}

@end

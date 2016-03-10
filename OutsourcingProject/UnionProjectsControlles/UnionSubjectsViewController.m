//
//  UnionSubjectsViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/2/18.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "UnionSubjectsViewController.h"
#import "SubjectDetailViewController.h"
#import "ClassifyModel.h"
#import "GuideModel.h"




#define kBtnWdith 60
#define kRow 4
#define kTopToBot  10
#define kBtnMargin (kScreenWidth - kRow * kBtnWdith) / (kRow + 1)

@interface UnionSubjectsViewController ()<HorizontalMenuDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView   *policyBackView;
@property (nonatomic, strong) UIScrollView   *guideBackView;
@property (nonatomic, strong) UIScrollView   *showBackView;
@property (nonatomic, strong) HorizontalMenu *menu;//
@property (nonatomic, strong) UIView         *topSearchView;
@property (nonatomic, strong) UITextField         *policySearchTF;
@property (nonatomic, strong) UITextField         *guideSearchTF;
@property (nonatomic, strong) UITextField         *showSearchTF;
@property (nonatomic, strong) NSMutableArray         *dataArray;
@property (nonatomic, strong) NSMutableArray         *viewsArray;
@property (nonatomic, assign) NSInteger         deeperApiTag;
@property (nonatomic, assign) NSInteger         searchApiTag;




@end

@implementation UnionSubjectsViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工会百科";


    [self configUI];


    _deeperApiTag = 0;
    _searchApiTag = 0;
    [self.view addSubview:[self getUnionSubjectsDataWithType:@"zhengcefaguifenlei" pageSize:0 navIndex:0 filter:@"" onScrollView:_policyBackView withApiTag:0 forViewTag:0 ]];
    
    
}

- (void)configUI {
    
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }

    _menu  = [[HorizontalMenu alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) withTitles:@[@"政策法规", @"业务指导", @"成果展示"]];
    _menu.delegate = self;
    [self.view addSubview:_menu];
    
    _topSearchView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, 40)];
    _topSearchView.backgroundColor = kBackColor;
    [self.view addSubview:_topSearchView];
    
    [_topSearchView addSubview:[self searchTextFieldWithTag:0]];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(resetBtnClicked)];
    self.navigationItem.rightBarButtonItem = rightItem;




}



- (void)selectedModel:(UIButton *)sender {

    
    switch (_deeperApiTag) {
        case 0:
        {
            SubjectDetailViewController *subD = [[SubjectDetailViewController alloc]init];
            subD.requestTag = sender.tag;
            subD.MokuaiTag = _deeperApiTag;
            subD.dataType = @"zhengcefagui";
            subD.filter =  [NSString stringWithFormat:@"Datatype=\"%@\"",sender.titleLabel.text];
            subD.subjectTitle = sender.titleLabel.text;
            [self.navigationController pushViewController:subD animated:YES];
    
        }
            break;
        case 1:
            
        {
            SubjectDetailViewController *subD = [[SubjectDetailViewController alloc]init];
            subD.requestTag = sender.tag;
            subD.MokuaiTag = _deeperApiTag;
            subD.dataType = @"yewuzhidao";
            subD.filter =  [NSString stringWithFormat:@"moduletype=\"%@\"",sender.titleLabel.text];
            subD.subjectTitle = sender.titleLabel.text;
            [self.navigationController pushViewController:subD animated:YES];
            
        }
            
            break;
        case 2:
            
        {
            SubjectDetailViewController *subD = [[SubjectDetailViewController alloc]init];
            subD.requestTag = sender.tag;
            subD.MokuaiTag = _deeperApiTag;
            subD.dataType = @"shoudaodechengguozhanshi";
            subD.filter =  [NSString stringWithFormat:@"Fld_40_2=\"%@\"",sender.titleLabel.text];
            subD.subjectTitle = sender.titleLabel.text;
            [self.navigationController pushViewController:subD animated:YES];
            
        }
            
            break;
            
        default:
            break;
    }
    
    OPLog(@"selected %@  -- %ld",sender.titleLabel.text,sender.tag);


}

- (UITextField *)searchTextFieldWithTag:(NSInteger)tag {
    
    UITextField *tf;
    UIImageView *leftImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shape-4"]];
    leftImg.frame = CGRectMake(5, 7.5, 15, 15);
    [self.view endEditing:YES];
    switch (tag) {
        case 0:
        {
            if (nil == _policySearchTF) {

                _policySearchTF = [[UITextField alloc]initWithFrame:CGRectMake(5, 3, kScreenWidth - 10, 30)];
                _policySearchTF.delegate = self;
                _policySearchTF.backgroundColor = [UIColor whiteColor];
                _policySearchTF.placeholder = @"搜索政策法规";
                _policySearchTF.leftView = leftImg;
                _policySearchTF.returnKeyType =UIReturnKeySearch;
                //                _meetingSearchTF.text = @"";
                _policySearchTF.leftViewMode = UITextFieldViewModeUnlessEditing;
                _policySearchTF.borderStyle = UITextBorderStyleRoundedRect;
                _policySearchTF.clearButtonMode = UITextFieldViewModeAlways;
                [_topSearchView addSubview:_policySearchTF];

                
            }
            
            tf = _policySearchTF;
        }
            
            break;
            
        case 1:
        {
            if (nil == _guideSearchTF) {

                _guideSearchTF = [[UITextField alloc]initWithFrame:CGRectMake(5, 3, kScreenWidth - 10, 30)];
                _guideSearchTF.delegate = self;
                _guideSearchTF.backgroundColor = [UIColor whiteColor];
                _guideSearchTF.leftView = leftImg;
                _guideSearchTF.placeholder = @"搜索业务指导";
                //                _meetingSearchTF.text = @"";
                _guideSearchTF.returnKeyType =UIReturnKeySearch;
                _guideSearchTF.leftViewMode = UITextFieldViewModeUnlessEditing;
                _guideSearchTF.borderStyle = UITextBorderStyleRoundedRect;
                _guideSearchTF.clearButtonMode = UITextFieldViewModeAlways;
                [_topSearchView addSubview:_guideSearchTF];
                
            }
            
            tf = _guideSearchTF;
        }
            
            break;
        case 2:
        {
            if (nil == _showSearchTF) {
                _showSearchTF = [[UITextField alloc]initWithFrame:CGRectMake(5, 3, kScreenWidth - 10, 30)];
                _showSearchTF.delegate = self;
                _showSearchTF.backgroundColor = [UIColor whiteColor];
                _showSearchTF.leftView = leftImg;
                _showSearchTF.placeholder = @"搜索成果展示";
                _showSearchTF.returnKeyType =UIReturnKeySearch;
                //                _meetingSearchTF.text = @"";
                _showSearchTF.leftViewMode = UITextFieldViewModeUnlessEditing;
                _showSearchTF.borderStyle = UITextBorderStyleRoundedRect;
                _showSearchTF.clearButtonMode = UITextFieldViewModeAlways;
                [_topSearchView addSubview:_showSearchTF];
            }
            
            tf = _showSearchTF;
        }
            
            break;
            
        default:
            break;
    }
    
    return  tf;
    
}


#pragma mark - HorizontalMenuDelegate

- (void)clieckButton:(UIButton *)button
{
    OPLog(@"%ld", button.tag);
    _searchApiTag = button.tag;
    
    switch (button.tag) {
        case 0:
            
            _deeperApiTag = 0;
            [_policySearchTF becomeFirstResponder];
            [_guideSearchTF resignFirstResponder];
            [_showSearchTF resignFirstResponder];
            if (_policyBackView) {
                
               [self.view bringSubviewToFront:_policyBackView];
            }
            
            [_policySearchTF removeFromSuperview];
            [_topSearchView addSubview: [self searchTextFieldWithTag:0]];
            
            
            
            
            break;
        case 1:
            
        {
          
            _deeperApiTag = 1;
            
            
            [_policySearchTF resignFirstResponder];
            [_guideSearchTF becomeFirstResponder];
            [_showSearchTF resignFirstResponder];
            
//            NSString *filterParm = [[NSString stringWithFormat:@"uppermodulename=%@",@"业务指导"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if (_guideBackView) {
                
                [self.view bringSubviewToFront:_guideBackView];
            }else {
            
                [self.view addSubview:[self getUnionSubjectsDataWithType:@"mokuaifenlei" pageSize:0 navIndex:0 filter:@"uppermodulename=\"业务指导\"" onScrollView:_guideBackView withApiTag:1 forViewTag:1 ]];
            
            }
            
            if (_guideSearchTF) {
                [_guideSearchTF removeFromSuperview];
            }
            [_topSearchView addSubview: [self searchTextFieldWithTag:1]];

          
        }
            break;
        case 2:
            
            _deeperApiTag = 2;
            
            [_policySearchTF resignFirstResponder];
            [_guideSearchTF resignFirstResponder];
            [_showSearchTF becomeFirstResponder];
            if (_showBackView) {
                
                [self.view bringSubviewToFront:_showBackView];
            }else {
            
                [self.view addSubview:[self getUnionSubjectsDataWithType:@"chengguofenlei" pageSize:0 navIndex:0 filter:@"" onScrollView:_showBackView withApiTag:0 forViewTag:2 ]];
            }
            
            if (_showSearchTF) {
                [_showSearchTF removeFromSuperview];
            }
            [_topSearchView addSubview: [self searchTextFieldWithTag:2]];

            
            break;
            
        default:
            break;
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    switch (_searchApiTag) {
        case 0:
        {
            //yuhehr@qq.com    YHsys@1205
              OPLog(@"666$%@",_policySearchTF.text);
            SubjectDetailViewController *subD = [[SubjectDetailViewController alloc]init];
            subD.dataType = @"zhengcefagui";
            subD.MokuaiTag = 0;
            subD.filter =  [NSString stringWithFormat:@"chtopic like \"%%%@%%\"",_policySearchTF.text];
//           subD.filter =  @"chtopic like \"%中国%\"";
            [self.navigationController pushViewController:subD animated:YES];
        }
            break;
        case 1:
            
             OPLog(@"777$%@",_guideSearchTF.text);
        {
            //yuhehr@qq.com    YHsys@1205
            OPLog(@"666$%@",_policySearchTF.text);
            SubjectDetailViewController *subD = [[SubjectDetailViewController alloc]init];
            subD.dataType = @"yewuzhidao";
            subD.MokuaiTag = 1;
            subD.filter =  [NSString stringWithFormat:@"chtopic like \"%%%@%%\"",_guideSearchTF.text];
            //           subD.filter =  @"chtopic like \"%中国%\"";
            [self.navigationController pushViewController:subD animated:YES];
        }
            
            break;
        case 2:
            

        {
            //yuhehr@qq.com    YHsys@1205

            SubjectDetailViewController *subD = [[SubjectDetailViewController alloc]init];
            subD.dataType = @"shoudaodechengguozhanshi";
            subD.MokuaiTag = 2;
            subD.filter =  [NSString stringWithFormat:@"fld_40_1 like \"%%%@%%\"",_showSearchTF.text];
            //           subD.filter =  @"chtopic like \"%中国%\"";
            [self.navigationController pushViewController:subD animated:YES];
        }
            
            
            break;
            
        default:
            break;
    }
    
    [self.view endEditing:YES];
    return 1;
}


- (void)resetBtnClicked {
    
    
    switch (_searchApiTag) {
        case 0:
        {
        
        
            [_policyBackView removeFromSuperview];
            _policyBackView = nil;
//            [_policySearchTF removeFromSuperview];
//            _policySearchTF = nil;
            [self.view addSubview:[self getUnionSubjectsDataWithType:@"zhengcefaguifenlei" pageSize:0 navIndex:0 filter:@"" onScrollView:_policyBackView withApiTag:0 forViewTag:0 ]];
        }
            
            break;
            
        case 1:
            
        {
            
            [_guideBackView removeFromSuperview];
            _guideBackView = nil;
//            [_guideSearchTF removeFromSuperview];
//            _guideSearchTF = nil;
             [self.view addSubview:[self getUnionSubjectsDataWithType:@"mokuaifenlei" pageSize:0 navIndex:0 filter:@"uppermodulename=\"业务指导\"" onScrollView:_guideBackView withApiTag:1 forViewTag:1 ]];
            
            
        }
            break;
            
            
        case 2:
        {
            
//            [_showSearchTF removeFromSuperview];
//            _showSearchTF = nil;
            [_showBackView removeFromSuperview];
            _showBackView = nil;
            [self.view addSubview:[self getUnionSubjectsDataWithType:@"chengguofenlei" pageSize:0 navIndex:0 filter:@"" onScrollView:_showBackView withApiTag:0 forViewTag:2 ]];
            
            
            
        }
            
            break;
            
        default:
            break;
    }
    
    
    
}

- (UIScrollView *)getUnionSubjectsDataWithType:(NSString *)type pageSize:(NSInteger)pageSize navIndex:(NSInteger)index filter:(NSString *)filter onScrollView:(UIScrollView *)scrollView withApiTag:(NSInteger)apiTag forViewTag:(NSUInteger)viewTag{
    
    
    if (!scrollView) {
        
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 84, kScreenWidth, kScreenHeight - 84 - 49- 64)];
        scrollView.backgroundColor = kTestColor;
        [self.view addSubview:scrollView];
        
        switch (viewTag) {
            case 0:
                
                _policyBackView = scrollView;
                //                _policyBackView.hidden = YES;
                
                break;
            case 1:
                
                _guideBackView = scrollView;
                //                _guideBackView.hidden = YES;
                break;
            case 2:
                
                _showBackView = scrollView;
                //                _showBackView.hidden = YES;
                break;
                
            default:
                break;
        }
        
        
    }
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD showWithStatus:@"增在加载..."];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
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
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                
                [_dataArray removeAllObjects];
                OPLog(@"-FF-%@",[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]);

                if ([NSNull null] ==[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]) {

                    [SVProgressHUD showErrorWithStatus:@"没有更多的数据哦"];

                    
                }else if( [[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]isEqualToString:@"用户未登录！"]) {
                    
                     [SVProgressHUD showSuccessWithStatus:@"用户未登录！"];
    
                }else {
                    
                    {
                         [SVProgressHUD showSuccessWithStatus:@"加载完成"];
                        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                        
                        //                    OPLog(@"%@",listDic);
                        
                        OPLog(@"------%@----------",[listDic objectForKey:@"rows"]);
                        
                        
                        
                        switch (apiTag) {
                                
                            case 0:
                            {
                                for (NSDictionary *dict in [listDic objectForKey:@"rows"]) {
                                    ClassifyModel  *classifyModel = [[ClassifyModel alloc]init];
                                    classifyModel.iconcode = [dict objectForKey:@"iconcode"];
                                    classifyModel.classifyName = [dict objectForKey:@"typename"];
                                    [_dataArray addObject:classifyModel];
                                    
                                }
                                
                                for (ClassifyModel *model in _dataArray) {
                                    
                                    OPLog(@"%@   %@",model.classifyName,model.iconcode);
                                }
                                
                                
                                NSInteger line = 0;
                                if (_dataArray.count % kRow == 0) {
                                    
                                    line = _dataArray.count / kRow;
                                    
                                }else {
                                    
                                    line = _dataArray.count / kRow + 1;
                                    
                                }
                                
                                
                                
                                for (int i = 0; i < line; i ++) {
                                    
                                    for (int j = 0; j < kRow ; j ++) {
                                        
                                        if (i == line - 1) {
                                            
                                            if ( j == _dataArray.count - (line - 1 )* kRow ) {
                                                
                                                return ;
                                            }
                                            
                                        }
                                        UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                                        topBtn.frame = CGRectMake(kBtnMargin + j *  (kBtnMargin + kBtnWdith),  kBtnMargin + i *(kBtnMargin + kBtnWdith + kTopToBot), kBtnWdith , kBtnWdith );
                                        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"icon_%@",[_dataArray[kRow * i + j] iconcode]] ofType:@"png"];
                                        [topBtn setBackgroundImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
                                        topBtn.tag = [[_dataArray[kRow * i + j] iconcode] integerValue];
                                        topBtn.titleLabel.font = [UIFont systemFontOfSize:12];
                                        [topBtn setTitleEdgeInsets:UIEdgeInsetsMake(kBtnWdith +  kBtnMargin + 4, -kBtnMargin / 2, 0, -kBtnMargin / 2)];
                                        [topBtn setTitle:[_dataArray[kRow * i + j] classifyName] forState:UIControlStateNormal];
                                        [topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                        [topBtn addTarget:self action:@selector(selectedModel:) forControlEvents:UIControlEventTouchUpInside];
                                        [scrollView addSubview:topBtn];
                                        
                                    }
                                    
                                }
                                
                                
                                
                                scrollView.contentSize = CGSizeMake(kScreenWidth, 5 * (kBtnWdith + 2 * kBtnMargin));
                                
                            }
                                
                                
                                
                                break;
                            case 1:
                            {
                                for (NSDictionary *dict in [listDic objectForKey:@"rows"]) {
                                    GuideModel  *classifyModel = [[GuideModel alloc]init];
                                    [classifyModel setValuesForKeysWithDictionary:dict];
                                    OPLog(@"ed:%@",[dict objectForKey:@"appicon"]);
                                    [_dataArray addObject:classifyModel];
                                    
                                }
                                
                                for (GuideModel *model in _dataArray) {
                                    
                                    OPLog(@"%@   %@",model.appicon,model.modulename);
                                }
                                
                                NSInteger line = 0;
                                if (_dataArray.count % kRow == 0) {
                                    
                                    line = _dataArray.count / kRow;
                                    
                                }else {
                                    
                                    line = _dataArray.count / kRow + 1;
                                    
                                }
                                
                                
                                
                                for (int i = 0; i < line; i ++) {
                                    
                                    for (int j = 0; j < kRow ; j ++) {
                                        
                                        if (i == line - 1) {
                                            
                                            if ( j == _dataArray.count - (line - 1 )* kRow ) {
                                                
                                                return ;
                                            }
                                            
                                        }
                                        UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                                        topBtn.frame = CGRectMake(kBtnMargin + j *  (kBtnMargin + kBtnWdith),  kBtnMargin + i *(kBtnMargin + kBtnWdith + kTopToBot), kBtnWdith , kBtnWdith );
                                        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"icon_%@",[_dataArray[kRow * i + j] appicon]] ofType:@"png"];
                                        [topBtn setBackgroundImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
                                        topBtn.tag = [[_dataArray[kRow * i + j] appicon] integerValue];
                                        topBtn.titleLabel.font = [UIFont systemFontOfSize:12];
                                        [topBtn setTitleEdgeInsets:UIEdgeInsetsMake(kBtnWdith +  kBtnMargin + 4, -kBtnMargin / 2, 0, -kBtnMargin / 2)];
                                        [topBtn setTitle:[_dataArray[kRow * i + j] modulename] forState:UIControlStateNormal];
                                        [topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                        [topBtn addTarget:self action:@selector(selectedModel:) forControlEvents:UIControlEventTouchUpInside];
                                        [scrollView addSubview:topBtn];
                                        
                                    }
                                    
                                }
                                
                                
                                
                                scrollView.contentSize = CGSizeMake(kScreenWidth, 5 * (kBtnWdith + 2 * kBtnMargin));
                                
                            }
                                
                                
                                break;
                            case 2:
                                
                                
                                break;
                                
                            default:
                                break;
                        }
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                }
                
                
                
            });
            
            
        };
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"GetJsonListDataResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];
        
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    return scrollView;
    
}



@end

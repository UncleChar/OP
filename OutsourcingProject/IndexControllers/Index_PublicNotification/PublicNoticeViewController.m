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
#import "NotiDetialViewController.h"
#import "SendingDetailViewController.h"
#import "SearchNotiViewController.h"
@interface PublicNoticeViewController ()<HorizontalMenuDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

{

    ReturnValueBlock returnBlock;
}

@property (nonatomic, strong) UITableView    *showTableView;
@property (nonatomic, strong) NSMutableArray *mettingDataArray;
@property (nonatomic, strong) NSMutableArray *otherDataArray;
@property (nonatomic, strong) NSMutableArray *SendDataArray;
@property (nonatomic, strong) NSMutableArray *searchDataArray;
@property (nonatomic, strong) UIView         *topSearchView;
@property (nonatomic, strong) UITextField    *meetingSearchTF;      //
@property (nonatomic, strong) UITextField    *otherSearchTF;      //
@property (nonatomic, strong) UITextField    *sendSearchTF;
@property (nonatomic, strong) HorizontalMenu *menu;//

@property (nonatomic, assign) NSInteger  pageSize;//每页的个数
@property (nonatomic, assign) NSInteger  pageSendNotiIndex;//从0页开始
@property (nonatomic, assign) NSInteger  pageMeetingNotiIndex;//从0页开始
@property (nonatomic, assign) NSInteger  pageOtherNotiIndex;//从0页开始
@property (nonatomic, assign) NSInteger  requestTag;//从0页开始
@property (nonatomic, assign) BOOL        isHeaderRefersh;
@property (nonatomic, assign) BOOL        isFooterRefersh;
@property (nonatomic, assign) BOOL        isSearch;


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
    
    _pageMeetingNotiIndex = 1;
    _pageOtherNotiIndex = 1;
    _pageSendNotiIndex = 1;
    _pageSize = 8;
    _requestTag = 0;
    
     [self initArray];
     [self configUI];

     [self handleRequsetDate];
     [self getUnionSubjectsDataWithType:@"huiyitongzhi" pageSize:_pageSize navIndex:0 filter:@"" withTag:0 ];
}

- (void)initArray {

    if (!_mettingDataArray) {
        
        _mettingDataArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    if (!_otherDataArray) {
        
        _otherDataArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    if (!_SendDataArray) {
        
        _SendDataArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    if (!_searchDataArray) {
        
        _searchDataArray = [NSMutableArray arrayWithCapacity:0];
        
    }

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


- (void)configUI {

    _menu  = [[HorizontalMenu alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) withTitles:@[@"会议通知", @"其他通知", @"我发出的通知"]];
    _menu.delegate = self;
    [self.view addSubview:_menu];
    
    
    _topSearchView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, 40)];
    _topSearchView.backgroundColor = kBackColor;
    [self.view addSubview:_topSearchView];
    
    [_topSearchView addSubview:[self searchTextFieldWithTag:0]];
    [self initShowTableView];
    

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
    
    
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 禁止自动加载
    footer.automaticallyRefresh = NO;
    
    // 设置footer
    _showTableView.mj_footer = footer;
    
    _showTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
        _isHeaderRefersh = YES;
        _isFooterRefersh = NO;
        
        
        if (_requestTag == 0) {
            _pageMeetingNotiIndex = 1;
            [self getUnionSubjectsDataWithType:@"huiyitongzhi" pageSize:_pageSize navIndex:0 filter:@"" withTag:0 ];
            
        }else if(_requestTag == 1) {
            _pageOtherNotiIndex = 1;
           [self getUnionSubjectsDataWithType:@"qitatongzhi" pageSize:_pageSize navIndex:0 filter:@"" withTag:0 ];
        }else {
        
            _pageSendNotiIndex = 1;
            [self getUnionSubjectsDataWithType:@"fachudetongzhi" pageSize:_pageSize navIndex:0 filter:@"" withTag:0 ];
        
        }
        
    }];
    

}


- (void)loadMoreData {
    
    _isFooterRefersh = YES;
    
    if (_requestTag == 0) {
      
        [self getUnionSubjectsDataWithType:@"huiyitongzhi" pageSize:_pageSize navIndex:_pageMeetingNotiIndex filter:@"" withTag:0 ];
        
    }else if(_requestTag == 1) {
        
        [self getUnionSubjectsDataWithType:@"qitatongzhi" pageSize:_pageSize navIndex:_pageOtherNotiIndex filter:@"" withTag:0 ];
        
    }else {
        
        
        [self getUnionSubjectsDataWithType:@"fachudetongzhi" pageSize:_pageSize navIndex:_pageSendNotiIndex filter:@"" withTag:0 ];
        
    }
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(_requestTag == 0){
    
      return _mettingDataArray.count;
        
    }else if (_requestTag == 1){
    
      return _otherDataArray.count;
    
    }else {
    
      return _SendDataArray.count;
    
    }
  
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    
    NotiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[NotiTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }

 
    if(_requestTag == 0){
        
       cell.model = _mettingDataArray[indexPath.row];
        
    }else if (_requestTag == 1){
        
       cell.model = _otherDataArray[indexPath.row];
        
    }else {
        
       cell.model = _SendDataArray[indexPath.row];
        
    }
    

    cell.selectionStyle = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    
    if(_requestTag == 0){
         NotiDetialViewController *noti = [[NotiDetialViewController alloc]init];
        noti.modelTag = 0;
        noti.ChID = [_mettingDataArray[indexPath.row] ChID];
        [self.navigationController pushViewController:noti animated:YES];
        
        
    }else if (_requestTag == 1){
         NotiDetialViewController *noti = [[NotiDetialViewController alloc]init];
        noti.modelTag = 0;
        noti.ChID = [_otherDataArray[indexPath.row] ChID];
        [self.navigationController pushViewController:noti animated:YES];
        
        
    }else {
        
        SendingDetailViewController  *contentVc = [[ SendingDetailViewController alloc]init];
        contentVc.ChTopic = [_SendDataArray[indexPath.row] ChTopic];;
        contentVc.chContent = [_SendDataArray[indexPath.row] chContent];
        contentVc.isReceipt = [_SendDataArray[indexPath.row] isReceipt];
        contentVc.sendDate = [_SendDataArray[indexPath.row] sendDate];
        contentVc.senderName = [_SendDataArray[indexPath.row] senderName];
        contentVc.chID = [_SendDataArray[indexPath.row] ChID];
        contentVc.receiptDate = [_SendDataArray[indexPath.row] receiptDate];
        [self.navigationController pushViewController:contentVc animated:YES];
        
    }
    
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
                _meetingSearchTF.returnKeyType =UIReturnKeySearch;
                _meetingSearchTF.placeholder = @"搜索会议通知";
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
            if (nil == _otherSearchTF) {
                
                _otherSearchTF = [[UITextField alloc]initWithFrame:CGRectMake(5, 3, kScreenWidth - 10, 30)];
                _otherSearchTF.delegate = self;
                _otherSearchTF.backgroundColor = [UIColor whiteColor];
                _otherSearchTF.leftView = leftImg;
                _otherSearchTF.returnKeyType =UIReturnKeySearch;
                _otherSearchTF.placeholder = @"搜索其他通知";
//                _activeSearchTF.text = @"_activeSearchTF";
                _otherSearchTF.leftViewMode = UITextFieldViewModeUnlessEditing;
                _otherSearchTF.borderStyle = UITextBorderStyleRoundedRect;
                _otherSearchTF.clearButtonMode = UITextFieldViewModeAlways;
                
            }
            
            tf = _otherSearchTF;
        }
            
            break;
        case 2:
        {
            if (nil == _sendSearchTF) {
                
                _sendSearchTF = [[UITextField alloc]initWithFrame:CGRectMake(5, 3, kScreenWidth - 10, 30)];
                _sendSearchTF.delegate = self;
                _sendSearchTF.backgroundColor = [UIColor whiteColor];
                _sendSearchTF.leftView = leftImg;
                _sendSearchTF.returnKeyType =UIReturnKeySearch;
                _sendSearchTF.placeholder = @"搜索我发出的通知";
                _sendSearchTF.leftViewMode = UITextFieldViewModeUnlessEditing;
                _sendSearchTF.borderStyle = UITextBorderStyleRoundedRect;
                _sendSearchTF.clearButtonMode = UITextFieldViewModeAlways;
                
            }
            
            tf = _sendSearchTF;
        }
            
            break;
            
        default:
            break;
    }
    
    return  tf;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    

    switch (_requestTag) {
        case 0:
        {
            //yuhehr@qq.com    YHsys@1205
            OPLog(@"666$%@",_meetingSearchTF.text);
            SearchNotiViewController *subD = [[SearchNotiViewController alloc]init];
            subD.dataType  = @"huiyitongzhi";
            subD.MokuaiTag = 0;
            subD.subjectTitle = @"会议通知搜索结果";
            subD.filter    = [NSString stringWithFormat:@"fld_34_1 like \"%%%@%%\"",_meetingSearchTF.text];
            [self.navigationController pushViewController:subD animated:YES];
        }
            break;
        case 1:
            
         
        {
               OPLog(@"777$%@",_otherSearchTF.text);
            SearchNotiViewController *subD = [[SearchNotiViewController alloc]init];
            subD.dataType  = @"qitatongzhi";
            subD.MokuaiTag = 1;
            subD.subjectTitle = @"其他通知搜索结果";
            subD.filter    = [NSString stringWithFormat:@"fld_34_1 like \"%%%@%%\"",_otherSearchTF.text];
            [self.navigationController pushViewController:subD animated:YES];

        }
            
            break;
        case 2:
            
            
        {
            //yuhehr@qq.com    YHsys@1205
             OPLog(@"888$%@",_sendSearchTF.text);

            SearchNotiViewController *subD = [[SearchNotiViewController alloc]init];
            subD.dataType  = @"fachudetongzhi";
            subD.MokuaiTag = 2;
            subD.subjectTitle = @"发出的通知搜索结果";
            subD.filter    = [NSString stringWithFormat:@"fld_34_1 like \"%%%@%%\"",_sendSearchTF.text];
            [self.navigationController pushViewController:subD animated:YES];
//
        }
            
            
            break;
            
        default:
            break;
    }
    
    [self.view endEditing:YES];
    return 1;
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
    [self.view endEditing:YES];
    switch (button.tag) {
        case 0:

        
//            [_meetingSearchTF becomeFirstResponder];
//            [_otherSearchTF resignFirstResponder];
//            [_sendSearchTF resignFirstResponder];
            _meetingSearchTF.text = @"";
            if (_meetingSearchTF) {
                
                [self.view bringSubviewToFront:_meetingSearchTF];
            }
            
            [_meetingSearchTF removeFromSuperview];
            [_topSearchView addSubview: [self searchTextFieldWithTag:0]];

            _requestTag = 0;
            _isHeaderRefersh  = NO;//重新归置刷新状态
            _isFooterRefersh = NO;
            
            if (_mettingDataArray.count == 0) {
                
                 [self getUnionSubjectsDataWithType:@"huiyitongzhi" pageSize:_pageSize navIndex:0 filter:@"" withTag:0 ];
    
            }else {
            
                [_showTableView reloadData];
            }
            
            
            
            break;
        case 1:

          
//            [_otherSearchTF becomeFirstResponder];
//            [_meetingSearchTF resignFirstResponder];
//            [_sendSearchTF resignFirstResponder];
            if (_otherSearchTF) {
                
                [self.view bringSubviewToFront:_otherSearchTF];
            }
            _otherSearchTF.text = @"";
            [_otherSearchTF removeFromSuperview];
            [_topSearchView addSubview: [self searchTextFieldWithTag:1]];
            
            _requestTag = 1;
            _isHeaderRefersh  = NO;//重新归置刷新状态
            _isFooterRefersh = NO;
            [_showTableView reloadData];
            if (_otherDataArray.count == 0) {
                
                 [self getUnionSubjectsDataWithType:@"qitatongzhi" pageSize:_pageSize navIndex:0 filter:@"" withTag:0 ];
                
            }else {
            
                [_showTableView reloadData];
            }
            

            
         
            
            break;
        case 2:
            
            
            
//            [_sendSearchTF becomeFirstResponder];
//            [_meetingSearchTF resignFirstResponder];
//            [_otherSearchTF resignFirstResponder];
            if (_otherSearchTF) {
                
                [self.view bringSubviewToFront:_otherSearchTF];
            }
            _sendSearchTF.text = @"";
            [_otherSearchTF removeFromSuperview];
            [_topSearchView addSubview: [self searchTextFieldWithTag:2]];
            
            _requestTag = 2;
            _isHeaderRefersh  = NO;//重新归置刷新状态
            _isFooterRefersh = NO;
            [_showTableView reloadData];
            if (_SendDataArray.count == 0) {
                
                [self getUnionSubjectsDataWithType:@"fachudetongzhi" pageSize:_pageSize navIndex:0 filter:@"" withTag:0 ];
                
            }else {
            
                [_showTableView reloadData];
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
            
            [weakSelf.showTableView.mj_header endRefreshing];

            [weakSelf.showTableView.mj_footer endRefreshing];

            OPLog(@"-FF-%@",[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]);
            OPLog(@"-show-%@",[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] class]);
            if ([NSNull null] ==[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]) {
                
                //                if (_requestTag == 1) {
                //
                //                    [weakSelf.dataArray removeAllObjects];
                //
                //                }else {
                //
                //
                //                    [weakSelf.senddataArray removeAllObjects];
                //                }
                [weakSelf.showTableView reloadData];
                
                [SVProgressHUD showErrorWithStatus:@"没有更多的数据哦"];
                
            }else {
                
                
                
                NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                
                OPLog(@"------%@----------",[listDic objectForKey:@"rows"]);
                
                NSInteger countArray = 0;
                if (weakSelf.isFooterRefersh) {
                    if (_requestTag == 0) {
                        
                        weakSelf.pageMeetingNotiIndex ++;
                        countArray = weakSelf.mettingDataArray.count;
                        
                    }else if(_requestTag == 1) {
                        countArray =weakSelf.otherDataArray.count;
                        weakSelf.pageOtherNotiIndex ++;
                    }else {
                    
                        countArray =weakSelf.SendDataArray.count;
                        weakSelf.pageSendNotiIndex ++;
                    
                        
                    }
                    
                }

                if (weakSelf.isHeaderRefersh) {
                    
                    if (_requestTag == 0) {
                        
                        [weakSelf.mettingDataArray removeAllObjects];
                    }else if(_requestTag == 1){
                        
                        
                        [weakSelf.otherDataArray removeAllObjects];
                    }else {
                    
                        [weakSelf.SendDataArray removeAllObjects];
                    }

                    weakSelf.isHeaderRefersh = NO;
                    
                }
                
                for (NSDictionary *dict in [listDic objectForKey:@"rows"]) {
                    IndexNotiModel  *model = [[IndexNotiModel alloc]init];
                    
                    [model setValuesForKeysWithDictionary:dict];
                    
                    if (_requestTag == 0) {
                        
                        [weakSelf.mettingDataArray addObject:model];
                    }else  if(_requestTag == 1){
                        
                        [weakSelf.otherDataArray addObject:model];
                    }else {
                        
                        
                        [weakSelf.SendDataArray addObject:model];
                        
                    }
                    
                }
//                for (NSDictionary *dict in [listDic objectForKey:@"rows"]) {
//                    AchievementModel  *model = [[AchievementModel alloc]init];
//                    
//                    [model setValuesForKeysWithDictionary:dict];
//                    
//                    
//                    if (_requestTag == 0) {
//                        
//                        [weakSelf.mettingDataArray addObject:model];
//                    }else  if(_requestTag == 1){
//                        
//                        [weakSelf.otherDataArray addObject:model];
//                    }else {
//                    
//                    
//                         [weakSelf.sendDataArray addObject:model];
//                        
//                    }
//                    
//                }
                
                
                if (weakSelf.isFooterRefersh) {
                    
                    if (_requestTag == 0) {
                        
                        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"增加了%ld条内容", weakSelf.mettingDataArray.count - countArray]];
                        
                    }else if(_requestTag == 1){
                        
                        
                        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"增加了%ld条内容", weakSelf.otherDataArray.count - countArray]];
                        
                        
                    }else {
                    
                        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"增加了%ld条内容", weakSelf.SendDataArray.count - countArray]];
                    
                    }
                    
                }else {
                    
                    
                    [SVProgressHUD showSuccessWithStatus:@"加载完成"];
                }
                
                
                //                if (_requestTag == 0) {
                //
                //                    CGRect frame = weakSelf.listTableView.frame;
                //                    frame.size.height = _senddataArray.count * 60;
                //                    weakSelf.listTableView.frame = frame;
                //
                //                }else {
                //
                //
                //                    CGRect frame = weakSelf.listTableView.frame;
                //                    frame.size.height = _dataArray.count * 60;
                //                    weakSelf.listTableView.frame = frame;
                //                    
                //                }
                
                [weakSelf.showTableView reloadData];
                
            }
            
        });
        
        
    };
    
}
//- (void)getMyReceivedShowDataWithType:(NSString *)type pageSize:(NSInteger)pageSize navIndex:(NSInteger)index filter:(NSString *)filter{
//    
//    
//    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {
//        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
//        //        [SVProgressHUD showWithStatus:@"增在加载..."];
//        NSString * requestBody = [NSString stringWithFormat:
//                                  @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//                                  "<soap12:Envelope "
//                                  "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
//                                  "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
//                                  "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
//                                  "<soap12:Body>"
//                                  "<GetJsonListData xmlns=\"Net.GongHuiTong\">"
//                                  "<logincookie>%@</logincookie>"
//                                  "<datatype>%@</datatype>"
//                                  "<pagesize>%ld</pagesize>"
//                                  "<navindex>%ld</navindex>"
//                                  "<filter>%@</filter>"
//                                  " </GetJsonListData>"
//                                  "</soap12:Body>"
//                                  "</soap12:Envelope>",[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],type,(long)pageSize,(long)index,filter];
//        
//        
//        
//        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"GetJsonListDataResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];
//        
//        
//    }else {
//        
//        [_showTableView.mj_header endRefreshing];
//        // 拿到当前的上拉刷新控件，结束刷新状态
//        [_showTableView.mj_footer endRefreshing];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        
//        
//    }
//    
//    
//    
//}



- (void)getUnionSubjectsDataWithType:(NSString *)type pageSize:(NSInteger)pageSize navIndex:(NSInteger)index filter:(NSString *)filter withTag:(NSInteger)Tag{
    

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
                                  "<GetJsonListData xmlns=\"Net.GongHuiTong\">"
                                  "<logincookie>%@</logincookie>"
                                  "<datatype>%@</datatype>"
                                  "<pagesize>%ld</pagesize>"
                                  "<navindex>%ld</navindex>"
                                  "<filter>%@</filter>"
                                  " </GetJsonListData>"
                                  "</soap12:Body>"
                                  "</soap12:Envelope>",[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],type,(long)pageSize,(long)index,filter];
        
        
        
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"GetJsonListDataResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];
        
        
    }else {
        
        [_showTableView.mj_header endRefreshing];
        // 拿到当前的上拉刷新控件，结束刷新状态
        [_showTableView.mj_footer endRefreshing];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    

    
    
    
}

- (void)sendNotiBtnClicked:(UIButton *)sender {

    [self.navigationController pushViewController:[[SendNotifiactionViewController alloc]init] animated:YES];
    
}

@end

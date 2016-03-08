//
//  TaskViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/2/23.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "TaskViewController.h"
#import "AddTaskViewController.h"
#import "NotiTableViewCell.h"
#import "IndexNotiModel.h"
#import "AddTaskViewController.h"
#import "TaskTableViewCell.h"
#import "NotiDetialViewController.h"
#import "FinshiedTaskViewController.h"
@interface TaskViewController ()<HorizontalMenuDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    ReturnValueBlock returnBlock;
}

@property (nonatomic, strong) HorizontalMenu *menu;//

@property (nonatomic, strong) UITableView    *showTableView;
@property (nonatomic, strong) NSMutableArray *mettingDataArray;
@property (nonatomic, strong) NSMutableArray *otherDataArray;
@property (nonatomic, strong) NSMutableArray *SendDataArray;
@property (nonatomic, strong) NSMutableArray *searchDataArray;
@property (nonatomic, strong) UIView         *topSearchView;
@property (nonatomic, strong) UITextField    *meetingSearchTF;      //
@property (nonatomic, strong) UITextField    *otherSearchTF;      //
@property (nonatomic, strong) UITextField    *sendSearchTF;


@property (nonatomic, assign) NSInteger  pageSize;//每页的个数
@property (nonatomic, assign) NSInteger  pageSendNotiIndex;//从0页开始
@property (nonatomic, assign) NSInteger  pageMeetingNotiIndex;//从0页开始
@property (nonatomic, assign) NSInteger  pageOtherNotiIndex;//从0页开始
@property (nonatomic, assign) NSInteger  requestTag;//从0页开始
@property (nonatomic, assign) BOOL        isHeaderRefersh;
@property (nonatomic, assign) BOOL        isFooterRefersh;
@property (nonatomic, assign) BOOL        isSearch;


@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作任务";
    self.view.backgroundColor = kBackColor;
    
    _pageMeetingNotiIndex = 1;
    _pageOtherNotiIndex = 1;
    _pageSendNotiIndex = 1;
    _pageSize = 8;
    _requestTag = 0;
    
    [self initArray];
    [self configUI];
    
    [self handleRequsetDate];
    [self getTaskDataWithType:@"shoudaodegongzuorenwu" pageSize:_pageSize navIndex:0 filter:@"" withTag:0 ];
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
        _showTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 45, kScreenWidth, kScreenHeight - 45  - 64 - 50) style:UITableViewStylePlain];
        _showTableView.backgroundColor = kBackColor;
        _showTableView.delegate=self;
        _showTableView.dataSource=self;
        
    }
    [self.view addSubview:_showTableView];
}


- (void)configUI {
    
    _menu  = [[HorizontalMenu alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) withTitles:@[@"我收到的任务", @"我发出的任务",@"已结束的任务"]];
    _menu.delegate = self;
    [self.view addSubview:_menu];
    
    
    _topSearchView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, 40)];
    _topSearchView.backgroundColor = kBackColor;
    [self.view addSubview:_topSearchView];

    [self initShowTableView];
    
    
    UIButton *sendNotiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [sendNotiBtn setBackgroundImage:[UIImage imageNamed:@"send"] forState:UIControlStateNormal];
    sendNotiBtn.backgroundColor = kTinColor;
    sendNotiBtn.layer.cornerRadius = 4;
    sendNotiBtn.layer.masksToBounds = 1;
    sendNotiBtn.frame = CGRectMake(20, CGRectGetMaxY(_showTableView.frame) + 5 , kScreenWidth - 40, 40);
    //    sendNotiBtn.alpha = 0.7;
    [sendNotiBtn setTitle:@"新建任务" forState:UIControlStateNormal];
    [sendNotiBtn addTarget:self action:@selector(createTakBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendNotiBtn];
    

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    footer.automaticallyRefresh = NO;

    _showTableView.mj_footer = footer;
    
    _showTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
        _isHeaderRefersh = YES;
        _isFooterRefersh = NO;
        
        
        if (_requestTag == 0) {
            _pageMeetingNotiIndex = 1;
            [self getTaskDataWithType:@"shoudaodegongzuorenwu" pageSize:_pageSize navIndex:0 filter:@"" withTag:0 ];
            
        }else if(_requestTag == 1) {
            _pageOtherNotiIndex = 1;
            [self getTaskDataWithType:@"fachudegongzuorenwu" pageSize:_pageSize navIndex:0 filter:@"" withTag:0 ];
        }else {
            
            _pageSendNotiIndex = 1;
            [self getTaskDataWithType:@"wangchengdegongzuorenwu" pageSize:_pageSize navIndex:0 filter:@"" withTag:0 ];
            
        }
        
    }];
    
    
}


- (void)loadMoreData {
    
    _isFooterRefersh = YES;
    
    if (_requestTag == 0) {
        
        [self getTaskDataWithType:@"shoudaodegongzuorenwu" pageSize:_pageSize navIndex:_pageMeetingNotiIndex filter:@"" withTag:0 ];
        
    }else if(_requestTag == 1) {
        
        [self getTaskDataWithType:@"fachudegongzuorenwu" pageSize:_pageSize navIndex:_pageOtherNotiIndex filter:@"" withTag:0 ];
        
    }else {
        
        
        [self getTaskDataWithType:@"wangchengdegongzuorenwu" pageSize:_pageSize navIndex:_pageSendNotiIndex filter:@"" withTag:0 ];
        
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
    
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[TaskTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    IndexNotiModel *model = [[IndexNotiModel alloc]init];
    
    if(_requestTag == 0){
        model = _mettingDataArray[indexPath.row];
        model.modelTag = @"wsd";
        cell.model = model;

        
    }else if (_requestTag == 1){
        
        model = _otherDataArray[indexPath.row];
        model.modelTag = @"wfc";
        cell.model = model;
        
    }else {
        
        model = _SendDataArray[indexPath.row];
        model.modelTag = @"yjs";
        cell.model = model;
        
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
        noti.modelTag = 1;
//        noti.enum_type = ENUM_DetailTypeModuleSender;
        noti.refreshBlock = ^(BOOL isRefresh){
        
        if (isRefresh) {
                
            [_mettingDataArray removeAllObjects];
            _pageMeetingNotiIndex = 1;
            [self getTaskDataWithType:@"shoudaodegongzuorenwu" pageSize:_pageSize navIndex:0 filter:@"" withTag:0 ];
   
            }

        };
        noti.ChID = [_mettingDataArray[indexPath.row] ChID];
        noti.ExpDate = [_mettingDataArray[indexPath.row] ExpDate];
        [self.navigationController pushViewController:noti animated:YES];
        
        
    }else if (_requestTag == 1){
        
        AddTaskViewController *noti = [[AddTaskViewController alloc]init];
        noti.titleTopc = [_otherDataArray[indexPath.row] ChTopic];
        noti.sendDate = [_otherDataArray[indexPath.row] sendDate];
        noti.receiveNamess = [_otherDataArray[indexPath.row] receiverName];
        noti.content = [_otherDataArray[indexPath.row] chContent];
        noti.extDate = [_otherDataArray[indexPath.row] ExpDate];
        noti.ENUMShowType = ENUM_ShowWithExistInfo;
        noti.postID = [_otherDataArray[indexPath.row] ChID];
        [self.navigationController pushViewController:noti animated:YES];
        
        
    }else {
        
        FinshiedTaskViewController  *contentVc = [[ FinshiedTaskViewController alloc]init];
        contentVc.titleTopic = [_SendDataArray[indexPath.row] ChTopic];
        contentVc.sendDate = [_SendDataArray[indexPath.row] sendDate];
        contentVc.senderName = [_SendDataArray[indexPath.row] senderName];
        contentVc.chid = [_SendDataArray[indexPath.row] ChID];
        contentVc.expDate =[_SendDataArray[indexPath.row]  ExpDate];
        [self.navigationController pushViewController:contentVc animated:YES];
        
    }
    
}

#pragma mark - HorizontalMenuDelegate

- (void)clieckButton:(UIButton *)button
{
    OPLog(@"%ld", button.tag);
    [self.view endEditing:YES];
    switch (button.tag) {
        case 0:
            
            _requestTag = 0;
            _isHeaderRefersh  = NO;//重新归置刷新状态
            _isFooterRefersh = NO;
            
            if (_mettingDataArray.count == 0) {
                
                [self getTaskDataWithType:@"shoudaodegongzuorenwu" pageSize:_pageSize navIndex:0 filter:@"" withTag:0 ];
                
            }else {
                
                [_showTableView reloadData];
            }
            
            
            
            break;
        case 1:
            
        
            
            _requestTag = 1;
            _isHeaderRefersh  = NO;//重新归置刷新状态
            _isFooterRefersh = NO;
            if (_otherDataArray.count == 0) {
                
                [self getTaskDataWithType:@"fachudegongzuorenwu" pageSize:_pageSize navIndex:0 filter:@"" withTag:0 ];
                
            }else {
                
                [_showTableView reloadData];
            }
            
            
            
            
            
            break;
        case 2:
            

            _requestTag = 2;
            _isHeaderRefersh  = NO;//重新归置刷新状态
            _isFooterRefersh = NO;

            if (_SendDataArray.count == 0) {
                
                [self getTaskDataWithType:@"wangchengdegongzuorenwu" pageSize:_pageSize navIndex:0 filter:@"" withTag:0 ];
                
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
                

                [weakSelf.showTableView reloadData];
                
            }
            
        });
        
        
    };
    
}


- (void)getTaskDataWithType:(NSString *)type pageSize:(NSInteger)pageSize navIndex:(NSInteger)index filter:(NSString *)filter withTag:(NSInteger)Tag{
    
    
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

- (void)createTakBtnClicked:(UIButton *)sender {
    
    AddTaskViewController *tak = [[AddTaskViewController alloc]init];
    tak.ENUMShowType = ENUM_ShowWithEditInfo;
    [self.navigationController pushViewController:tak animated:YES];
    
}
@end

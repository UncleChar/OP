//
//  MyConsultViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/19.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "MyConsultViewController.h"
#import "ConsultModel.h"
#import "AddConsultViewController.h"
#import "AchievementModel.h"
#import "ContentViewController.h"
#import "FinalDetailContentViewController.h"
#import "MyDetailCounsultViewController.h"
@interface MyConsultViewController ()<HorizontalMenuDelegate,UITableViewDelegate,UITableViewDataSource>

{
    
    ReturnValueBlock returnBlock;
}
@property (nonatomic, strong) HorizontalMenu *menu;//
@property (nonatomic, strong) UIScrollView   *workBackScrollView;
@property (nonatomic, strong) UIView         *topBackView;
@property (nonatomic, strong) UIView         *workView;
@property (nonatomic, strong) NSMutableArray         *receiveDataArray;
@property (nonatomic, strong) NSMutableArray         *sendDataArray;
@property (nonatomic, strong) UIView         *searchView;

@property (nonatomic, strong) UITableView  *listTableView;
@property (nonatomic, assign) NSInteger  pageSize;//每页的个数
@property (nonatomic, assign) NSInteger  pageSendIndex;//从0页开始
@property (nonatomic, assign) NSInteger  pageReceiveIndex;//从0页开始
@property (nonatomic, assign) NSInteger  requestTag;//从0页开始
@property (nonatomic, assign) BOOL        isHeaderRefersh;
@property (nonatomic, assign) BOOL        isFooterRefersh;



@end

@implementation MyConsultViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的咨询";
    
    if (!_receiveDataArray) {
        
        _receiveDataArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    if (!_sendDataArray) {
        
        _sendDataArray  = [NSMutableArray arrayWithCapacity:0];
    }
    
    
    _menu  = [[HorizontalMenu alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) withTitles:@[ @"我收到的咨询", @"我发出的咨询"]];
    _menu.delegate = self;
    [self.view addSubview:_menu];
    _pageReceiveIndex = 1;
    _pageSendIndex = 1;
    _pageSize = 8;
    
    [self configListView];
    
    [self handleRequsetDate];
    
    [self getMyReceivedShowDataWithType:@"shoudaodeneibuzixun" pageSize:_pageSize navIndex:0 filter:@""];
    
    
}
- (void)configListView {
    
    if (!_listTableView) {
        
        _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, kScreenHeight -  -49  - 64 - 45- 48 - 50) style:UITableViewStylePlain];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.backgroundColor = kBackColor;
        [self.view addSubview:_listTableView];
        
    }
    
    UIButton *createBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    createBtn.frame = CGRectMake(30, CGRectGetMaxY(_listTableView.frame) + 5, (kScreenWidth - 60) , 40);
    //    [exitBtn setBackgroundImage:[UIImage imageNamed:@"矩形-9"] forState:UIControlStateNormal];
    createBtn.backgroundColor = kBtnColor;
    [createBtn addTarget:self action:@selector(createBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [createBtn setTitle:@"新增咨询" forState:UIControlStateNormal];
    createBtn.layer.cornerRadius = 4;
    createBtn.layer.masksToBounds = 1;
    [self.view addSubview:createBtn];
    
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 禁止自动加载
    footer.automaticallyRefresh = NO;
    
    // 设置footer
    _listTableView.mj_footer = footer;
    
    _listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
        _isHeaderRefersh = YES;
        _isFooterRefersh = NO;

        
        if (_requestTag == 0) {
            _pageReceiveIndex = 1;
            [self getMyReceivedShowDataWithType:@"shoudaodeneibuzixun" pageSize:_pageSize navIndex:0 filter:@""];
            
        }else {
            _pageSendIndex = 1;
            [self getMyReceivedShowDataWithType:@"fachudeneibuzixun" pageSize:_pageSize navIndex:0 filter:@""];
        }
        
    }];
    
    
}
- (void)loadMoreData {

    _isFooterRefersh = YES;
    if (_requestTag == 0) {
        
        [self getMyReceivedShowDataWithType:@"shoudaodeneibuzixun" pageSize:_pageSize navIndex:_pageReceiveIndex filter:@""];
        
    }else {
        
        [self getMyReceivedShowDataWithType:@"fachudeneibuzixun" pageSize:_pageSize navIndex:_pageSendIndex filter:@""];
    }

    
    
    
}
- (void)clieckButton:(UIButton *)button
{
    
    
    switch (button.tag) {
        case 0:
            
            _requestTag = 0;
            _isHeaderRefersh  = NO;//重新归置刷新状态
            _isFooterRefersh = NO;
            [_listTableView reloadData];
            if (_receiveDataArray.count == 0) {
                
                [self getMyReceivedShowDataWithType:@"shoudaodeneibuzixun" pageSize:_pageSize navIndex:0 filter:@""];
                
                
                
            }
            
            break;
        case 1:
            
            
            _requestTag = 1;
            _isFooterRefersh = NO;
            _isHeaderRefersh  = NO;//重新归置刷新状态只让chongfu刷新的时候提醒增加的条数
            [_listTableView reloadData];
            if (_sendDataArray.count == 0) {
                
                //
                //            [self getUnionSubjectsDataWithType:@"shoudaodechengguozhanshi" pageSize:0 navIndex:0 filter:[NSString stringWithFormat:@"fld_40_1 like \"%%\""] withTag:0 ];
                [self getMyReceivedShowDataWithType:@"fachudeneibuzixun" pageSize:_pageSize navIndex:0 filter:@""];
                
            }
            
            
            
            break;
            
        default:
            break;
    }
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_requestTag == 0) {
        
        return _receiveDataArray.count;
        
    }
    
    return _sendDataArray.count;
    
}


#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    if (_requestTag == 0) {
        
        
        cell.imageView.image = [UIImage imageNamed:@"iconfont-gongwenbao（合并）-拷贝-5"];
        cell.textLabel.text = [_receiveDataArray[indexPath.row] ChTopic];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@    %@",[_receiveDataArray[indexPath.row] readStatus],[_receiveDataArray[indexPath.row] sendDate]];
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }else {
        
        cell.imageView.image = [UIImage imageNamed:@"iconfont-gongwenbao（合并）-拷贝-5"];
        cell.textLabel.text = [_sendDataArray[indexPath.row] ChTopic];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@    %@",[_sendDataArray[indexPath.row] readStatus],[_sendDataArray[indexPath.row] FinshDate]];
        cell.detailTextLabel.textColor = [UIColor grayColor];
        
    }
    
    cell.selectionStyle = 0;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MyDetailCounsultViewController  *contentVc = [[ MyDetailCounsultViewController alloc]init];

    if (_requestTag == 0) {
 
        contentVc.dataType = @"shoudaodeneibuzixun";
        contentVc.chID = [_receiveDataArray[indexPath.row] ChID];
        contentVc.sendDate = [_receiveDataArray[indexPath.row] sendDate];
        contentVc.ChTopic = [_receiveDataArray[indexPath.row] ChTopic];
        contentVc.showTitle = @"收到的咨询";
        
    }else {
        
        contentVc.dataType = @"fachudeneibuzixun";
        contentVc.chID = [_sendDataArray[indexPath.row] ChID];
        contentVc.sendDate = [_sendDataArray[indexPath.row] sendDate];
        contentVc.isRep = YES;
        contentVc.ChTopic = [_sendDataArray[indexPath.row]ChTopic];
        contentVc.showTitle = @"发出的咨询";

    }

    [self.navigationController pushViewController:contentVc animated:YES];
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}


- (void)handleRequsetDate {
    
    __weak typeof(self) weakSelf = self;
    returnBlock = ^(id resultValue){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.listTableView.mj_header endRefreshing];
            // 拿到当前的上拉刷新控件，结束刷新状态
            [weakSelf.listTableView.mj_footer endRefreshing];
            //            [weakSelf.dataArray removeAllObjects];
            
            
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
                [weakSelf.listTableView reloadData];
                
                [SVProgressHUD showErrorWithStatus:@"没有更多的数据哦"];
                
            }else {
                
                
                
                NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                
                OPLog(@"------%@----------",[listDic objectForKey:@"rows"]);
                
                NSInteger countArray = 0;
                if (weakSelf.isFooterRefersh) {
                    if (_requestTag == 0) {
                        
                        weakSelf.pageReceiveIndex ++;
                        countArray = weakSelf.receiveDataArray.count;
                        
                    }else {
                        countArray =weakSelf.sendDataArray.count;
                        weakSelf.pageSendIndex ++;
                    }
                    
                }
                
                if (weakSelf.isHeaderRefersh) {
                    
                    if (_requestTag == 0) {
                        
                        [weakSelf.receiveDataArray removeAllObjects];
                    }else {
                        
                        
                        [weakSelf.sendDataArray removeAllObjects];
                    }
                    
                    weakSelf.isHeaderRefersh = NO;
                    
                }
                
                for (NSDictionary *dict in [listDic objectForKey:@"rows"]) {
                    AchievementModel  *model = [[AchievementModel alloc]init];
                    
                    [model setValuesForKeysWithDictionary:dict];
                    
                    
                    if (_requestTag == 0) {
                        
                        [weakSelf.receiveDataArray addObject:model];
                    }else {
                        
                        [weakSelf.sendDataArray addObject:model];
                    }
                    
                }
                
                
                if (weakSelf.isFooterRefersh) {
                    
                    if (_requestTag == 0) {
                        
                        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"增加了%ld条内容", weakSelf.receiveDataArray.count - countArray]];
                        
                    }else {
                        
                        
                        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"增加了%ld条内容", weakSelf.sendDataArray.count - countArray]];
                        
                        
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

                [weakSelf.listTableView reloadData];
                
            }
            
        });
        
        
    };
    
}


- (void)getMyReceivedShowDataWithType:(NSString *)type pageSize:(NSInteger)pageSize navIndex:(NSInteger)index filter:(NSString *)filter{
    
    
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
        
        [_listTableView.mj_header endRefreshing];
        // 拿到当前的上拉刷新控件，结束刷新状态
        [_listTableView.mj_footer endRefreshing];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    
    
}

- (void)createBtnClicked:(UIButton *)sender {


    [self.navigationController pushViewController:[[AddConsultViewController alloc]init] animated:YES];
    
}
@end

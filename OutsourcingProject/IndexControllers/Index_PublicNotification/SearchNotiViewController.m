//
//  SearchNotiViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/3/4.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "SearchNotiViewController.h"
#import "SendingDetailViewController.h"
#import "NotiDetialViewController.h"
#import "NotiTableViewCell.h"
#import "IndexNotiModel.h"
#define WeakSelf __weak typeof(self) weakSelf = self;
@interface SearchNotiViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate>
{
    
    ReturnValueBlock returnBlock;
}
@property (nonatomic, strong) UITableView *subjectTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger  pageSize;//每页的个数
@property (nonatomic, assign) NSInteger  pageIndex;//从0页开始

@property (nonatomic, assign) BOOL        isHeaderRefersh;
@property (nonatomic, assign) BOOL        isFooterRefersh;
@property (nonatomic, assign) BOOL        isOnceShow;
@end

@implementation SearchNotiViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = self.subjectTitle;
    _pageIndex = 1;
    _pageSize = 8;
    
    _isOnceShow = YES;
    
    if (!_subjectTableView) {
        _subjectTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 20) style:UITableViewStylePlain];
        _subjectTableView.delegate=self;
        _subjectTableView.dataSource=self;
        _subjectTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            _isHeaderRefersh = YES;
            _isFooterRefersh = NO;
            _pageIndex = 1;
            
            [self getNotiDetailWithType:self.dataType pageSize:_pageSize navIndex:0 filter:self.filter];
            
        }];
        
        
    }
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 禁止自动加载
    footer.automaticallyRefresh = NO;
    
    // 设置footer
    _subjectTableView.mj_footer = footer;
    
    
    [self.view addSubview:_subjectTableView];
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    [self handleRequsetDate];
    NSLog(@"搜索的类型:%@  搜索的字符串:%@",self.dataType,self.filter);
    [self getNotiDetailWithType:self.dataType pageSize:_pageSize navIndex:0 filter:self.filter];
    
    
}

- (void)loadMoreData {
    
    _isFooterRefersh = YES;
    [self getNotiDetailWithType:self.dataType pageSize:_pageSize navIndex:_pageIndex filter:self.filter];
    
    
    
    
}
- (void)handleRequsetDate {
    
    __weak typeof(self) weakSelf = self;
    returnBlock = ^(id resultValue){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.subjectTableView.mj_header endRefreshing];
            
            // 拿到当前的上拉刷新控件，结束刷新状态
            [weakSelf.subjectTableView.mj_footer endRefreshing];
            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            OPLog(@"-FF-%@",[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]);
            if ([NSNull null] ==[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]) {
                
                [SVProgressHUD showErrorWithStatus:@"没有更多的数据哦"];
                
                //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"暂时无更多数据哦" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                //                [alert show];
                
                OPLog(@" error !");
                
                
            }else {
                
                NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                
                
                OPLog(@"------%@----------",[listDic objectForKey:@"rows"]);
                
                
                NSInteger countArray = 0;
                if (weakSelf.isFooterRefersh) {
                    
                    countArray =weakSelf.dataArray.count;
                    weakSelf.pageIndex ++;

                    
                }
                
                if (weakSelf.isHeaderRefersh) {
                    
                    
                    [weakSelf.dataArray removeAllObjects];

                    weakSelf.isHeaderRefersh = NO;
                    
                }
                
                for (NSDictionary *dict in [listDic objectForKey:@"rows"]) {
                    IndexNotiModel  *model = [[IndexNotiModel alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    [weakSelf.dataArray addObject:model];
                    
                }
                
                
                if (weakSelf.isFooterRefersh) {
                    
                    
                    
                    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"增加了%ld条内容", weakSelf.dataArray.count - countArray]];
                    
                    
                    
                }else if(weakSelf.isHeaderRefersh) {
                    
                    
                    [SVProgressHUD showSuccessWithStatus:@"加载完成"];
                }else {
                
                
                    [SVProgressHUD showSuccessWithStatus:@"搜索完成"];
                    
                }

                [weakSelf.subjectTableView reloadData];
                
            }
            
        });
        
    };
    
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

    cell.selectionStyle = 0;
    return cell;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    FinalDetailContentViewController  *contentVc = [[ FinalDetailContentViewController alloc]init];
    
    
    if(self.MokuaiTag == 2){
        
        
        SendingDetailViewController  *contentVc = [[ SendingDetailViewController alloc]init];
        contentVc.ChTopic = [_dataArray[indexPath.row] ChTopic];;
        contentVc.chContent = [_dataArray[indexPath.row] chContent];
        contentVc.isReceipt = [_dataArray[indexPath.row] isReceipt];
        contentVc.sendDate = [_dataArray[indexPath.row] sendDate];
        contentVc.senderName = [_dataArray[indexPath.row] senderName];
        contentVc.chID = [_dataArray[indexPath.row] ChID];
        [self.navigationController pushViewController:contentVc animated:YES];

        
        
    }else {
        
        NotiDetialViewController *noti = [[NotiDetialViewController alloc]init];
        noti.modelTag = 0;
        noti.ChID = [_dataArray[indexPath.row] ChID];
        [self.navigationController pushViewController:noti animated:YES];
        
        
    }

    
    
    
}


- (void)getNotiDetailWithType:(NSString *)type pageSize:(NSInteger)pageSize navIndex:(NSInteger)index filter:(NSString *)filter{
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        
        
        if (_isOnceShow ) {
            
            [SVProgressHUD showSuccessWithStatus:@"加载完成"];
        }
        
        
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
        
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"GetJsonListDataResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];
        
    }else {
        
        [_subjectTableView.mj_header endRefreshing];
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [_subjectTableView.mj_footer endRefreshing];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
    }
    
}



@end

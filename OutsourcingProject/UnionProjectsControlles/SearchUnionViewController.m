//
//  SearchUnionViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/3/9.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "SearchUnionViewController.h"
#import "ShowMapModel.h"
#import "ShowMapViewCell.h"
#import "UnionInfoViewController.h"

@interface SearchUnionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    ReturnValueBlock returnBlock;
}
@property (nonatomic, strong) UITableView *favorTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger  pageSize;//每页的个数
@property (nonatomic, assign) NSInteger  pageIndex;//从0页开始
@property (nonatomic, assign) NSInteger  pageSendIndex;//从0页开始
@property (nonatomic, assign) NSInteger  requestTag;//从0页开始
@property (nonatomic, assign) BOOL        isHeaderRefersh;
@property (nonatomic, assign) BOOL        isFooterRefersh;
@end
@implementation SearchUnionViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"工会列表";
    if (!_favorTableView) {
        _favorTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        
        _favorTableView.delegate=self;
        _favorTableView.dataSource=self;
        //        _favorTableView.scrollEnabled = NO;
        
    }
    [self.view addSubview:_favorTableView];
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    _pageIndex = 1;
    _pageSize = 8;
    [self handleRequsetDate];
    
    //    Gonghuimingcheng like “%关键字%” or gonghuidaima like “%关键字%”  or gonghuidizhilike “%关键字%”  or gonghuizhuxilike “%关键字%”
    
    
//    NSString *filter = [NSString stringWithFormat:@"Gonghuimingcheng like \"%%%@%%\"",@"工"];
    
    [self getSearchDataWithType:@"gonghuixinxi" pageSize:_pageSize navIndex:0 filter:self.filter];

    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 禁止自动加载
    footer.automaticallyRefresh = NO;
    
    // 设置footer
    _favorTableView.mj_footer = footer;
    
    _favorTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
        _isHeaderRefersh = YES;
        _isFooterRefersh = NO;
        
        [self getSearchDataWithType:@"gonghuixinxi" pageSize:_pageSize navIndex:0 filter:@""];
        
        
    }];
    
    
    
    
}
- (void)loadMoreData {
    
    
    
    _isFooterRefersh = YES;
    
    [self getSearchDataWithType:@"gonghuixinxi" pageSize:_pageSize navIndex:_pageIndex filter:@""];
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    
    ShowMapViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[ShowMapViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    cell.model = _dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
        UnionInfoViewController *infoVC = [[UnionInfoViewController alloc]init];
    
            infoVC.name = [_dataArray[indexPath.row] gonghuimingcheng];
            infoVC.address = [_dataArray[indexPath.row] gonghuidizhi];
            infoVC.code = [_dataArray[indexPath.row] gonghuidaima];
            infoVC.createTime = [_dataArray[indexPath.row] gonghuichenglishijian];
            infoVC.president = [_dataArray[indexPath.row] gonghuizhuxi];
            infoVC.longitude = [_dataArray[indexPath.row] longitude];
            infoVC.latitude = [_dataArray[indexPath.row] latitude];
    
        [self.navigationController pushViewController:infoVC animated:YES];
    
    
}



- (void)handleRequsetDate {
    
    __weak typeof(self) weakSelf = self;
    returnBlock = ^(id resultValue){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.favorTableView.mj_header endRefreshing];
            // 拿到当前的上拉刷新控件，结束刷新状态
            [weakSelf.favorTableView.mj_footer endRefreshing];
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
                [weakSelf.favorTableView reloadData];
                
                [SVProgressHUD showErrorWithStatus:@"没有更多的数据哦"];
                
            }else {
                
                
                
                NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                
                OPLog(@"----far--%@----------",[listDic objectForKey:@"rows"]);
                
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
                    ShowMapModel  *model = [[ShowMapModel alloc]init];
                    
                    [model setValuesForKeysWithDictionary:dict];
                    
                    [weakSelf.dataArray addObject:model];
                    

                    
                    
                }
                
                if (weakSelf.isFooterRefersh) {
                    
                    
                    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"增加了%ld条内容", weakSelf.dataArray.count - countArray]];
                    
                    
                }else {
                    
                    
                    [SVProgressHUD showSuccessWithStatus:@"加载完成"];
                }
                
                
                
                
                [weakSelf.favorTableView reloadData];
                
            }
            
        });
        
        
    };
    
}


- (void)getSearchDataWithType:(NSString *)type pageSize:(NSInteger)pageSize navIndex:(NSInteger)index filter:(NSString *)filter{
    
    
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
        [_favorTableView.mj_header endRefreshing];
        // 拿到当前的上拉刷新控件，结束刷新状态
        [_favorTableView.mj_footer endRefreshing];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    
    
}


@end

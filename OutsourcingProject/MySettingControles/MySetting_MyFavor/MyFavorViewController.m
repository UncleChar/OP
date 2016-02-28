//
//  MyFavorViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/19.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "MyFavorViewController.h"
#import "AchievementModel.h"
#import "FuckingViewController.h"
#import "ContentViewController.h"
@interface MyFavorViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate>
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

@implementation MyFavorViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"我的收藏";
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
    _pageIndex = 0;
    _pageSize = 8;
    [self handleRequsetDate];
    
    [self getMyReceivedShowDataWithType:@"wodeshoucang" pageSize:_pageSize navIndex:0 filter:@""];
    
    
    
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 禁止自动加载
    footer.automaticallyRefresh = NO;
    
    // 设置footer
    _favorTableView.mj_footer = footer;
    
    _favorTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
        _isHeaderRefersh = YES;
        _isFooterRefersh = NO;
        _pageIndex = 1;
            
            [self getMyReceivedShowDataWithType:@"wodeshoucang" pageSize:_pageSize navIndex:0 filter:@""];

        
    }];




}
- (void)loadMoreData {
    

    
    _isFooterRefersh = YES;
    
     [self getMyReceivedShowDataWithType:@"wodeshoucang" pageSize:_pageSize navIndex:_pageIndex filter:@""];

    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
        cell.imageView.image = [UIImage imageNamed:@"iconfont-shoucang(2)（合并）-拷贝"];
//        cell.textLabel.text = _cellTitleArray[indexPath.row];

        cell.textLabel.text =[_dataArray[indexPath.row] ChTopic];
    if ( [[_dataArray[indexPath.row] dataType] isEqualToString:@"chengguozhanshi"]) {
        
        cell.detailTextLabel.text = @"成果展示";
    }
//        cell.detailTextLabel.text = [_dataArray[indexPath.row] DataType];
//    OPLog(@"dd %@",[_dataArray[indexPath.row] DataType]);
        cell.detailTextLabel.textColor = [UIColor grayColor];


    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContentViewController *fuck = [[ContentViewController alloc]init];
    fuck.dataType = [_dataArray[indexPath.row] dataType];
    fuck.chID = [_dataArray[indexPath.row] ChID];
     fuck.titleTop = [_dataArray[indexPath.row] ChTopic];
    
    [self.navigationController pushViewController:fuck animated:YES];
//    [self getTreeUserSysDeptwith:[_dataArray[indexPath.row] dataType] chid:[[_dataArray[indexPath.row] ChID] integerValue]];

    
}


- (void)getTreeUserSysDeptwith:(NSString *)datatype chid:(NSInteger) chid {
    
    
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
                                  "<GetJsonContentData xmlns=\"Net.GongHuiTong\">"
                                  "<logincookie>%@</logincookie>"
                                  "<datatype>%@</datatype>"
                                   "<ChID>%ld</ChID>"
                                  " </GetJsonContentData>"
                                  "</soap12:Body>"
                                  "</soap12:Envelope>",[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],datatype,chid];
        
        ReturnValueBlock returnBlock = ^(id resultValue){
            OPLog(@"%@",[[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"]);
            if ([NSNull null] ==[[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"]) {
                
                //                dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD showErrorWithStatus:@"没有更多的数据哦"];
                //                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Account or password error!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                //                            [alert show];
                
                OPLog(@"rrrrrrrrrrrrrerror: account or password error !");
                //                    [SVProgressHUD showErrorWithStatus:@"Account or password error!"];
                //
                //                });
                
            }else {
                
                NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                [SVProgressHUD showSuccessWithStatus:@"加载完成"];
                OPLog(@"%@",listDic);
                
            }
            
        };
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"GetJsonContentDataResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];
        
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
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
                    AchievementModel  *model = [[AchievementModel alloc]init];
                    
                    [model setValuesForKeysWithDictionary:dict];
                    
                    [weakSelf.dataArray addObject:model];
                    
                    OPLog(@"--- %@",model.dataType);

                    
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
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    
    
}

@end

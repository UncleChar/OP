//
//  ActivityViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/24.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "ActivityViewController.h"
#import "SubGuideModel.h"
#import "ActivityDetailViewController.h"
#import "AddActivityViewController.h"
@interface ActivityViewController ()<HorizontalMenuDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    
    ReturnValueBlock returnBlock;
}
@property (nonatomic, strong) HorizontalMenu *menu;//
@property (nonatomic, strong) UIScrollView   *workBackScrollView;
@property (nonatomic, strong) UIView         *topBackView;
@property (nonatomic, strong) UIView         *workView;
@property (nonatomic, strong) NSMutableArray         *receivedataArray;
@property (nonatomic, strong) NSMutableArray         *senddataArray;
@property (nonatomic, strong) UIView         *searchView;

@property (nonatomic, strong) UITableView  *listTableView;
@property (nonatomic, assign) NSInteger  pageSize;//每页的个数
@property (nonatomic, assign) NSInteger  pageIndex;//从0页开始
@property (nonatomic, assign) NSInteger  pageSendIndex;//从0页开始
@property (nonatomic, assign) NSInteger  requestTag;//从0页开始
@property (nonatomic, assign) BOOL        isHeaderRefersh;
@property (nonatomic, assign) BOOL        isFooterRefersh;


@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作动态";
    if (!_receivedataArray) {
        
        _receivedataArray = [NSMutableArray arrayWithCapacity:0];
    }
    if (!_senddataArray) {
        
        _senddataArray  = [NSMutableArray arrayWithCapacity:0];
    }
    _menu  = [[HorizontalMenu alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) withTitles:@[@"我收到的动态", @"我发出的动态"]];
    _menu.delegate = self;
    [self.view addSubview:_menu];
    _pageIndex = 1;
    _pageSendIndex = 0;
    _pageSize = 8;
    
    [self configListView];
    
    [self handleRequsetDate];
    
    [self getMyReceivedShowDataWithType:@"shoudaodegongzuodongtai" pageSize:_pageSize navIndex:0 filter:@""];
    
    
}
- (void)configListView {
    
    if (!_listTableView) {
        
        _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, kScreenHeight -  -49  - 64 - 45- 48 - 50) style:UITableViewStylePlain];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.backgroundColor = kBackColor;
        [self.view addSubview:_listTableView];
        
    }
    
    UIButton  *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.backgroundColor = kTestColor;
    submitBtn.tag = 888 + 4;
    //    [submitBtn setBackgroundImage:[UIImage imageNamed:@"矩形-9"] forState:UIControlStateNormal];
    submitBtn.backgroundColor = kBtnColor;
    [submitBtn setTitle:@"新建动态" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius = 4;
    submitBtn.layer.masksToBounds = 1;
    submitBtn.frame = CGRectMake(20, CGRectGetMaxY(_listTableView.frame) + 5, kScreenWidth - 40, 40);
    [self.view addSubview:submitBtn];


    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    footer.automaticallyRefresh = NO;

    _listTableView.mj_footer = footer;

    
    _listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
        _isHeaderRefersh = YES;
        _isFooterRefersh = NO;
        _pageIndex = 1;
        if (_requestTag == 0) {
            
            [self getMyReceivedShowDataWithType:@"shoudaodegongzuodongtai" pageSize:_pageSize navIndex:0 filter:@""];
            
        }else {
            
            [self getMyReceivedShowDataWithType:@"fachudegongzuodongtai" pageSize:_pageSize navIndex:0 filter:@""];
        }
        
    }];
    
    
}
- (void)loadMoreData {

    _isFooterRefersh = YES;
    if (_requestTag == 0) {
        
        [self getMyReceivedShowDataWithType:@"shoudaodegongzuodongtai" pageSize:_pageSize navIndex:_pageIndex filter:@""];
        
    }else {
        
        [self getMyReceivedShowDataWithType:@"fachudegongzuodongtai" pageSize:_pageSize navIndex:_pageIndex filter:@""];
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
            if (_receivedataArray.count == 0) {
                
                [self getMyReceivedShowDataWithType:@"shoudaodegongzuodongtai" pageSize:_pageSize navIndex:0 filter:@""];
                
                
                
            }
            
            break;
        case 1:
            
            
            _requestTag = 1;
            _isFooterRefersh = NO;
            _isHeaderRefersh  = NO;//重新归置刷新状态只让chongfu刷新的时候提醒增加的条数
            [_listTableView reloadData];
            if (_senddataArray.count == 0) {

                [self getMyReceivedShowDataWithType:@"fachudegongzuodongtai" pageSize:_pageSize navIndex:0 filter:@""];
                
            }
            
            
            
            break;
            
        default:
            break;
    }
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_requestTag == 0) {
        
        return _receivedataArray.count;
        
    }
    
    return _senddataArray.count;
    
}


#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    if (_requestTag == 0) {
        
        
        cell.imageView.image = [UIImage imageNamed:@"iconfont-iconfont73（合并）-拷贝-3"];
        cell.textLabel.text = [_receivedataArray[indexPath.row] ChTopic];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[_receivedataArray[indexPath.row] sendDate]];
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }else {
        
        cell.imageView.image = [UIImage imageNamed:@"iconfont-iconfont73（合并）-拷贝-3"];
        cell.textLabel.text = [_senddataArray[indexPath.row] ChTopic];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[_senddataArray[indexPath.row] sendDate]];
        cell.detailTextLabel.textColor = [UIColor grayColor];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        ActivityDetailViewController *fuck = [[ActivityDetailViewController alloc]init];
    
    if (_requestTag == 0) {
        
        fuck.ChTopic = [_receivedataArray[indexPath.row] ChTopic];
        fuck.chContent = [_receivedataArray[indexPath.row] chContent];
        fuck.sendDate = [_receivedataArray[indexPath.row] sendDate];
        fuck.senderName = [_receivedataArray[indexPath.row] senderName];
        fuck.ChID = [_receivedataArray[indexPath.row] ChID];
        fuck.blockTag = 0;
        
    }else {
    
        fuck.ChTopic = [_senddataArray[indexPath.row] ChTopic];
        fuck.chContent = [_senddataArray[indexPath.row] chContent];
        fuck.sendDate = [_senddataArray[indexPath.row] sendDate];
        fuck.receiverName = [_senddataArray[indexPath.row] receiverName];
        fuck.ChID = [_senddataArray[indexPath.row] ChID];
         fuck.blockTag = 1;
    
    }

    
    fuck.deleteBlock = ^(NSInteger deleteTag){

        _isHeaderRefersh = YES;
        _isFooterRefersh = NO;
        _pageIndex = 1;
        if (deleteTag == 0) {
            
            [self getMyReceivedShowDataWithType:@"shoudaodegongzuodongtai" pageSize:_pageSize navIndex:0 filter:@""];
            
        }else {
            
            [self getMyReceivedShowDataWithType:@"fachudegongzuodongtai" pageSize:_pageSize navIndex:0 filter:@""];
        }
    
    };

    [self.navigationController pushViewController:fuck animated:YES];
    
    
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

                
                [weakSelf.listTableView reloadData];
                
                [SVProgressHUD showErrorWithStatus:@"没有更多的数据哦"];
                
            }else {

//                NSString *filterString = [[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] stringByReplacingOccurrencesOfString:@"  " withString:@""];
//                filterString = [filterString stringByReplacingOccurrencesOfString:@" " withString:@""];
                NSError *error;
                NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
                
                
//
                
                NSString *jsonString = [[resultValue lastObject] objectForKey:@"GetJsonListDataResult"];

//                
                OPLog(@"------%@----------",listDic);
//
                
                SBJSON *jsonParser = [[SBJSON alloc] init];
                
                NSError *parseError = nil;
                NSDictionary * result = [jsonParser objectWithString:jsonString
                                                               error:&parseError];
                NSLog(@"jsonParseggggggggggrresult:%@",result);
                
                NSInteger countArray = 0;
                if (weakSelf.isFooterRefersh) {
                    if (_requestTag == 0) {
                        
                        weakSelf.pageSendIndex ++;
                        countArray = weakSelf.receivedataArray.count;
                        
                    }else {
                        countArray =weakSelf.senddataArray.count;
                        weakSelf.pageIndex ++;
                    }
                    
                }
                
                if (weakSelf.isHeaderRefersh) {
                    
                    if (_requestTag == 0) {
                        
                        [weakSelf.receivedataArray removeAllObjects];
                    }else {
                        
                        
                        [weakSelf.senddataArray removeAllObjects];
                    }
                    
                    weakSelf.isHeaderRefersh = NO;
                    
                }
                
                for (NSDictionary *dict in [result objectForKey:@"rows"]) {
                    SubGuideModel  *model = [[SubGuideModel alloc]init];
                    
                    [model setValuesForKeysWithDictionary:dict];
                    
                    
                    if (_requestTag == 0) {
                        
                        [weakSelf.receivedataArray addObject:model];
                    }else {
                        
                        [weakSelf.senddataArray addObject:model];
                    }
                    
                }
                
                
                if (weakSelf.isFooterRefersh) {
                    
                    if (_requestTag == 0) {
                        
                        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"增加了%ld条内容", weakSelf.receivedataArray.count - countArray]];
                        
                    }else {
                        
                        
                        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"增加了%ld条内容", weakSelf.senddataArray.count - countArray]];
                        
                        
                    }
                    
                }else {
                    
                    
                    [SVProgressHUD showSuccessWithStatus:@"加载完成"];
                }
                
                [weakSelf.listTableView reloadData];
                
            }
            
        });
        
    };
    
}


- (void)getMyReceivedShowDataWithType:(NSString *)type pageSize:(NSInteger)pageSize navIndex:(NSInteger)index filter:(NSString *)filter{
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    
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

        [_listTableView.mj_footer endRefreshing];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    
    
}

- (void)addBtnClicked:(UIButton *)sender {
    
    [self.navigationController pushViewController:[[AddActivityViewController alloc]init] animated:YES];
    
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:YES];
    
}

@end

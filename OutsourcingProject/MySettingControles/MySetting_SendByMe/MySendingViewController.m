//
//  MySendingViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/19.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "MySendingViewController.h"

@interface MySendingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray         *dataArray;


@property (nonatomic, strong) UITableView  *listTableView;



@end

@implementation MySendingViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我发出的通知";
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    [self configListView];
    
    [self getUnionSubjectsDataWithType:@"fachudetongzhi" pageSize:0 navIndex:0 filter:@"" withTag:0 ];

}

- (void)configListView {
    
    if (!_listTableView) {
        
        _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight -  -49  - 64 - 48) style:UITableViewStylePlain];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.backgroundColor = kBackColor;
        [self.view addSubview:_listTableView];
    }
    
    _listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
        for (int i = 0; i < 4; i ++) {
            
            
            
        }
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            [NSThread sleepForTimeInterval:5];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                
                [_listTableView.mj_header endRefreshing];
                [_listTableView reloadData];
                
            });
        });
    }];
    
    
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
    
    cell.imageView.image = [UIImage imageNamed:@"iconfont-gongwenbao（合并）-拷贝-5"];
//    cell.textLabel.text = [_dataArray[indexPath.row] ChTopic];
    
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@    %@",[_dataArray[indexPath.row] dataType],[_dataArray[indexPath.row] FinshDate]];
    
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    //    cell.detailTextLabel.font = [UIFont systemFontOfSize:<#(CGFloat)#>]
    
    return cell;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//
//
//
//}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
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
                OPLog(@"-sendNoti-%@",[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] class]);
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
                    
//                    for (NSDictionary *dict in [listDic objectForKey:@"rows"]) {
//                        AchievementModel  *model = [[AchievementModel alloc]init];
//                        
//                        [model setValuesForKeysWithDictionary:dict];
//                        [_dataArray addObject:model];
//                        
//                    }
                    
//                    for (AchievementModel *model in _dataArray) {
//                        
//                        OPLog(@"%@   %@",model.senderName,model.chContent);
//                    }
//                    
                    [_listTableView reloadData];
                    
                    
                    
                    
                    
                    
                }
                
                
                
            });
            
            
        };
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"GetJsonListDataResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];
        
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    
    
}




@end

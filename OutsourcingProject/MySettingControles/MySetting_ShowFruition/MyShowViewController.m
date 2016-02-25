//
//  MyShowViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/19.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "MyShowViewController.h"
#import "AchievementModel.h"
@interface MyShowViewController ()<HorizontalMenuDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) HorizontalMenu *menu;//
@property (nonatomic, strong) UIScrollView   *workBackScrollView;
@property (nonatomic, strong) UIView         *topBackView;
@property (nonatomic, strong) UIView         *workView;
@property (nonatomic, strong) NSMutableArray         *dataArray;
@property (nonatomic, strong) UIView         *searchView;

@property (nonatomic, strong) UITableView  *listTableView;


@end

@implementation MyShowViewController
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的成果展示";
    
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    
    _menu  = [[HorizontalMenu alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) withTitles:@[ @"我发出的成果", @"我收到的成果"]];
    _menu.delegate = self;
    [self.view addSubview:_menu];
    
    [self configListView];
    
    [self getUnionSubjectsDataWithType:@"fachudechengguozhanshi" pageSize:0 navIndex:0 filter:@"" withTag:0 ];
    


}
- (void)configListView {
    
    if (!_listTableView) {
        
        _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, kScreenHeight -  -49  - 64 - 45- 48) style:UITableViewStylePlain];
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

- (void)clieckButton:(UIButton *)button
{
    
    
    switch (button.tag) {
        case 0:
            
            [self getUnionSubjectsDataWithType:@"fachudechengguozhanshi" pageSize:0 navIndex:0 filter:@"" withTag:0 ];
            
            
            break;
        case 1:
            
            [self getUnionSubjectsDataWithType:@"shoudaodegongzuodongtai" pageSize:0 navIndex:0 filter:@"" withTag:0 ];
            

            
            break;
            
        default:
            break;
    }
    

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
    cell.textLabel.text = [_dataArray[indexPath.row] ChTopic];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@    %@",[_dataArray[indexPath.row] dataType],[_dataArray[indexPath.row] FinshDate]];

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
                    

                    
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您还没有发出的成果哦" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                    [alert show];
                    
                    OPLog(@"rrrrrrrrrrrrrerror: account or password error !");

                    
                }else {
                    
                    NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                    
//                    OPLog(@"%@",listDic);
                    
                    OPLog(@"------%@----------",[listDic objectForKey:@"rows"]);
                    
                    for (NSDictionary *dict in [listDic objectForKey:@"rows"]) {
                        AchievementModel  *model = [[AchievementModel alloc]init];
                    
                        [model setValuesForKeysWithDictionary:dict];
                        [_dataArray addObject:model];
                        
                    }
                    
                    for (AchievementModel *model in _dataArray) {
                        
                        OPLog(@"%@   %@",model.senderName,model.chContent);
                    }
                    
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

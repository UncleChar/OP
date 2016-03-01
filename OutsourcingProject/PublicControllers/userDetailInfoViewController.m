//
//  ContactViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/20.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "UserDetailInfoViewController.h"
#import "Users.h"
@interface UserDetailInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate>
{
    
//    ReturnValueBlock returnBlock;
    
}

@property (nonatomic, strong) UITableView  *detailTableView;
@property (nonatomic, strong) NSArray      *cellTitleArray;
@property (nonatomic, strong) NSArray      *cellImgArray;
@property (nonatomic, strong) NSMutableArray      *infoArray;

@end

@implementation UserDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息详情";
    [self initArray];
    [self.view addSubview:[self tableView]];

}



- (void)initArray {
    
    if (!_cellTitleArray) {
        
        _cellTitleArray = @[@"姓名",@"手机",@"办公室电话",@"性别",@"职务",@"部门",@"居住地址",@"邮箱"];
    }
    if (!_cellImgArray) {
        
        _cellImgArray = @[@"iconfont-xingming",@"iconfont-shouji",@"iconfont-shouji(1)",@"iconfont-ren(1)-拷贝",@"iconfont-zanwuneirong",@"iconfont-zhifutijiao",@"iconfont-address",@"iconfont-youxiang"];
    }
    if (!_infoArray) {
        _infoArray = [[NSMutableArray alloc]init];
    
    }
    
    [self getMyReceivedShowDataWithType:@"tongxunlu" ChID:[self.userID integerValue]];

}

-(UITableView*)tableView
{
    if (!_detailTableView) {
        _detailTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth, 8 * 45 + 9 ) style:UITableViewStylePlain];
        
        _detailTableView.delegate=self;
        _detailTableView.dataSource=self;
        _detailTableView.scrollEnabled = NO;
        _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _detailTableView;
}


//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    return 8;
//}
//
//#pragma mark - UITableViewDataSource
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString *cellID = @"cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (nil == cell) {
//        
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        
//        cell.imageView.image = [UIImage imageNamed:_cellImgArray[indexPath.row]];
//        cell.textLabel.text = _cellTitleArray[indexPath.row];
//    
//    NSString *tt = @"我就是测试一下";
//    
//    if (indexPath.row == 0) {
//        if (self.userName) {
//           
//            tt  = self.userName;
//        }
//        
//    }
//    if (indexPath.row == 5) {
//    
//        if (self.userDept) {
//            tt = self.userDept;
//        }
//        
//    }
//        cell.detailTextLabel.text = tt;
//
//    
//    cell.detailTextLabel.textColor = [UIColor blackColor];
////        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//
//    
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return 40;
//}
//




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _infoArray.count * 2 + 1;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    if ((indexPath.row + 1) % 2 == 1) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kBackColor;

        
    }else {
  
        cell.imageView.image = [UIImage imageNamed:_cellImgArray[(indexPath.row + 1) / 2 - 1]];
        cell.textLabel.text = _cellTitleArray[(indexPath.row + 1) / 2 - 1];
        cell.detailTextLabel.text = _infoArray[(indexPath.row + 1) / 2 - 1];
//        cell.backgroundColor = kBtnColor;

        
    }
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if ((indexPath.row + 1 ) % 2 == 1) {
        
        return 1;
        
    }else {
        
        return 45;
        
    }
    
    
    
    
    
    
    
}

//- (void)handleRequsetDate {
//    
//    __weak typeof(self) weakSelf = self;
//    returnBlock = ^(id resultValue){
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            OPLog(@"-FF-%@",[[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"]);
//            OPLog(@"-show-%@",[[[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"] class]);
//            if ([NSNull null] ==[[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"]) {
//
////                [weakSelf.favorTableView reloadData];
//                
//                [SVProgressHUD showErrorWithStatus:@"没有更多的数据哦"];
//                
//            }else {
//                
//                
//                
//                NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
//                
//                OPLog(@"----far--%@----------",[listDic objectForKey:@"rows"]);
//                
////                NSInteger countArray = 0;
////                if (weakSelf.isFooterRefersh) {
////                    
////                    countArray =weakSelf.dataArray.count;
////                    weakSelf.pageIndex ++;
////                    
////                }
////                
////                if (weakSelf.isHeaderRefersh) {
////                    
////                    
////                    [weakSelf.dataArray removeAllObjects];
////                    
////                    
////                    weakSelf.isHeaderRefersh = NO;
////                    
////                }
////                
////                for (NSDictionary *dict in [listDic objectForKey:@"rows"]) {
////                    AchievementModel  *model = [[AchievementModel alloc]init];
////                    
////                    [model setValuesForKeysWithDictionary:dict];
////                    
////                    [weakSelf.dataArray addObject:model];
////                    
////                    OPLog(@"--- %@",model.dataType);
////                    
////                    
////                }
////                
////                
////                if (weakSelf.isFooterRefersh) {
////                    
////                    
////                    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"增加了%ld条内容", weakSelf.dataArray.count - countArray]];
////                    
////                    
////                }else {
////                    
////                    
////                    [SVProgressHUD showSuccessWithStatus:@"加载完成"];
////                }
////                
//                
//                
//                
//                [weakSelf.detailTableView reloadData];
//                
//            }
//            
//        });
//        
//        
//    };
//    
//}


- (void)getMyReceivedShowDataWithType:(NSString *)type ChID:(NSInteger)chid{

    
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
                                  "<GetJsonContentData xmlns=\"Net.GongHuiTong\">"
                                  "<logincookie>%@</logincookie>"
                                  "<datatype>%@</datatype>"
                                  "<ChID>%ld</ChID>"
                                  " </GetJsonContentData>"
                                  "</soap12:Body>"
                                  "</soap12:Envelope>",[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],type,(long)chid];
        
        
        
        ReturnValueBlock returnBlock = ^(id resultValue){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                OPLog(@"-FF-%@",[[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"]);
                OPLog(@"-show-%@",[[[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"] class]);
                if ([NSNull null] ==[[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"]) {

                    
                    [SVProgressHUD showErrorWithStatus:@"没有更多的数据哦"];
                    
                }else {

                    
                    SBJSON *jsonParser = [[SBJSON alloc] init];
                    
                    NSError *parseError = nil;
                    NSDictionary * result = [jsonParser objectWithString:[[resultValue lastObject] objectForKey:@"GetJsonContentDataResult"]
                                                                   error:&parseError];
                    NSLog(@"jsonParserresult:%@",result);

                    OPLog(@"----far--%@----------",[result objectForKey:@"rows"]);

                                    Users  *model = [[Users alloc]init];
                                    for (NSDictionary *dict in [result objectForKey:@"rows"]) {
                                        
                                        [model setValuesForKeysWithDictionary:dict];
                                    }
                                        if (model.xingming) {
                                            
                                              [_infoArray addObject:model.xingming];
                                            
                                        }else {
                                              [_infoArray addObject:@""];
                                        
                                        }
                                        if (model.phone) {
                                            
                                            [_infoArray addObject:model.phone];
                                        }else {
                                            [_infoArray addObject:@""];
                                            
                                        }
                                        if (model.tel_office) {
                                              [_infoArray addObject:model.tel_office];
                                            
                                        }else {
                                              [_infoArray addObject:@""];
                                            
                                        }
                                        if (model.xingbie) {
                                              [_infoArray addObject:model.xingbie];
                                            
                                        }else {
                                              [_infoArray addObject:@""];
                                            
                                        }
                                        if (model.zhiwu) {
                                            [_infoArray addObject:model.zhiwu];
                                            
                                        }else {
                                            [_infoArray addObject:@""];
                                            
                                        }
                                        if (model.deptname) {
                                             [_infoArray addObject:model.deptname];
                                            
                                        }else {
                                             [_infoArray addObject:@""];
                                            
                                        }
                                        if (model.addr) {
                                            
                                            [_infoArray addObject:model.addr];
                                        }else {
                                            [_infoArray addObject:@""];
                                            
                                            
                                        }
                                        if (model.email) {
                                            
                                            [_infoArray addObject:model.email];
                                        }else {
                                            [_infoArray addObject:@""];
                                        }

                    
                                    [_detailTableView reloadData];
                    
                }
                
            });
            
            
        };

        
        
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"GetJsonContentDataResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];
        
        
    }else {

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    
    
}











@end

//
//  SubjectDetailViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/2/26.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "SubjectDetailViewController.h"
#import "SubGuideModel.h"
@interface SubjectDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *subjectTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SubjectDetailViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = self.subjectTitle;
    if (!_subjectTableView) {
        _subjectTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 20) style:UITableViewStylePlain];
        
        _subjectTableView.delegate=self;
        _subjectTableView.dataSource=self;
//        _subjectTableView.backgroundColor = kBtnColor;

        
    }
    [self.view addSubview:_subjectTableView];
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    
    
    [self getUnionSubjectsDetailWithType:self.dataType pageSize:0 navIndex:0 filter:self.filter withTag:self.requestTag];
    
    
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
    
    
    cell.imageView.image = [UIImage imageNamed:@"iconfont-iconfont73（合并）-拷贝-3"];
    //        cell.textLabel.text = _cellTitleArray[indexPath.row];
    
    cell.textLabel.text = [_dataArray[indexPath.row] ChTopic];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@    %@",[_dataArray[indexPath.row] DataType],[_dataArray[indexPath.row] PublishDate]];
    cell.detailTextLabel.textColor = [UIColor grayColor];
//    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    UserInfoViewController  *use = [[UserInfoViewController alloc]init];
    //    [self.navigationController pushViewController:use animated:YES];
    //    [self.navigationController pushViewController:_controllersArray[indexPath.row] animated:NO];
    
}


- (void)getUnionSubjectsDetailWithType:(NSString *)type pageSize:(NSInteger)pageSize navIndex:(NSInteger)index filter:(NSString *)filter withTag:(NSInteger)Tag{
    
    
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
                OPLog(@"-SubDetail-%@",[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] class]);
                if ([NSNull null] ==[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]) {
                    
                    
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"暂时无更多数据哦" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                    
                    OPLog(@" error !");
                    
                    
                }else {
                    
                    NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                    
                    //                    OPLog(@"%@",listDic);
                    
                    OPLog(@"------%@----------",[listDic objectForKey:@"rows"]);
                    
                    for (NSDictionary *dict in [listDic objectForKey:@"rows"]) {
                        SubGuideModel  *model = [[SubGuideModel alloc]init];
                        
                        [model setValuesForKeysWithDictionary:dict];
                        [_dataArray addObject:model];
                        
                    }
                    
                    for (SubGuideModel *model in _dataArray) {
                        
                        OPLog(@"topic%@ ",model.ChTopic);
                    }
                    
                    [_subjectTableView reloadData];
                    
                    
                    
                    
                    
                    
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


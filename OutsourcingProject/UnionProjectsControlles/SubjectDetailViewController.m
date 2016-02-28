//
//  SubjectDetailViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/2/26.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "SubjectDetailViewController.h"
#import "SubGuideModel.h"
#import "ContentViewController.h"
#import "FuckingViewController.h"
#import "FinalDetailContentViewController.h"
#define WeakSelf __weak typeof(self) weakSelf = self;
@interface SubjectDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate>


{

    ReturnValueBlock returnBlock;
}
@property (nonatomic, strong) UITableView *subjectTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger  pageSize;//每页的个数
@property (nonatomic, assign) NSInteger  pageIndex;//从0页开始

@property (nonatomic, assign) BOOL        isRefersh;

@end

@implementation SubjectDetailViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = self.subjectTitle;
    _pageIndex = 0;
    _pageSize = 8;
  

   
    if (!_subjectTableView) {
        _subjectTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 20) style:UITableViewStylePlain];
        _subjectTableView.delegate=self;
        _subjectTableView.dataSource=self;
//        _subjectTableView.separatorStyle = 
        _subjectTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            

            _isRefersh = YES;
            [self getUnionSubjectsDetailWithType:self.dataType pageSize:_pageSize navIndex:_pageIndex filter:self.filter withTag:self.requestTag];

        }];

   
    }
    [self.view addSubview:_subjectTableView];
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    [self handleRequsetDate];
    
    [self getUnionSubjectsDetailWithType:self.dataType pageSize:_pageSize navIndex:_pageIndex filter:self.filter withTag:self.requestTag];
    
    
}
- (void)handleRequsetDate {

     __weak typeof(self) weakSelf = self;
    returnBlock = ^(id resultValue){
        
        dispatch_async(dispatch_get_main_queue(), ^{
             [weakSelf.subjectTableView.mj_header endRefreshing];
            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            OPLog(@"-FF-%@",[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]);
            if ([NSNull null] ==[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]) {

                [SVProgressHUD showErrorWithStatus:@"没有更多的数据哦"];

//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"暂时无更多数据哦" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                [alert show];
                
                OPLog(@" error !");
                
                
            }else {
                
                weakSelf.pageIndex ++;
                NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                [SVProgressHUD showSuccessWithStatus:@"加载完成"];
                OPLog(@"------%@----------",[listDic objectForKey:@"rows"]);
                
                
                NSInteger countArray =weakSelf.dataArray.count;
                
                for (NSDictionary *dict in [listDic objectForKey:@"rows"]) {
                    SubGuideModel  *model = [[SubGuideModel alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    [weakSelf.dataArray addObject:model];
                    
                }
                
                for (SubGuideModel *model in weakSelf.dataArray) {
                    
                    OPLog(@"topic%@ ",model.ChTopic);
                }
                if (weakSelf.isRefersh) {
                    
                    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"增加了%ld条内容", weakSelf.dataArray.count - countArray]];
                    
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    if (self.MokuaiTag == 2) {
        
        cell.imageView.image = [UIImage imageNamed:@"iconfont-iconfont73（合并）-拷贝-3"];
        
        cell.textLabel.text = [_dataArray[indexPath.row] ChTopic];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@    %@   %@",[_dataArray[indexPath.row]readStatus],[_dataArray[indexPath.row] acceptStatus],[_dataArray[indexPath.row] FinshDate]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.textColor = [UIColor grayColor];

        
    }else {
    
        cell.imageView.image = [UIImage imageNamed:@"iconfont-iconfont73（合并）-拷贝-3"];
        
        cell.textLabel.text = [_dataArray[indexPath.row] ChTopic];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@    %@",[_dataArray[indexPath.row] DataType],[_dataArray[indexPath.row] PublishDate]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.textColor = [UIColor grayColor];

    
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FinalDetailContentViewController  *contentVc = [[ FinalDetailContentViewController alloc]init];

    
    switch (_MokuaiTag) {
        case 0:
        {
            contentVc.dataType = @"zhengcefagui";
            
            contentVc.chID = [_dataArray[indexPath.row] ChID];
            contentVc.titleTop = [_dataArray[indexPath.row] ChTopic];
            
            contentVc.diffTag = _MokuaiTag;
            contentVc.diffContent = [_dataArray[indexPath.row] chContent];
            
            
            [self.navigationController pushViewController:contentVc animated:YES];
        }
            break;
        case 1:
        {
            contentVc.dataType = @"yewuzhidao";
        
            contentVc.chID = [_dataArray[indexPath.row] ChID];
            contentVc.titleTop = [_dataArray[indexPath.row] ChTopic];
            
            contentVc.diffTag = _MokuaiTag;
            contentVc.diffContent = [_dataArray[indexPath.row] chContent];
            
            
            [self.navigationController pushViewController:contentVc animated:YES];
        
        }
            break;
        case 2:
        {
            
            
            contentVc.dataType = @"shoudaodechengguozhanshi";
            
            contentVc.chID = [_dataArray[indexPath.row] ChID];
            contentVc.titleTop = [_dataArray[indexPath.row] ChTopic];
            
            contentVc.diffTag = _MokuaiTag;
            contentVc.diffContent = [_dataArray[indexPath.row] chContent];
            
            
            [self.navigationController pushViewController:contentVc animated:YES];
//           contentVc.dataType = @"shoudaodechengguozhanshi";
//            
//            
//            FuckingViewController *fuck = [[FuckingViewController alloc]init];
//            fuck.titleTop = [_dataArray[indexPath.row] ChTopic];
//            fuck.content = [_dataArray[indexPath.row] chContent];
//            
//            [self.navigationController pushViewController:fuck animated:YES];
            
        }
            break;
            
        default:
            break;
    }
    

    
}


- (void)getUnionSubjectsDetailWithType:(NSString *)type pageSize:(NSInteger)pageSize navIndex:(NSInteger)index filter:(NSString *)filter withTag:(NSInteger)Tag{

    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD showWithStatus:@"增在加载..."];
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
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    
  }
   
}

@end


//
//  MyFavorViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/19.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "MyFavorViewController.h"

@interface MyFavorViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *favorTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MyFavorViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"我的收藏";
    if (!_favorTableView) {
        _favorTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        
        _favorTableView.delegate=self;
        _favorTableView.dataSource=self;
        _favorTableView.scrollEnabled = NO;
        
    }
    [self.view addSubview:_favorTableView];
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        
    }


}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
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

        cell.textLabel.text = @"测试收藏的view";
        cell.detailTextLabel.text = @"业务指导";
        cell.detailTextLabel.textColor = [UIColor grayColor];


    
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

@end

//
//  ContactViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/20.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "UserDetailInfoViewController.h"

@interface UserDetailInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView  *detailTableView;
@property (nonatomic, strong) NSArray      *cellTitleArray;
@property (nonatomic, strong) NSArray      *cellImgArray;
@property (nonatomic, strong) NSArray      *infoArray;

@end

@implementation UserDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息详情";
    [self initArray];
    [self.view addSubview:[self tableView]];
    // Do any additional setup after loading the view.
}



- (void)initArray {
    
    if (!_cellTitleArray) {
        
        _cellTitleArray = @[@"姓名",@"手机",@"办公室电话",@"性别",@"职务",@"部门",@"居住地址",@"邮箱"];
    }
    if (!_cellImgArray) {
        
        _cellImgArray = @[@"iconfont-xingming",@"iconfont-shouji",@"iconfont-shouji(1)",@"iconfont-ren(1)-拷贝",@"iconfont-zanwuneirong",@"iconfont-zhifutijiao",@"iconfont-address",@"iconfont-youxiang"];
    }
    if (!_infoArray) {
        _infoArray = [[NSArray alloc]init];
        NSUserDefaults *info = [NSUserDefaults standardUserDefaults];
        
//        NSString *xingming = [info objectForKey:@"xingming"];
//        NSString *huiyuan = [info objectForKey:@"deptname"];
//        NSString *shouji = [info objectForKey:@"shouji"];
//        NSString *xingbie = [info objectForKey:@"xingbie"];
//        NSString *shengri = [info objectForKey:@"shengri"];
//        NSString *addr = [info objectForKey:@"addr"];
//        NSString *email = [info objectForKey:@"email"] ;
//        _infoArray = @[xingming,huiyuan,@"13852042434",xingbie,shengri,addr,email,@"h",@""];
        
        
    }
//    if (!_userInfoControllersArray) {
//        
//        _userInfoControllersArray = [NSMutableArray arrayWithCapacity:0];
//        [_userInfoControllersArray addObject:[[SetPasswordViewController alloc]init]];
//    }
}

-(UITableView*)tableView
{
    if (!_detailTableView) {
        _detailTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth, 320) style:UITableViewStylePlain];
        
        _detailTableView.delegate=self;
        _detailTableView.dataSource=self;
        _detailTableView.scrollEnabled = NO;
        
    }
    return _detailTableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
        cell.imageView.image = [UIImage imageNamed:_cellImgArray[indexPath.row]];
        cell.textLabel.text = _cellTitleArray[indexPath.row];
    
    NSString *tt = @"我就是测试一下";
    
    if (indexPath.row == 0) {
        if (self.userName) {
           
            tt  = self.userName;
        }
        
    }
    if (indexPath.row == 5) {
    
        if (self.userDept) {
            tt = self.userDept;
        }
        
    }
        cell.detailTextLabel.text = tt;

    
    cell.detailTextLabel.textColor = [UIColor blackColor];
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 40;
}

@end

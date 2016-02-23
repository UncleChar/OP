//
//  UserInfoViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/19.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "UserInfoViewController.h"
#import "LoginViewController.h"
#import "SetPasswordViewController.h"
#import "SetEmailViewController.h"

@interface UserInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIScrollView *backgroungScrollView;
@property (nonatomic, strong) UITableView  *setTableView;
@property (nonatomic, strong) UIImageView  *headImaView;
@property (nonatomic, strong) UIButton     *avatarImgView;
@property (nonatomic, strong) UILabel      *organizeLabel;
@property (nonatomic, strong) NSArray      *cellTitleArray;
@property (nonatomic, strong) NSArray      *cellImgArray;
@property (nonatomic, strong) NSArray      *infoArray;
@property (nonatomic, strong) NSMutableArray  *userInfoControllersArray;



@end

@implementation UserInfoViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = 0;
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"个人信息";
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self initArray];
    [self.view addSubview:[self backgScrollView]];
    [_backgroungScrollView addSubview:[self headImaView]];
    [_backgroungScrollView addSubview:[self tableView]];
    
//    
//    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    exitBtn.frame = CGRectMake(30, CGRectGetMaxY(_setTableView.frame) + 30, (kScreenWidth - 60) , 40);
//    [exitBtn setBackgroundImage:[UIImage imageNamed:@"矩形-9"] forState:UIControlStateNormal];
//    [exitBtn addTarget:self action:@selector(exitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
//    [_backgroungScrollView addSubview:exitBtn];
    
    _backgroungScrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(_setTableView.frame) + 20 + 49 + 20);
}
- (UIScrollView *)backgScrollView {

    _backgroungScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];

    _backgroungScrollView.contentSize = CGSizeMake(0, 0);

    return _backgroungScrollView;
}

- (void)initArray {
    
    if (!_cellTitleArray) {
        
        _cellTitleArray = @[@"姓名:",@"登录名:",@"手机:",@"性别:",@"生日:",@"居住地址:",@"邮箱:",@"1",@"修改密码"];
    }
    if (!_cellImgArray) {
        
        _cellImgArray = @[@"iconfont-iconxingming",@"iconfont-dingdanbianhao01",@"iconfont-shouji",@"iconfont-iconxingming",@"iconfont-cake-line",@"iconfont-address",@"iconfont-youxiang",@"iconfont-youxiang",@"iconfont-mima"];
    }
    if (!_infoArray) {
        _infoArray = [[NSArray alloc]init];
        NSUserDefaults *info = [NSUserDefaults standardUserDefaults];

        NSString *xingming = [info objectForKey:@"xingming"];
        NSString *huiyuan = [info objectForKey:@"deptname"];
        NSString *shouji = [info objectForKey:@"shouji"];
        NSString *xingbie = [info objectForKey:@"xingbie"];
        NSString *shengri = [info objectForKey:@"shengri"];
        NSString *addr = [info objectForKey:@"addr"];
        NSString *email = [info objectForKey:@"email"] ;
        _infoArray = @[xingming,huiyuan,@"13852042434",xingbie,shengri,addr,email,@"h",@""];

        
    }
    if (!_userInfoControllersArray) {
        
        _userInfoControllersArray = [NSMutableArray arrayWithCapacity:0];
        [_userInfoControllersArray addObject:[[SetPasswordViewController alloc]init]];
    }
}

- (UIImageView *)headImaView {
    
    if (!_headImaView) {
        
        _headImaView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
        _headImaView.image = [UIImage imageNamed:@"background.jpg"];
        _headImaView.userInteractionEnabled = 1;
    }
    
    if (nil == [AppEngineManager sharedInstance].leftViewElementsPath) {
        
        [[AppEngineManager sharedInstance] createSubDirectoryName:kAvatarImgFloderName underSuperDirectory:[AppEngineManager sharedInstance].dirDocument];
        OPLog(@"headImageFile-->%@",[AppEngineManager sharedInstance].leftViewElementsPath);
    }
    
    NSString *imageFilePath = [[AppEngineManager sharedInstance].leftViewElementsPath stringByAppendingPathComponent:@"/userAvatar.jpg"];
    
    
    _avatarImgView = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 100, 15, kScreenWidth / 6, kScreenWidth / 6)];
    _avatarImgView.enabled = NO;
//    _avatarImgView.center =CGPointMake(kScreenWidth *5 / 6 + 20, _headImaView.center.y + 10);
    
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        
        [_avatarImgView setBackgroundImage:[UIImage imageWithContentsOfFile:imageFilePath] forState:UIControlStateNormal];
    }else {
        
        
        [_avatarImgView setBackgroundImage:[UIImage imageNamed:@"placeholder"] forState:UIControlStateNormal];
        
    }
    
    
    [_avatarImgView addTarget:self action:@selector(takePictureClick:) forControlEvents:UIControlEventTouchUpInside];
    _avatarImgView.layer.masksToBounds = 1;
    _avatarImgView.layer.cornerRadius =  kScreenWidth / 12;
    [_headImaView addSubview:_avatarImgView];
    
    _organizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 30, 50, 30)];
    _organizeLabel.text = @"头像";
    
    [_headImaView addSubview:_organizeLabel];
    return _headImaView;
    
}
-(UITableView*)tableView
{
    if (!_setTableView) {
        _setTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headImaView.frame)+5, kScreenWidth, 390) style:UITableViewStylePlain];
        
        _setTableView.delegate=self;
        _setTableView.dataSource=self;
        _setTableView.scrollEnabled = NO;
        
    }
    return _setTableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 9;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 7) {
        
        cell.backgroundColor = kBackColor;

        
    }else {
    
        cell.imageView.image = [UIImage imageNamed:_cellImgArray[indexPath.row]];
        cell.textLabel.text = _cellTitleArray[indexPath.row];
        cell.detailTextLabel.text = _infoArray[indexPath.row];
        
        if ( indexPath.row == 6 | indexPath.row == 8) {

             cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.textColor = [UIColor blackColor];
        }

    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 7) {
        
        return 30;
    }
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    UserInfoViewController  *use = [[UserInfoViewController alloc]init];
    //    [self.navigationController pushViewController:use animated:YES];
    //     OPLog(@"dd%d",indexPath.row);
    
    if (indexPath.row == 6) {
        
        [self.navigationController pushViewController:[[SetEmailViewController alloc]init] animated:YES];

        
    }
    
    
    if (indexPath.row == 8) {
    
        
        [self.navigationController pushViewController:[[SetPasswordViewController alloc]init] animated:YES];

    }
    
}
//- (void)selectedAvatarImg {
//
//    OPLog(@"EEEE");
//    [self TAKE]
//}


//从相册获取图片
-(void)takePictureClick:(UIButton *)sender
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择头像来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [self presentViewController:alert animated:YES completion:nil];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *localAction = [UIAlertAction actionWithTitle:@"本地相簿" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cameraAction];
    [alert addAction:localAction];
    [alert addAction:cancelAction];
    
}

#pragma mark -
#pragma UIImagePickerController Delegate


- (void)exitBtnClicked:(UIButton *)sender {
    
    
    
    LoginViewController *divideVC = [[LoginViewController alloc]init];
    self.tabBarController.tabBar.hidden = 1;
    [self.navigationController pushViewController:divideVC animated:YES];
    NSUserDefaults *store = [NSUserDefaults standardUserDefaults];
    [store setBool:NO forKey:kUserLoginStatus];
    [store synchronize];
    //    [self.navigationController pushViewController:[[LoginViewController alloc]init]] animated:YES];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

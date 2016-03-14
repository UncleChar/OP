//
//  MySettingViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/2/18.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "MySettingViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"
#import "UserInfoViewController.h"
#import "MyFavorViewController.h"
#import "MyShowViewController.h"
#import "MyConsultViewController.h"
#import "MySendingViewController.h"
#import "SystemSettingViewController.h"


@interface MySettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property  (nonatomic, strong) UIScrollView  *backScrollView;
@property (nonatomic, strong) UITableView  *setTableView;
@property (nonatomic, strong) UIImageView  *headImaView;
@property (nonatomic, strong) UIImageView     *avatarImgView;
@property (nonatomic, strong) UILabel      *organizeLabel;
@property (nonatomic, strong) NSArray      *cellTitleArray;
@property (nonatomic, strong) NSArray      *cellImgArray;
@property (nonatomic, strong) NSMutableArray  *controllersArray;


@end

@implementation MySettingViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden = 1;
    self.tabBarController.tabBar.hidden = 0;


    //    [_userChatTableView.mj_header beginRefreshing];
    
    
}

- (UIScrollView *)backgScrollView {
    if (!_backScrollView) {
        
        _backScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        _backScrollView.contentSize = CGSizeMake(0, 0);
        [self.view addSubview:_backScrollView];

        
    }
       return _backScrollView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBackColor;

    [self initArray];
    [[self backgScrollView] addSubview:[self headImaView]];
    [[self backgScrollView] addSubview:[self tableView]];
    
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    exitBtn.frame = CGRectMake(30, CGRectGetMaxY(_setTableView.frame) + 30, (kScreenWidth - 60) , 40);
//    [exitBtn setBackgroundImage:[UIImage imageNamed:@"矩形-9"] forState:UIControlStateNormal];
    exitBtn.backgroundColor = kBtnColor;
    [exitBtn addTarget:self action:@selector(exitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    exitBtn.layer.cornerRadius = 4;
    exitBtn.layer.masksToBounds = 1;
    [[self backgScrollView] addSubview:exitBtn];

    if (CGRectGetMaxY(exitBtn.frame) > kScreenHeight - 49) {
        
        _backScrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(exitBtn.frame) + 30 ) ;
    }
    
}


- (void)initArray {

    if (!_cellTitleArray) {
        
        _cellTitleArray = @[@"个人信息",@"我的收藏",@"我的成果展示",@"我的咨询",@"我发出的通知",@"系统设置"];
    }
    if (!_cellImgArray) {
        
        _cellImgArray = @[@"iconfont-ren(1)",@"iconfont-shoucang",@"iconfont-zixun",@"iconfont-zixun",@"iconfont-people",@"iconfont-shezhi"];
    }

}

- (UIImageView *)headImaView {

    if (!_headImaView) {
        
        _headImaView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 0.33)];
        _headImaView.image = [UIImage imageNamed:@"background.jpg"];
        _headImaView.userInteractionEnabled = 1;
      
    }
    


    
    _avatarImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth / 6, kScreenWidth / 6)];
    _avatarImgView.center =CGPointMake(kScreenWidth / 12 + 20, kScreenWidth * 0.33 / 2);
    _avatarImgView.userInteractionEnabled = 1;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(takePictureClick:)];
    [_avatarImgView addGestureRecognizer:tap];
    


    _avatarImgView.layer.masksToBounds = 1;
    _avatarImgView.layer.cornerRadius =  kScreenWidth / 12;
    [_headImaView addSubview:_avatarImgView];

//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    NSString *directory = [NSString stringWithFormat:@"%@/%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0],@"Avatar"];
//
//     NSString *imageFilePath = [directory stringByAppendingPathComponent:@"/userAvatar.jpg"];
//
//    BOOL isExit = [fileManager fileExistsAtPath:imageFilePath];
//
//    if (isExit){
//
//        _avatarImgView.image = [UIImage imageWithContentsOfFile:imageFilePath];
//        
//        
//        }else {
    
            NSString *url = [[NSUserDefaults standardUserDefaults] objectForKey:@"iconpic"];
            [_avatarImgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
//        }

    _organizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_avatarImgView.frame) + 20, CGRectGetMidY(_avatarImgView.frame) - 15, kScreenWidth - CGRectGetMaxX(_avatarImgView.frame) - 20 - 20, 30)];
    _organizeLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"xingming"];

    [_headImaView addSubview:_organizeLabel];
    return _headImaView;

}
-(UITableView*)tableView
{
    if (!_setTableView) {
        _setTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, kScreenWidth * 0.33 + 1, kScreenWidth, 270 + 6 + 1) style:UITableViewStylePlain];
        _setTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _setTableView.delegate=self;
        _setTableView.dataSource=self;
        _setTableView.scrollEnabled = NO;
    }
    return _setTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6 * 2 + 1;
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
//        cell.imageView.image = [UIImage imageNamed:_cellImgArray[indexPath.row]];
//        cell.textLabel.text = _cellTitleArray[indexPath.row];
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    }else {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.image = [UIImage imageNamed:_cellImgArray[(indexPath.row + 1) / 2 - 1]];
        cell.textLabel.text = _cellTitleArray[(indexPath.row + 1) / 2 - 1];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    }
    


    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
        if ((indexPath.row + 1 ) % 2 == 1) {
            
             return 1;
            
        }else {
            
             return 45;
            
        }
    
    

    
    

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    _controllersArray = [NSMutableArray arrayWithCapacity:0];
    [_controllersArray addObject:[[UserInfoViewController alloc]init]];
    [_controllersArray addObject:[[MyFavorViewController alloc]init]];
    [_controllersArray addObject:[[MyShowViewController alloc]init]];
    [_controllersArray addObject:[[MyConsultViewController alloc]init]];
    [_controllersArray addObject:[[MySendingViewController alloc]init]];
    [_controllersArray addObject:[[SystemSettingViewController alloc]init]];

    [self.navigationController pushViewController:_controllersArray[(indexPath.row + 1) / 2 - 1] animated:YES];

}













////从相册获取图片
-(void)takePictureClick:(UITapGestureRecognizer *)sender
{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取相片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // 判断是否支持相机
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertAction * defaultAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing =YES;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePickerController animated:YES completion:^{
                
            }];
        }];
        [alertController addAction:defaultAction];
        
    }
    
    UIAlertAction * defaultAction1 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController * imagePickerController1 = [[UIImagePickerController alloc]init];
        imagePickerController1.delegate = self;
        imagePickerController1.allowsEditing =YES;
        imagePickerController1.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:imagePickerController1 animated:YES completion:^{
            
        }];
        
    }];
    [alertController addAction:defaultAction1];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    

    
    
//
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择头像来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    [self presentViewController:alert animated:YES completion:nil];
//    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//        imagePicker.delegate = self;
//        imagePicker.allowsEditing = YES;
//        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [self presentViewController:imagePicker animated:YES completion:nil];
//    }];
//    UIAlertAction *localAction = [UIAlertAction actionWithTitle:@"本地相簿" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//        imagePicker.delegate = self;
//        imagePicker.allowsEditing = YES;
//        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        [self presentViewController:imagePicker animated:YES completion:nil];
//    }];
//    
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [alert addAction:cameraAction];
//    [alert addAction:localAction];
//    [alert addAction:cancelAction];
//    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    // 保存图片至本地，方法见下文
    [self saveImage:image withname:@"tr.jpg"];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
- (void)saveImage:(UIImage*)currentImage withname:(NSString*)picname
{
    NSData * imageData = UIImageJPEGRepresentation(currentImage, 1.0f);
    
    NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    [def setObject:encodedImageStr forKey:@"encodedImageStr"];
    
    NSUserDefaults * defua = [NSUserDefaults standardUserDefaults];
    NSString * logincookie = [defua objectForKey:@"logincookie"];
    NSString * useID = [defua objectForKey:@"usercode"];
    NSDictionary *keyAndValues = @{@"logincookie":logincookie,@"datatype":@"gerenxinxin",@"id":useID};
    
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        //设置转换格式
        df.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [df stringFromDate:[NSDate date]];

    NSString * requestBody =   [JHXMLParser generateXMLString:keyAndValues hostName:@"Net.GongHuiTong" startElementKey:@"EditAppInfo" xmlInfo:YES resouresInfo:@{@"fld_39_18":fileName} fileNames:@[fileName] fileExtNames:@[@".jpg"] fileDesc:@[[NSString stringWithFormat:@"%@.jpg",fileName]] fileData:@[encodedImageStr]];
    
    ReturnValueBlock returnBlock = ^(id resultValue)
    {
//        NSLog(@"personInfo  %@",resultValue);
        
        
        OPLog(@"-FF-%@",[[resultValue lastObject] objectForKey:@"EditAppInfoResult"]);
        OPLog(@"-show-%@",[[[resultValue lastObject] objectForKey:@"EditAppInfoResult"] class]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
            if ([[[resultValue lastObject] objectForKey:@"EditAppInfoResult"]isEqualToString:@"操作成功！"]) {
                
//                
//                
//                
//                    [[AppEngineManager sharedInstance] createSubDirectoryName:kAvatarImgFloderName underSuperDirectory:[AppEngineManager sharedInstance].dirDocument];
//                    OPLog(@"headImageFile-->%@",[AppEngineManager sharedInstance].leftViewElementsPath);

                    NSFileManager *fileManager = [NSFileManager defaultManager];

                NSString *directory = [NSString stringWithFormat:@"%@/%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0],@"Avatar"];
                // 创建目录
                BOOL res = [fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
                if (res) {
                   
                    
                    NSString *imageFilePath = [directory stringByAppendingPathComponent:@"/userAvatar.jpg"];

                    BOOL rest=[fileManager createFileAtPath:imageFilePath contents:imageData attributes:nil];
                    if (rest) {
                        
                        _avatarImgView.image = [UIImage imageWithContentsOfFile:imageFilePath];
                        OPLog(@"111111");
                    }else {
                        
                        _avatarImgView.image = [UIImage imageWithData:imageData];
                        OPLog(@"22222");
                        
                    }
                    
                    
                }else{
                    
                     _avatarImgView.image = [UIImage imageWithData:imageData];
                    
                    
                }

                
                
                

    
            }
        
        });
       
        
    };
    [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"EditAppInfoResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];
    
}


- (void)exitBtnClicked:(UIButton *)sender {


    
    LoginViewController *divideVC = [[LoginViewController alloc]init];
    self.tabBarController.tabBar.hidden = 1;
    [self.navigationController pushViewController:divideVC animated:YES];
    NSUserDefaults *store = [NSUserDefaults standardUserDefaults];
    [store setBool:NO forKey:kUserLoginStatus];
    [store synchronize];
//    [self.navigationController pushViewController:[[LoginViewController alloc]init]] animated:YES];

}



@end

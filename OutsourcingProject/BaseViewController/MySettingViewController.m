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


@interface MySettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView  *setTableView;
@property (nonatomic, strong) UIImageView  *headImaView;
@property (nonatomic, strong) UIButton     *avatarImgView;
@property (nonatomic, strong) UILabel      *organizeLabel;
@property (nonatomic, strong) NSArray      *cellTitleArray;
@property (nonatomic, strong) NSArray      *cellImgArray;


@end

@implementation MySettingViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden = 1;
    //    [_userChatTableView.mj_header beginRefreshing];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBackColor;

    [self initArray];
    [self.view addSubview:[self headImaView]];
    [self.view addSubview:[self tableView]];

    
}


- (void)initArray {

    if (!_cellTitleArray) {
        
        _cellTitleArray = @[@"个人信息",@"我的收藏",@"我的成果展示",@"我的咨询",@"我发出的通知",@"系统设置"];
    }
    if (!_cellImgArray) {
        
        _cellImgArray = @[@"iconfont-ren(1)",@"iconfont-shoucang",@"iconfont-zixun",@"iconfont-bianji",@"iconfont-people",@"iconfont-shezhi"];
    }
}

- (UIImageView *)headImaView {

    if (!_headImaView) {
        
        _headImaView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 130)];
        _headImaView.image = [UIImage imageNamed:@"background.jpg"];
        _headImaView.userInteractionEnabled = 1;
    }
    
    if (nil == [AppEngineManager sharedInstance].leftViewElementsPath) {
        
        [[AppEngineManager sharedInstance] createSubDirectoryName:kAvatarImgFloderName underSuperDirectory:[AppEngineManager sharedInstance].dirDocument];
        NSLog(@"headImageFile-->%@",[AppEngineManager sharedInstance].leftViewElementsPath);
    }
    
    NSString *imageFilePath = [[AppEngineManager sharedInstance].leftViewElementsPath stringByAppendingPathComponent:@"/userAvatar.jpg"];

    
    _avatarImgView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth / 6, kScreenWidth / 6)];
    _avatarImgView.center =CGPointMake(kScreenWidth / 12 + 20, _headImaView.center.y + 10);
    if (imageFilePath) {
        
        [_avatarImgView setBackgroundImage:[UIImage imageWithContentsOfFile:imageFilePath] forState:UIControlStateNormal];
    }else {
        [_avatarImgView setBackgroundImage:[UIImage imageNamed:@"placeholder"] forState:UIControlStateNormal];
        
    }

    [_avatarImgView addTarget:self action:@selector(takePictureClick:) forControlEvents:UIControlEventTouchUpInside];
    _avatarImgView.layer.masksToBounds = 1;
    _avatarImgView.layer.cornerRadius =  kScreenWidth / 12;
    [_headImaView addSubview:_avatarImgView];
    
    _organizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_avatarImgView.frame) + 20, CGRectGetMidY(_avatarImgView.frame) - 15, kScreenWidth - CGRectGetMaxX(_avatarImgView.frame) - 20 - 20, 30)];
    _organizeLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"deptname"];

    [_headImaView addSubview:_organizeLabel];
    return _headImaView;

}
-(UITableView*)tableView
{
    if (!_setTableView) {
        _setTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 145, kScreenWidth, 270) style:UITableViewStylePlain];
        
        _setTableView.delegate=self;
        _setTableView.dataSource=self;
        _setTableView.scrollEnabled = NO;
    }
    return _setTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
        cell.imageView.image = [UIImage imageNamed:_cellImgArray[indexPath.row]];
    cell.textLabel.text = _cellTitleArray[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    //    cell.imageView.layer.cornerRadius = 24;
    //    cell.imageView.layer.masksToBounds = 1;
    //    [cell setSelected:YES animated:YES];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45;
}

//- (void)selectedAvatarImg {
//
//    NSLog(@"EEEE");
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
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage *)image {
    
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSString *imageFilePath = [[AppEngineManager sharedInstance].leftViewElementsPath stringByAppendingPathComponent:@"/userAvatar.jpg"];
    
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        success = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    //UIImage *smallImage=[self scaleFromImage:image toSize:CGSizeMake(80.0f, 80.0f)];//将图片尺寸改为80*80
    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(100, 100)];
    [UIImageJPEGRepresentation(smallImage, 1.0f) writeToFile:imageFilePath atomically:YES];//写入文件
    [_avatarImgView setBackgroundImage:[UIImage imageWithContentsOfFile:imageFilePath] forState:UIControlStateNormal];//读取图片文件
    
}

// 改变图像的尺寸，方便上传服务器
- (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

@end

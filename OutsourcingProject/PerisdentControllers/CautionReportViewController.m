//
//  CautionReportViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/3/11.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "CautionReportViewController.h"
#import "AJPhotoPickerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "AJPhotoBrowserViewController.h"
#define kHeight 40
#define kFont  15
#define kLabelWidth 75
#define kContentStart 105
#define kContentWidth  [UIScreen mainScreen].bounds.size.width - kContentStart - 10
@interface CautionReportViewController ()<AJPhotoPickerProtocol,AJPhotoBrowserDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIScrollView *backgroungScrollView;

@property (nonatomic, strong) NSArray      *elementArray;
@property (nonatomic, strong) UIView       *coverView;
@property (nonatomic, strong) UIView       *topView;

@property (nonatomic, strong) UITextField  *cautionTitleTF;
@property (nonatomic, strong) UIButton     *notiTypeBtn;

@property (nonatomic, strong) UITextField  *companyNameTF;
@property (nonatomic, strong) UITextField  *eventAddressTF;

@property (nonatomic, strong) UITextView   *contentTView;
@property (nonatomic, assign) float         lastElementMaxY;


@property (nonatomic, strong) UIImageView   *imageView;

@property (nonatomic, strong) UIScrollView   *scrollView;

@property (nonatomic, strong) NSMutableArray   *photos;
@property (nonatomic, strong) NSMutableArray   *postPics;

@property (nonatomic, strong) NSString   *photoString;

@end

@implementation CautionReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"警示上报";
    
    _backgroungScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _backgroungScrollView.backgroundColor = kBackColor;
    _backgroungScrollView.userInteractionEnabled = YES;
    [self.view addSubview:_backgroungScrollView];
    

    
    NSLog(@"ddffd%@",NSStringFromCGRect(_backgroungScrollView.frame));
    
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:_backgroungScrollView];
    
    [self initElement];
    
    
}


- (void)initElement{
    
    if (!_elementArray) {//90 173 243
        
        _elementArray = @[@"警示标题:",@"警示类型:", @"涉嫌公司名称:",@"事件地址:"];
    }
    if (!_photos) {
        
        _photos = [NSMutableArray arrayWithCapacity:0];
    }
    if (!_postPics) {
        _postPics = [NSMutableArray arrayWithCapacity:0];
    }
    
    for (int i = 0; i < 4; i ++) {
        
        
        
        
        UIView *view = [[UIView alloc]init];
        view.frame = CGRectMake(0,  i * (kHeight + 1) , kScreenWidth, kHeight);
        [_backgroungScrollView addSubview:view];
        view.backgroundColor = kBackColor;
        
        UILabel *titleLabel1 = [[UILabel alloc]init];
        
        titleLabel1.text = _elementArray[i];
        titleLabel1.frame = CGRectMake(10, 0, kLabelWidth + 30, 40);
        titleLabel1.font = [UIFont systemFontOfSize:kFont];
        titleLabel1.font = OPFont(14);
        [view addSubview:titleLabel1];
        
        [_backgroungScrollView addSubview:view];
        if (i == 3) {
           
            _lastElementMaxY = CGRectGetMaxY(view.frame);
            
        }
        
    }
    
    [self addCouationSubviews];
    
}

- (void)addCouationSubviews {
    
    
    _cautionTitleTF = [[UITextField alloc]init];
    _cautionTitleTF.backgroundColor = kTestColor;
    _cautionTitleTF.frame = CGRectMake(kContentStart, 0, kContentWidth, kHeight);
    _cautionTitleTF.font = [UIFont systemFontOfSize:kFont];
    _cautionTitleTF.layer.cornerRadius = 4;
    _cautionTitleTF.layer.masksToBounds = 1;
    [_backgroungScrollView addSubview:_cautionTitleTF];
    
    _notiTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _notiTypeBtn.tag = 678 + 0;
    _notiTypeBtn.backgroundColor = kTestColor;
    [_notiTypeBtn setTitle:@"一般类型" forState:UIControlStateNormal];
    [_notiTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_notiTypeBtn addTarget:self action:@selector(cautionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _notiTypeBtn.frame = CGRectMake(kContentStart, kHeight + 1, kContentWidth, kHeight);
    _notiTypeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _notiTypeBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
    _notiTypeBtn.layer.cornerRadius = 4;
    _notiTypeBtn.layer.masksToBounds = 1;
    [_backgroungScrollView addSubview:_notiTypeBtn];
    
    
    _companyNameTF = [[UITextField alloc]init];
    _companyNameTF.backgroundColor = kTestColor;
    _companyNameTF.frame = CGRectMake(kContentStart, 2 * (kHeight + 1), kContentWidth, kHeight);
    _companyNameTF.font = [UIFont systemFontOfSize:kFont];
    _companyNameTF.layer.cornerRadius = 4;
    _companyNameTF.layer.masksToBounds = 1;
    [_backgroungScrollView addSubview:_companyNameTF];
    
    
    
    _eventAddressTF = [[UITextField alloc]init];
    _eventAddressTF.backgroundColor = kTestColor;
    _eventAddressTF.frame = CGRectMake(kContentStart, 3 * kHeight + 3, kContentWidth, kHeight);
    _eventAddressTF.font = [UIFont systemFontOfSize:kFont];
    _eventAddressTF.layer.cornerRadius = 4;
    _eventAddressTF.layer.masksToBounds = 1;
    [_backgroungScrollView addSubview:_eventAddressTF];
    
  
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.backgroundColor = kBackColor;
    contentLabel.text = @"事件内容:";
    contentLabel.textColor = [UIColor orangeColor];
    contentLabel.frame = CGRectMake(10,  4 * (kHeight + 1) , kScreenWidth, kHeight);
    contentLabel.font = OPFont(14);
    [_backgroungScrollView addSubview:contentLabel];
    
    UIView *textBackView = [[UIView alloc]initWithFrame:CGRectMake(10, 5 * kHeight+ 5, kScreenWidth - 20, 3.5 * kHeight)];
    textBackView.backgroundColor = [UIColor blackColor];
    textBackView.layer.cornerRadius = 4;
    textBackView.layer.masksToBounds = 1;
    
    [_backgroungScrollView addSubview:textBackView];
    
    
    _contentTView = [[UITextView alloc]init];
    //    _contentTView.backgroundColor = kTestColor;
    _contentTView.frame = CGRectMake(1, 1, kScreenWidth - 22, CGRectGetHeight(textBackView.frame) - 2);
    _contentTView.font = [UIFont systemFontOfSize:kFont];
    _contentTView.layer.cornerRadius = 4;
    _contentTView.layer.masksToBounds = 1;
    [textBackView addSubview:_contentTView];
//
//    _receiptTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _receiptTypeBtn.tag = 888 + 3;
//    _receiptTypeBtn.selected = NO;
//    _receiptTypeBtn.backgroundColor = kTestColor;
//    [_receiptTypeBtn setTitle:@"无需回执" forState:UIControlStateNormal];
//    [_receiptTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_receiptTypeBtn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    _receiptTypeBtn.frame = CGRectMake(kContentStart, 7 * (kHeight + 1) + 3.5 * kHeight +2, kContentWidth, kHeight);
//    _receiptTypeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    _receiptTypeBtn.titleLabel.font = [UIFont systemFontOfSize:kFont];
//    _receiptTypeBtn.layer.cornerRadius = 4;
//    _receiptTypeBtn.layer.masksToBounds = 1;
//    [_backgroungScrollView addSubview:_receiptTypeBtn];
//
    UILabel *PICLabel = [[UILabel alloc]init];
    PICLabel.backgroundColor = kBackColor;
    PICLabel.frame = CGRectMake(10,  CGRectGetMaxY(textBackView.frame) + 5 , kScreenWidth, kHeight);
    PICLabel.textColor = [UIColor orangeColor];
    PICLabel.text = @"现场照片:";
    PICLabel.font = OPFont(14);
    [_backgroungScrollView addSubview:PICLabel];
    
    
    
    UIButton  *picBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    picBtn.backgroundColor = kTestColor;
    picBtn.tag = 678 + 2;
    //    [submitBtn setBackgroundImage:[UIImage imageNamed:@"矩形-9"] forState:UIControlStateNormal];
//    picBtn.backgroundColor = [UIColor blackColor];
    [picBtn setBackgroundImage:[UIImage imageNamed:@"selectPicBtn"] forState:UIControlStateNormal];
    [picBtn addTarget:self action:@selector(cautionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    picBtn.layer.cornerRadius = 4;
    picBtn.layer.masksToBounds = 1;
    picBtn.frame = CGRectMake(10, CGRectGetMaxY(PICLabel.frame) + 20 , 60, 60);
    [_backgroungScrollView addSubview:picBtn];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(29, 10, 2, 40)];
    line1.backgroundColor = [UIColor grayColor];
    [picBtn addSubview:line1];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(10, 29, 40, 2)];
    line2.backgroundColor = [UIColor grayColor];
    [picBtn addSubview:line2];
    
    _scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(80, CGRectGetMaxY(PICLabel.frame), kScreenWidth - 90 , 100)];
    _scrollView.backgroundColor = kBackColor;
    _scrollView.userInteractionEnabled = YES;
    [_backgroungScrollView addSubview:_scrollView];
    
    
    UIButton  *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.backgroundColor = kTestColor;
    submitBtn.tag = 678 + 3;
    //    [submitBtn setBackgroundImage:[UIImage imageNamed:@"矩形-9"] forState:UIControlStateNormal];
    submitBtn.backgroundColor = kBtnColor;
    [submitBtn setTitle:@"提交通知" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(cautionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius = 4;
    submitBtn.layer.masksToBounds = 1;
    submitBtn.frame = CGRectMake(20, CGRectGetMaxY(_scrollView.frame) + 10, kScreenWidth - 40, 40);
    [_backgroungScrollView addSubview:submitBtn];

    
    _lastElementMaxY = CGRectGetMaxY(submitBtn.frame);
    NSLog(@"---dd%f",_lastElementMaxY);
    
    [ConfigUITools sizeToScroll:_backgroungScrollView withStandardElementMaxY:_lastElementMaxY + 25 forStepsH:0];
    
}

- (void)cautionBtnClicked:(UIButton *)sender {

    switch (sender.tag - 678) {
        case 0:
            
            [self showSelectedWithTitle:@"选择类型" subTitles:@[@"一般类型",@"其他类型"]];
            break;

        case 2:
        {
        
            AJPhotoPickerViewController *picker = [[AJPhotoPickerViewController alloc] init];
            picker.maximumNumberOfSelection = 15;
            picker.multipleSelection = YES;
            picker.assetsFilter = [ALAssetsFilter allPhotos];
            picker.showEmptyGroups = YES;
            picker.delegate=self;
            [self.photos removeAllObjects];
            [self.postPics removeAllObjects];
            picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                return YES;
            }];
            [self presentViewController:picker animated:YES completion:nil];

        
        }
            break;
        case 3:
        {
        
            if ([AppDelegate isNetworkConecting]) {
                
                
                NSDictionary *keyAndValues = @{@"logincookie":[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],@"datatype":@"jingshishangbao"};
                
                if ([AlertTipsViewTool isEmptyWillSubmit:@[_cautionTitleTF,_notiTypeBtn,_companyNameTF,_eventAddressTF,_contentTView]]) {
                    
                }else {
                    
                    
//                    
//                    NSString * requestBody =   [JHXMLParser generateXMLString:keyAndValues hostName:@"Net.GongHuiTong" startElementKey:@"EditAppInfo" xmlInfo:YES resouresInfo:@{@"fld_39_18":fileName} fileNames:@[fileName] fileExtNames:@[@".jpg"] fileDesc:@[[NSString stringWithFormat:@"%@.jpg",fileName]] fileData:@[encodedImageStr]];
                    NSString *fileName;
                    NSMutableArray *nameArr = [[NSMutableArray alloc]init];
                     NSMutableArray *descArr = [[NSMutableArray alloc]init];
                    if (_postPics.count > 1) {
                      
                        for (int i = 0; i < _postPics.count; i ++) {
                            
                            NSString *str = [NSString stringWithFormat:@"00%d",i + 2];
                            [nameArr addObject:str];
                            NSString *strDesc = [NSString stringWithFormat:@"00%d.jpg",i+2];
                            [descArr addObject:strDesc];
                            
                            
                        }
                        fileName = [nameArr componentsJoinedByString:@","];
                        
                    }else {
                    fileName = @"001";
                        [nameArr addObject:fileName];
                        [descArr addObject:@"001.jpg"];
                    }
                    
                   
                    

                    NSString *xmlString =  [JHXMLParser generateXMLString:keyAndValues
                                                                 hostName:@"Net.GongHuiTong"
                                                          startElementKey:@"AddAppInfo" xmlInfo:YES
                                                             resouresInfo:@{
                                                                            @"Topic":_cautionTitleTF.text,
                                                                            @"datatype":_notiTypeBtn.titleLabel.text,
                                                                            @"Commpany":_companyNameTF.text,
                                                                            @"addr":_eventAddressTF.text,
                                                                            @"Content":_contentTView.text,
                                                                            @"AttFile":fileName
                                                                            }fileNames:nameArr fileExtNames:@[@".jpg"] fileDesc:descArr fileData:_postPics];
                    
                    [self submitAddUserWithXmlString:xmlString];
                    
                }
                
                
            }else {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无网络连接,请检查网络!" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    
                    
                }];
                
                [alertController addAction:okAction];
                
                [self.navigationController  presentViewController:alertController animated:YES completion:nil];
                
            }

        
        }
            break;
            
        default:
            break;
    }

}

- (void)submitAddUserWithXmlString:(NSString *)xmlString
{
    
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showInfoWithStatus:@"增在提交..."];
    
        __weak typeof(self) weakSelf = self;
        ReturnValueBlock returnBlockPost = ^(id resultValue){
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSLog(@"AddAppInfoResult::%@",[[resultValue lastObject] objectForKey:@"AddAppInfoResult"]);
                
                if ([[[resultValue lastObject] objectForKey:@"AddAppInfoResult"] isEqualToString:@"操作失败！"]) {
                    
                    [SVProgressHUD showErrorWithStatus:@"提交失败!"];
                    
                    
                }else {
                    
                    //                weakSelf.submitBtnBlock( YES);
                    [SVProgressHUD showSuccessWithStatus:@"提交成功！"];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    
                }
               
                
                
            });
            
            
            
            
            
        };
        
        
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:xmlString parseParameters:@[@"AddAppInfoResult"] WithReturnValeuBlock:returnBlockPost WithErrorCodeBlock:nil];
    
    
}



- (void)showSelectedWithTitle:(NSString *)title subTitles:(NSArray *)array {
    
    
    _coverView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0.7;
    
    // 添加单击手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePopupView:)];
    _coverView.userInteractionEnabled = YES;
    [_coverView addGestureRecognizer:gesture];
    [[UIApplication sharedApplication].keyWindow addSubview:_coverView];
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth / 6, ([UIScreen mainScreen].bounds.size.height - (array.count * 45 + array.count + 1)) / 2, kScreenWidth * 2 / 3, array.count * 45 + array.count + 1 + 61)];
    _topView.backgroundColor = [UIColor whiteColor];
    _topView.layer.cornerRadius = 4;
    _topView.layer.masksToBounds = 1;
    
    [[UIApplication sharedApplication].keyWindow addSubview:_topView];
    
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 2 / 3, 60)];
    infoLabel.font = [UIFont systemFontOfSize:20];
    infoLabel.textAlignment = 1;
    infoLabel.textColor = [ConfigUITools colorWithR:90 G:173 B:243 A:1];
    infoLabel.text = title;
    [_topView addSubview:infoLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth * 2 / 3, 1)];
    line.backgroundColor = [ConfigUITools colorWithR:90 G:173 B:243 A:1];
    
    [_topView addSubview:line];
    
    
    for (int i = 0 ; i < array.count; i ++) {
        
        UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        typeBtn.tag = i;
        [typeBtn setTitle:array[i] forState:UIControlStateNormal];
        [typeBtn addTarget:self action:@selector(typeTipBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        typeBtn.frame = CGRectMake(0, 61 + i * 47, kScreenWidth * 2 / 3, 45);
        typeBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_topView addSubview:typeBtn];
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(typeBtn.frame), kScreenWidth * 2 / 3, 1)];
        line1.backgroundColor = [UIColor lightGrayColor];
        
        [_topView addSubview:line1];
        
        
    }
    
    
    
}

- (void)hidePopupView:(UITapGestureRecognizer*)gesture {
    
    [_coverView removeFromSuperview];
    [_topView removeFromSuperview];
}
- (void)typeTipBtnClicked:(UIButton *)sender {
    
    [_coverView removeFromSuperview];
    [_topView removeFromSuperview];
    NSString *btnTitle = @"";
    switch (sender.tag) {
        case 0:
            
            btnTitle = sender.titleLabel.text;
            
            break;
        case 1:
            
            btnTitle = sender.titleLabel.text;
            
            break;
        case 2:
            
            btnTitle = sender.titleLabel.text;
            
            break;
        case 3:
            
            btnTitle = sender.titleLabel.text;
            
            break;
            
        default:
            break;
    }
    [_notiTypeBtn setTitle:btnTitle forState:UIControlStateNormal];
    
    
    
    
}
#pragma mark - BoPhotoPickerProtocol
- (void)photoPickerDidCancel:(AJPhotoPickerViewController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoPicker:(AJPhotoPickerViewController *)picker didSelectAssets:(NSArray *)assets {
    [self.photos addObjectsFromArray:assets];
    OPLog(@"cc %ld",self.photos.count);
    if (assets.count > 0) {
       
        for (UIImageView *view in _scrollView.subviews) {
            
            [view removeFromSuperview];

        }
        
        
        CGFloat x = 0;
        CGRect frame = CGRectMake(0, 0, 100, 100);
        for (int i = 0 ; i < self.photos.count; i++) {
            ALAsset *asset = self.photos[i];
            UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            
            NSData * imageData = UIImageJPEGRepresentation(tempImg, 1.0f);
            
            NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            [_postPics addObject:encodedImageStr];

            frame.origin.x = x;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
            [imageView setContentMode:UIViewContentModeScaleAspectFill];
            imageView.clipsToBounds = YES;
            imageView.image = tempImg;
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBig:)]];
            [self.scrollView addSubview:imageView];
            x += frame.size.width+5;
        }
        self.scrollView.contentSize = CGSizeMake(105 * self.photos.count, 0);
    }
    [picker dismissViewControllerAnimated:NO completion:nil];
OPLog(@"ccpic %ld",self.postPics.count);
//    //显示预览
//        AJPhotoBrowserViewController *photoBrowserViewController = [[AJPhotoBrowserViewController alloc] initWithPhotos:assets];
//        photoBrowserViewController.delegate = self;
//        [self presentViewController:photoBrowserViewController animated:YES completion:nil];

}

- (void)showBig:(UITapGestureRecognizer *)sender {
    NSInteger index = sender.view.tag;
    AJPhotoBrowserViewController *photoBrowserViewController = [[AJPhotoBrowserViewController alloc] initWithPhotos:self.photos index:index];
    photoBrowserViewController.delegate = self;
    [self presentViewController:photoBrowserViewController animated:YES completion:nil];
}


#pragma mark - Action




- (void)photoBrowser:(AJPhotoBrowserViewController *)vc deleteWithIndex:(NSInteger)index {
    NSLog(@"%s",__func__);
}

- (void)photoBrowser:(AJPhotoBrowserViewController *)vc didDonePhotos:(NSArray *)photos {
    NSLog(@"%s",__func__);
    [self.photos removeAllObjects];
    [self.photos addObjectsFromArray:photos];
    
    if (photos.count == 1) {
       
        for (UIView *view in self.scrollView.subviews) {
            [view removeFromSuperview];
        }
        
        CGFloat x = 0;
        CGRect frame = CGRectMake(0, 0, 100, 100);
        for (int i = 0 ; i < self.photos.count; i++) {
            ALAsset *asset = self.photos[i];
            UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            frame.origin.x = x;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
            [imageView setContentMode:UIViewContentModeScaleAspectFill];
            imageView.clipsToBounds = YES;
            imageView.image = tempImg;
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBig:)]];
            [self.scrollView addSubview:imageView];
            x += frame.size.width+5;
        }
        
        self.scrollView.contentSize = CGSizeMake(105 * self.photos.count, 0);
    }
    [vc dismissViewControllerAnimated:YES completion:nil];
}




- (void)photoPicker:(AJPhotoPickerViewController *)picker didSelectAsset:(ALAsset *)asset {
    NSLog(@"%s",__func__);
}

- (void)photoPicker:(AJPhotoPickerViewController *)picker didDeselectAsset:(ALAsset *)asset {
    NSLog(@"%s",__func__);
}

//超过最大选择项时
- (void)photoPickerDidMaximum:(AJPhotoPickerViewController *)picker {
    NSLog(@"%s",__func__);
}

//低于最低选择项时
- (void)photoPickerDidMinimum:(AJPhotoPickerViewController *)picker {
    NSLog(@"%s",__func__);
}

- (void)photoPickerTapCameraAction:(AJPhotoPickerViewController *)picker {
    [self checkCameraAvailability:^(BOOL auth) {
        if (!auth) {
            NSLog(@"没有访问相机权限");
            return;
        }
        
        [picker dismissViewControllerAnimated:NO completion:nil];
        UIImagePickerController *cameraUI = [UIImagePickerController new];
        cameraUI.allowsEditing = NO;
        cameraUI.delegate = self;
        cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
        cameraUI.cameraFlashMode=UIImagePickerControllerCameraFlashModeAuto;
        
        [self presentViewController: cameraUI animated: YES completion:nil];
    }];
}
#pragma mark - UIImagePickerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *) picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo {
    if (!error) {
        NSLog(@"保存到相册成功");
    }else{
        NSLog(@"保存到相册出错%@", error);
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage;
    if (CFStringCompare((CFStringRef) mediaType,kUTTypeImage, 0)== kCFCompareEqualTo) {
        originalImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    }
//    self.imageView.image = originalImage;
    NSData * imageData = UIImageJPEGRepresentation(originalImage, 1.0f);
    
    NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [_postPics addObject:encodedImageStr];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 100, 100)];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    imageView.clipsToBounds = YES;
    imageView.image = originalImage;
    [self.photos addObject:originalImage];
    imageView.userInteractionEnabled = YES;
//    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBig:)]];
    [self.scrollView addSubview:imageView];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)checkCameraAvailability:(void (^)(BOOL auth))block {
    BOOL status = NO;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized) {
        status = YES;
    } else if (authStatus == AVAuthorizationStatusDenied) {
        status = NO;
    } else if (authStatus == AVAuthorizationStatusRestricted) {
        status = NO;
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){
                if (block) {
                    block(granted);
                }
            } else {
                if (block) {
                    block(granted);
                }
            }
        }];
        return;
    }
    if (block) {
        block(status);
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}

@end

//
//  UnionWorkViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/2/18.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "UnionWorkViewController.h"
#import "SubjectDetailViewController.h"
#import "ClassifyModel.h"
#import "WorkModel.h"
#import "MyFavorViewController.h"
#import "MySendingViewController.h"
#import "MyConsultViewController.h"
#import "ScheduleViewController.h"
#import "TaskViewController.h"
#import "ActivityViewController.h"
#import "PublicNoticeViewController.h"
#import "MyShowViewController.h"
#import "UserDeptViewController.h"
#import "SendOfficialViewController.h"

#define kHeight 40
#define kFont  15
#define kLabelWidth 75
#define kContentStart 105
#define kContentWidth  [UIScreen mainScreen].bounds.size.width - kContentStart - 10


#define kBtnWdith 60
#define kRow 4
#define kTopToBot  10
#define kBtnMargin (kScreenWidth - kRow * kBtnWdith) / (kRow + 1)

@interface UnionWorkViewController ()<HorizontalMenuDelegate>
@property (nonatomic, strong) HorizontalMenu *menu;//
@property (nonatomic, strong) UIScrollView   *workBackScrollView;
@property (nonatomic, strong) UIView         *topBackView;
@property (nonatomic, strong) UIView         *workView;
@property (nonatomic, strong) NSMutableArray         *dataArray;
@property (nonatomic, strong) UIView         *searchView;

@property (nonatomic, strong) UIScrollView *backgroungScrollView;

@property (nonatomic, strong) UITextField  *unionNameTF;
@property (nonatomic, strong) UITextField  *unionAddressTF;
@property (nonatomic, strong) UITextField  *unionCodeTF;
@property (nonatomic, strong) UITextField  *unionPresidentTF;

@property (nonatomic, strong) UIButton     *searchBtn;
@property (nonatomic, strong) NSArray         *elementArray;


@end



@implementation UnionWorkViewController

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工会工作";
    
    [self configUI];
    
    
     [_workView addSubview:[self getUnionSubjectsDataWithType:@"mokuaifenlei" pageSize:0 navIndex:0 filter:@"uppermodulename=\"通用办公\"" onScrollView:_workBackScrollView withTag:0 ]];
    

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(resetBtnClicked)];
    self.navigationItem.rightBarButtonItem = rightItem;

}

- (void)configUI {

    
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    if (!_workView) {
        
        _workView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight - 64 - 49)];
        _workView.backgroundColor = kBackColor;
        [self.view addSubview:_workView];
        
    }

    
    
    self.view.backgroundColor = kBackColor;
    _menu  = [[HorizontalMenu alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) withTitles:@[ @"工会工作", @"工会查询"]];
    _menu.delegate = self;
    [self.view addSubview:_menu];
    
    
    
    _topBackView = [[UIView alloc]initWithFrame:CGRectMake(0 ,  0, kScreenWidth   , kBtnWdith + 3 *kBtnMargin )];
    _topBackView.backgroundColor = [UIColor whiteColor];
    [_workView addSubview:_topBackView];
    NSArray *titleArr = @[@"我的收藏",@"我的咨询",@"发送的通知"];
    for (int i = 0; i < 3; i ++) {
        
        UIButton *topBtn = [[UIButton alloc]initWithFrame:CGRectMake(kBtnMargin + i *  (kBtnMargin + kBtnWdith),  kBtnMargin , kBtnWdith , kBtnWdith)];
        if (i == 0) {
            
            NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"icon_%@",@"13"] ofType:@"png"];
            [topBtn setBackgroundImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
            
        }else if(i == 1) {
            
            NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"icon_%@",@"17"] ofType:@"png"];
            [topBtn setBackgroundImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
            
        }else {
            
            
            NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"icon_%@",@"16"] ofType:@"png"];
            [topBtn setBackgroundImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        }
        
        topBtn.tag = 555 + i;
        topBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [topBtn setTitleEdgeInsets:UIEdgeInsetsMake(kBtnWdith +  kBtnMargin + 4, -kBtnMargin / 2, 0, -kBtnMargin / 2)];
        [topBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [topBtn addTarget:self action:@selector(topBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_topBackView addSubview:topBtn];
        
        
    }
    

}


- (void)configSearchView {


    _backgroungScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49)];
    _backgroungScrollView.backgroundColor = kBackColor;
    _backgroungScrollView.userInteractionEnabled = YES;
    [_searchView addSubview:_backgroungScrollView];
    
    NSLog(@"ddffd%@",NSStringFromCGRect(_backgroungScrollView.frame));
    
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:_backgroungScrollView];

        
        if (!_elementArray) {//90 173 243
            
            _elementArray = @[@"iconfont-biaoti",@"工会名称:", @"iconfont-leixing",@"工会地址:",@"iconfont-zhidingfanwei",@"工会代码:",@"iconfont-banshizhinan",@"工会主席:"];
        }
        
        for (int i = 0; i < 4; i ++) {
 
            UIView *view = [[UIView alloc]init];
            
            [_backgroungScrollView addSubview:view];
            view.backgroundColor = kBackColor;
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 11 , 18, 18)];
            img.image = [UIImage imageNamed:_elementArray[2 * i]];
            [view addSubview:img];
            
            
            UILabel *titleLabel1 = [[UILabel alloc]init];
            
            titleLabel1.text = _elementArray[i * 2 + 1];
            titleLabel1.font = [UIFont systemFontOfSize:kFont];
            [view addSubview:titleLabel1];
            
            view.frame = CGRectMake(0, i * (kHeight + 1), kScreenWidth, kHeight);
            titleLabel1.frame = CGRectMake(38, 10, kLabelWidth, 20);
            
        }

    
        
        _unionNameTF = [[UITextField alloc]init];
        _unionNameTF.backgroundColor = kTestColor;
        _unionNameTF.frame = CGRectMake(kContentStart, 0, kContentWidth, kHeight);
        _unionNameTF.font = [UIFont systemFontOfSize:kFont];
//        _unionNameTF.delegate = self;
        _unionNameTF.layer.cornerRadius = 4;
        _unionNameTF.layer.masksToBounds = 1;
        [_backgroungScrollView addSubview:_unionNameTF];
        
        _unionAddressTF = [[UITextField alloc]init];
        _unionAddressTF.backgroundColor = kTestColor;
        _unionAddressTF.frame = CGRectMake(kContentStart, kHeight + 1, kContentWidth, kHeight);
        _unionAddressTF.font = [UIFont systemFontOfSize:kFont];
//        _unionAddressTF.delegate = self;
        _unionAddressTF.layer.cornerRadius = 4;
        _unionAddressTF.layer.masksToBounds = 1;
        [_backgroungScrollView addSubview:_unionAddressTF];
        
        _unionCodeTF = [[UITextField alloc]init];
        _unionCodeTF.backgroundColor = kTestColor;
        _unionCodeTF.frame = CGRectMake(kContentStart, 2 * (kHeight + 1), kContentWidth, kHeight);
        _unionCodeTF.font = [UIFont systemFontOfSize:kFont];
//        _unionCodeTF.delegate = self;
        _unionCodeTF.layer.cornerRadius = 4;
        _unionCodeTF.layer.masksToBounds = 1;
        [_backgroungScrollView addSubview:_unionCodeTF];
        
        _unionPresidentTF = [[UITextField alloc]init];
        _unionPresidentTF.backgroundColor = kTestColor;
        _unionPresidentTF.frame = CGRectMake(kContentStart, 3 * (kHeight + 1), kContentWidth, kHeight);
        _unionPresidentTF.font = [UIFont systemFontOfSize:kFont];
//        _unionPresidentTF.delegate = self;
        _unionPresidentTF.layer.cornerRadius = 4;
        _unionPresidentTF.layer.masksToBounds = 1;
        [_backgroungScrollView addSubview:_unionPresidentTF];
        
        
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.backgroundColor = kBtnColor;
        [_searchBtn setTitle:@"查询" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _searchBtn.frame = CGRectMake(20, CGRectGetMaxY(_unionPresidentTF.frame) + 20, kScreenWidth - 40, kHeight);

        _searchBtn.layer.cornerRadius = 4;
        _searchBtn.layer.masksToBounds = 1;
        [_backgroungScrollView addSubview:_searchBtn];
        

            [ConfigUITools sizeToScroll:_backgroungScrollView withStandardElementMaxY:CGRectGetMaxY(_searchBtn.frame) + 25 forStepsH:0];



}



- (void)topBtn:(UIButton *)sender {

    
    switch (sender.tag - 555) {
        case 0:
            [self.navigationController pushViewController:[[MyFavorViewController alloc]init] animated:YES];
            
            break;
        case 1:
             [self.navigationController pushViewController:[[MyConsultViewController alloc]init] animated:YES];
            
            break;
        case 2:
             [self.navigationController pushViewController:[[MySendingViewController alloc]init] animated:YES];
            
            break;
            
        default:
            break;
    }


}

- (void)clieckButton:(UIButton *)button
{

    
    switch (button.tag) {
        case 0:
            _searchView.hidden = YES;
            _workView.hidden = NO;
            
            break;
        case 1:
            
            _workView.hidden = YES;
            _searchView.hidden = NO;
            if (!_searchView) {
                
                _searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, kScreenHeight - 64 - 49)];
                _searchView.backgroundColor = kBackColor;
                [self.view addSubview:_searchView];
                
            }
            
            [self configSearchView];
            
            break;
            
        default:
            break;
    }
    

}

- (void)searchBtnClicked {


    

}

- (void)selectedModel:(UIButton *)sender {
    
    NSString *modelName = sender.titleLabel.text;
    
    UIViewController  *modelCopntroller = [[UIViewController alloc]init];
    if ([modelName isEqualToString:@"日程安排"]) {
        
        modelCopntroller = [[ScheduleViewController alloc]init];
        
    }
    if ([modelName isEqualToString:@"工作动态"]) {
        
        modelCopntroller = [[ActivityViewController alloc]init];
    }
    if ([modelName isEqualToString:@"通知公告"]) {
        
        modelCopntroller = [[PublicNoticeViewController alloc]init];
    }
    if ([modelName isEqualToString:@"通讯录"]) {
        modelCopntroller = [[UserDeptViewController alloc]init];
        
    }
    if ([modelName isEqualToString:@"公文收文"]) {
//        fld_41_14=43
        
        SendOfficialViewController *offRec = [[SendOfficialViewController alloc]init];
        offRec.filter = @"fld_41_14=43";
        offRec.subTitle = @"公文收文";
        modelCopntroller = offRec;
    }
    if ([modelName isEqualToString:@"公文发文"]) {
        SendOfficialViewController *offSen = [[SendOfficialViewController alloc]init];
        offSen.filter = @"fld_41_14=44";
        offSen.subTitle = @"公文发文";
        modelCopntroller = offSen;
    }
    if ([modelName isEqualToString:@"成果展示"]) {
        
        modelCopntroller = [[MyShowViewController alloc]init];
    }
    if ([modelName isEqualToString:@"工作任务"]) {
        
        modelCopntroller = [[TaskViewController alloc]init];
    }
    if ([modelName isEqualToString:@"内部咨询"]) {
        
        modelCopntroller = [[MyConsultViewController alloc]init];
    }

//            SubjectDetailViewController *subD = [[SubjectDetailViewController alloc]init];
//            subD.requestTag = sender.tag;
//            subD.dataType = @"zhengcefagui";
//            subD.filter =  [NSString stringWithFormat:@"Datatype=\"%@\"",sender.titleLabel.text];
//            subD.subjectTitle = sender.titleLabel.text;
            [self.navigationController pushViewController:modelCopntroller animated:YES];
    
}


- (UIScrollView *)getUnionSubjectsDataWithType:(NSString *)type pageSize:(NSInteger)pageSize navIndex:(NSInteger)index filter:(NSString *)filter onScrollView:(UIScrollView *)scrollView withTag:(NSInteger)viewTag{
    
    
    if (!scrollView) {
        
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_topBackView.frame) + 15, kScreenWidth, kScreenHeight - 64 - CGRectGetMaxY(_topBackView.frame) -49 - 15)];
        scrollView.backgroundColor = [UIColor whiteColor];
        _workBackScrollView = scrollView;
    }
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD showWithStatus:@"增在加载..."];
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
                OPLog(@"-unionWor-%@",[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] class]);
                if ([NSNull null] ==[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]) {

                    [SVProgressHUD showErrorWithStatus:@"没有更多的数据哦"];

                    
                }else {
                    
                    NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                    [SVProgressHUD showSuccessWithStatus:@"加载完成"];
                    OPLog(@"%@",listDic);
                    
                    OPLog(@"------%@----------",[listDic objectForKey:@"rows"]);
                    
                    for (NSDictionary *dict in [listDic objectForKey:@"rows"]) {
                        WorkModel  *classifyModel = [[WorkModel alloc]init];
                        [classifyModel setValuesForKeysWithDictionary:dict];
                        [_dataArray addObject:classifyModel];
                        
                    }
 
                            NSInteger line = 0;
                            if (_dataArray.count % kRow == 0) {
                                
                                line = _dataArray.count / kRow;
                                
                            }else {
                                
                                line = _dataArray.count / kRow + 1;
                                
                            }
                            
                            
                            
                            for (int i = 0; i < line; i ++) {
                                
                                for (int j = 0; j < kRow ; j ++) {
                                    
                                    if (i == line - 1) {
                                        
                                        if ( j == _dataArray.count - (line - 1 )* kRow ) {
                                            
                                            return ;
                                        }
                                        
                                    }
                                    UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                                    topBtn.frame = CGRectMake(kBtnMargin + j *  (kBtnMargin + kBtnWdith),  kBtnMargin + i *(kBtnMargin + kBtnWdith + kTopToBot), kBtnWdith , kBtnWdith );
                                    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"icon_%@",[_dataArray[kRow * i + j] appicon]] ofType:@"png"];
                                    [topBtn setBackgroundImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
                                    topBtn.tag = [[_dataArray[kRow * i + j] appicon] integerValue];
                                    topBtn.titleLabel.font = [UIFont systemFontOfSize:12];
                                    topBtn.tag = [[_dataArray[kRow * i + j] appicon]integerValue ];
                                    [topBtn setTitleEdgeInsets:UIEdgeInsetsMake(kBtnWdith +  kBtnMargin + 4, -kBtnMargin / 2, 0, -kBtnMargin / 2)];
                                    [topBtn setTitle:[_dataArray[kRow * i + j] modulename] forState:UIControlStateNormal];
                                    [topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                                    [topBtn addTarget:self action:@selector(selectedModel:) forControlEvents:UIControlEventTouchUpInside];
                                    [scrollView addSubview:topBtn];
                                    
                                }
                                
                            }
                            
                            
                            
                            scrollView.contentSize = CGSizeMake(kScreenWidth, 5 * (kBtnWdith + 2 * kBtnMargin));
                            

                    
                }
                
                
                
            });
            
            
        };
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"GetJsonListDataResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];
        
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    return scrollView;
    
}

- (void)resetBtnClicked {
    

    
            
    [_workBackScrollView removeFromSuperview];
    _workBackScrollView = nil;
    
    [_workView addSubview:[self getUnionSubjectsDataWithType:@"mokuaifenlei" pageSize:0 navIndex:0 filter:@"uppermodulename=\"通用办公\"" onScrollView:_workBackScrollView withTag:0 ]];
    
    
}


@end

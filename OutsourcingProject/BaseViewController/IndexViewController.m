//
//  IndexViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/2/18.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "IndexViewController.h"
#import "SDCycleScrollView.h"
@interface IndexViewController ()

@end

@implementation IndexViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];

    self.navigationController.navigationBarHidden = 1;
    //    [_userChatTableView.mj_header beginRefreshing];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    self.navigationController.navigationBarHidden = 1;
    [self creatScrollerView];
    [self getRequestData];
    
    // Do any additional setup after loading the view.
}

- (void)creatScrollerView {

    
    
    UIView *headScrollerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];

    headScrollerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:headScrollerView];
    

    
    
    // 情景一：采用本地图片实现
    NSArray *imageNames = @[@"h1.jpg",
                            @"h2.jpg",
                            @"h3.jpg",
                            @"h4.jpg",
                            @"h7" // 本地图片请填写全名
                            ];
    
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    // 情景三：图片配文字
    NSArray *titles = @[@"新建交流QQ群：185534916 ",
                        @"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到gsdios@126.com"
                        ];
    
    CGFloat w = self.view.bounds.size.width;
    
    
//    
//    // >>>>>>>>>>>>>>>>>>>>>>>>> demo轮播图1 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//    
//    // 本地加载 --- 创建不带标题的图片轮播器
//    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, w, 180) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
//    cycleScrollView.delegate = self;
//    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
//    [demoContainerView addSubview:cycleScrollView];
//    //         --- 轮播时间间隔，默认1.0秒，可自定义
//    //cycleScrollView.autoScrollTimeInterval = 4.0;
//    
    
    // >>>>>>>>>>>>>>>>>>>>>>>>> demo轮播图2 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 280, w, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [headScrollerView addSubview:cycleScrollView2];
    
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    });
   
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getRequestData {
    
    NSString *requestBody = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap12:Envelope "
                             "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                             "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                             "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                             "<soap12:Body>"
                             "<CheckUserLogin xmlns=\"Net.GongHuiTong\">"
                             "<username>tflb</username>"
                             "<userpass>123456</userpass>"
                             "</CheckUserLogin>"
                             "</soap12:Body>"
                             "</soap12:Envelope>"];
    ReturnValueBlock returnBlock = ^(id resultValue){
        
        NSLog(@"------%@----------",[[resultValue lastObject] objectForKey:@"CheckUserLoginResult"]);
        //        NSError *error;
        //        NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        //
        //
        //        NSString *content = [[[listDic objectForKey:@"rows"] lastObject] objectForKey:@"chcontent"];
        //        content = [content htmlEntityDecode];
        //
        //        content = [content stringByReplacingOccurrencesOfString:@"/ueditor/server/upload/" withString:@"http://pdght.nomadchina.com/ueditor/server/upload/ueditor/server/upload/"];
        //        [webView loadHTMLString:content baseURL:nil];
        //
        //
        
    };
    [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"CheckUserLoginResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];
    

    
}
@end

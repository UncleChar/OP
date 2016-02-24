//
//  IndexViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/2/18.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "IndexViewController.h"
#import "SDCycleScrollView.h"
#import "SendNotifiactionViewController.h"
#import "PublicNoticeViewController.h"
#import "UserDetailInfoViewController.h"
#import "UserDeptViewController.h"
#import "TaskViewController.h"
#import "AddTaskViewController.h"
#import "ScheduleViewController.h"

#define kBtnMargin ([UIScreen mainScreen].bounds.size.width - 4 * 50) / 5
#define kBtnWdith 50

@interface IndexViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{

    SDCycleScrollView *cycleScrollView;
    NSString  *cookies;
    NSMutableArray   *dataArray;
    UITableView    *listTableView;
    CGFloat      listStart;
    NSArray   *titleArray;
    NSMutableArray   *notiArray;
    NSMutableArray   *taskArray;
    NSMutableArray   *scheduleArray;
    NSMutableArray   *activeArray;

}
@end


@implementation IndexViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];

     self.tabBarController.tabBar.hidden = 0;
    self.navigationController.navigationBarHidden = 1;
    //    [_userChatTableView.mj_header beginRefreshing];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = 1;
    [self initArray];
    [self creatScrollerView];
    [self configTopBtn];
    [self configListView];
//    [self getRequestData];
    
    [self getListData];
}

- (void)initArray {

    if (!titleArray) {
        
        titleArray = @[@"通知公告",@"任务",@"日程安排",@"工作动态"];
        
    }
    if (!notiArray) {
        
        notiArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    if (!taskArray) {
        
        taskArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    if (!scheduleArray) {
        
        scheduleArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    if (!activeArray) {
        
        activeArray = [NSMutableArray arrayWithCapacity:0];
        
    }

}


- (void)creatScrollerView {

    NSArray *imagesURLStrings = @[
                                  @"http://pic13.nipic.com/20110408/7106592_143711518153_2.jpg",
                                  @"http://pic19.nipic.com/20120319/9526373_201939127000_2.jpg"
                                  ];
    cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenWidth * 0.25) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    [self.view addSubview:cycleScrollView];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    });
}

- (void)configTopBtn {
    
    NSArray *titleBtnArray = @[@"发通知",@"发任务",@"查工会",@"通讯录"];
    NSArray *backimgArray = @[@"iconfont-tongzhi",@"iconfont-renwu",@"iconfont-unie65d",@"iconfont-tongxunlu"];
    
    for (int i = 0; i < 4; i ++) {
        
        UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];

        topBtn.frame = CGRectMake(i * (kBtnWdith + kBtnMargin )+ kBtnMargin, CGRectGetMaxY(cycleScrollView.frame) + kBtnMargin / 2, kBtnWdith, kBtnWdith);
        [topBtn setBackgroundImage:[UIImage imageNamed:backimgArray[i]] forState:UIControlStateNormal];
        topBtn.tag = 200 + i;
        topBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [topBtn setTitleEdgeInsets:UIEdgeInsetsMake(kBtnWdith +  kBtnMargin, 0, 0, 0)];
        [topBtn setTitle:titleBtnArray[i] forState:UIControlStateNormal];
        [topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:topBtn];
        [topBtn addTarget:self action:@selector(topBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        listStart = CGRectGetMaxY(topBtn.frame);
    }
   
    
}

- (void)configListView {
    
    if (!listTableView) {
        
        listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, listStart + 10 + kBtnMargin, kScreenWidth, kScreenHeight - listStart  - kBtnMargin -49 + 27) style:UITableViewStyleGrouped];
        listTableView.delegate = self;
        listTableView.dataSource = self;
        listTableView.backgroundColor = [ConfigUITools colorWithR:245 G:245 B:245 A:1];
        [self.view addSubview:listTableView];
    }

    listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        
        for (int i = 0; i < 4; i ++) {
            
//            [_userChatArrary addObject:MessaageVCRandomData];
            
        }
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            [NSThread sleepForTimeInterval:5];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                
                [listTableView.mj_header endRefreshing];
                [listTableView reloadData];
                
            });
        });
    }];

    
}
- (void)topBtnClicked:(UIButton *)sender {

    switch (sender.tag - 200) {
        case 0:

            [self.navigationController pushViewController:[[SendNotifiactionViewController alloc]init] animated:YES];
        
            break;
        case 1:
              [self.navigationController pushViewController:[[AddTaskViewController alloc]init] animated:YES];
            
            break;
        case 2:
            
            
            break;
        case 3:
            
            [self.navigationController pushViewController:[[UserDeptViewController alloc]init] animated:YES];
 
            break;
            
        default:
            break;
    }

    
}

-(void)cellHeadBtnClicked:(UIButton *)sender
{
    //处理单击操作
    switch (sender.tag - 900) {
        case 0:
            
            [self.navigationController pushViewController:[[PublicNoticeViewController alloc]init] animated:YES];
            
            break;
        case 1:
            
            [self.navigationController pushViewController:[[TaskViewController alloc]init] animated:YES];
            
            break;
        case 2:
            
            [self.navigationController pushViewController:[[ScheduleViewController alloc]init] animated:YES];
            
            break;
        case 3:
        {
            
            
        }
            
            break;
            
        default:
            break;
    }
}




#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger numberOfRows = 0;
    switch (section) {
        case 0:
            
            numberOfRows = notiArray.count;
            numberOfRows = 3;
            
            break;
        case 1:
            
            numberOfRows = taskArray.count;
            numberOfRows = 2;
            
            break;
        case 2:
            
            numberOfRows = scheduleArray.count;
            numberOfRows = 1;
            
            break;
        case 3:
            
            numberOfRows = activeArray.count;
            numberOfRows = 5;
            
            break;
            
        default:
            break;
    }
    return 0;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
//    cell.imageView.image = [UIImage imageNamed:@"icon"];
    cell.textLabel.text = @"我是测试cell行";
    
    cell.detailTextLabel.text = @"【急】";
//    cell.imageView.layer.cornerRadius = 24;
//    cell.imageView.layer.masksToBounds = 1;
//    [cell setSelected:YES animated:YES];

    return cell;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//    
//
//
//}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 50;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIButton *headView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight, 50)];
    UIImageView *leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 20, 20)];
    UILabel    *label = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 200, 30)];
    label.font = [UIFont systemFontOfSize:17];
    [headView addTarget:self action:@selector(cellHeadBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    switch (section) {
        case 0:
        {
        
            headView.backgroundColor = [UIColor whiteColor];
            UIView  *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
            line.backgroundColor = kBackColor;
            [headView addSubview:line];
            leftImg.image = [UIImage imageNamed:@"iconfont-icontggl"];
            label.text = titleArray[0];
            headView.tag = 900;
        }
   
            break;
        case 1:
            
             headView.backgroundColor = [UIColor whiteColor];
            leftImg.image = [UIImage imageNamed:@"iconfont-renwu"];
            label.text = titleArray[1];
            headView.tag = 901;
            break;
        case 2:
            
             headView.backgroundColor = [UIColor whiteColor];
            leftImg.image = [UIImage imageNamed:@"iconfont-bianji"];
            label.text = titleArray[2];
            headView.tag = 902;
            break;
        case 3:
            
             headView.backgroundColor = [UIColor whiteColor];
            leftImg.image = [UIImage imageNamed:@"iconfont-icontggl"];
            label.text = titleArray[3];
            headView.tag = 903;
            break;
            
        default:
            break;
    }
    
    [headView addSubview:leftImg];
    [headView addSubview:label];
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
//    ChatRoomViewController *chatRoomVC = [[ChatRoomViewController alloc]init];
//    chatRoomVC.chatRoomTitle = _userSearchResultArrary[indexPath.row];
//    self.userSearchController.searchBar.hidden = YES;
//    [self.userSearchController.searchBar resignFirstResponder];
//    
//    [[AppEngineManager sharedInstance] baseViewControllerPushViewController:chatRoomVC animated:YES];
//    
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    [AppEngineManager showTipsWithTitle:[NSString stringWithFormat:@"您点击的是第%ld张图片",(long)index + 1]];
//    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}


- (void)getRequestData {
   
}
- (void)getListData {

    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {
    
        //    NSString * requestBody = [NSString stringWithFormat:
        //                              @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        //                              "<soap12:Envelope "
        //                              "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
        //                              "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
        //                              "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
        //                              "<soap12:Body>"
        //                              "<GetJsonListData xmlns=\"Net.GongHuiTong\">"
        //                              "<logincookie>%@</logincookie>"
        //                              "<datatype>%@</datatype>"
        //                              "<pagesize>%d</pagesize>"
        //                              "<navindex>%d</navindex>"
        //                              "<filter>%@</filter>"
        //                              " </GetJsonListData>"
        //                              "</soap12:Body>"
        //                              "</soap12:Envelope>",@"",@"banshizhinan",0,0,@""];
        //        ListDataArray = [[NSMutableArray alloc]initWithCapacity:0];
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
                                    "<pagesize>%d</pagesize>"
                                    "<navindex>%d</navindex>"
                                    "<filter>%@</filter>"
                                    " </GetJsonListData>"
                                  "</soap12:Body>"
                                  "</soap12:Envelope>",[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],@"richenganpai",0,0,@""];
        
        ReturnValueBlock returnBlock = ^(id resultValue){
            OPLog(@"-FF-%@",[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]);
            OPLog(@"-caRRss-%@",[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] class]);
            if ([NSNull null] ==[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]) {
                
//                dispatch_async(dispatch_get_main_queue(), ^{
                
                    //                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Account or password error!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    //                            [alert show];
                    
                    OPLog(@"rrrrrrrrrrrrrerror: account or password error !");
//                    [SVProgressHUD showErrorWithStatus:@"Account or password error!"];
//                    
//                });
                
            }else {

                NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                
                OPLog(@"%@",listDic);

            }
            
        };
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"GetJsonListDataResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];

    
    }else {
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
    
    }

}

- (void)getTreeUserSysDept {
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {

        
        
        NSString * requestBody = [NSString stringWithFormat:
                                  @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                                  "<soap12:Envelope "
                                  "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                                  "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                                  "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                                  "<soap12:Body>"
                                  "<GetTreeUserSysDept xmlns=\"Net.GongHuiTong\">"
                                  "<logincookie>%@</logincookie>"
                                  "<checktype>%@</checktype>"
                                  //                                  "<ChID>%d</ChID>"
                                  " </GetTreeUserSysDept>"
                                  "</soap12:Body>"
                                  "</soap12:Envelope>",[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],@"checkbox"];
        
        ReturnValueBlock returnBlock = ^(id resultValue){
            OPLog(@"%@",[[resultValue lastObject] objectForKey:@"GetTreeUserSysDeptResult"]);
            if ([NSNull null] ==[[resultValue lastObject] objectForKey:@"GetTreeUserSysDeptResult"]) {
                
                //                dispatch_async(dispatch_get_main_queue(), ^{
                
                
                //                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Account or password error!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                //                            [alert show];
                
                OPLog(@"rrrrrrrrrrrrrerror: account or password error !");
                //                    [SVProgressHUD showErrorWithStatus:@"Account or password error!"];
                //
                //                });
                
            }else {
                
                NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetTreeUserSysDeptResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                
                OPLog(@"%@",listDic);
                
            }
            
        };
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"GetTreeUserSysDeptResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];
        
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
}

@end

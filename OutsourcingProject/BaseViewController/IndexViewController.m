//
//  IndexViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/2/18.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "IndexViewController.h"
#import "SDCycleScrollView.h"
#import "PublicNoticeViewController.h"
#import "ContactViewController.h"

#define kBtnMargin 15
#define kBtnWdith ([UIScreen mainScreen].bounds.size.width - 75 ) / 4

@interface IndexViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{

    SDCycleScrollView *cycleScrollView;
    NSString  *cookies;
    NSMutableArray   *dataArray;
    UITableView    *listTableView;
    CGFloat      listStart;
    NSArray   *titleArray;

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
    
    [self creatScrollerView];
    [self configTopBtn];
    [self configListView];
//    [self getRequestData];
    
    [self getListData];
}




- (void)creatScrollerView {

    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 20, kScreenWidth, 120) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
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
        topBtn.frame = CGRectMake(i * (kBtnWdith + kBtnMargin )+ kBtnMargin, CGRectGetMaxY(cycleScrollView.frame) + kBtnMargin, kBtnWdith, kBtnWdith);
        [topBtn setBackgroundImage:[UIImage imageNamed:backimgArray[i]] forState:UIControlStateNormal];
        topBtn.tag = 200 + i;
        topBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [topBtn setTitleEdgeInsets:UIEdgeInsetsMake(kBtnWdith + 2 * kBtnMargin, 0, 0, 0)];
        [topBtn setTitle:titleBtnArray[i] forState:UIControlStateNormal];
        [topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:topBtn];
        [topBtn addTarget:self action:@selector(topBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        listStart = CGRectGetMaxY(topBtn.frame);
    }
   
    
    
}

- (void)configListView {
    
    if (!listTableView) {
        
        listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, listStart + 3 * kBtnMargin - 10, kScreenWidth, kScreenHeight - listStart - 3 * kBtnMargin -49 + 10) style:UITableViewStyleGrouped];
        listTableView.delegate = self;
        listTableView.dataSource = self;
        listTableView.backgroundColor = [ConfigUITools colorWithR:245 G:245 B:245 A:1];
        [self.view addSubview:listTableView];
    }
    if (!titleArray) {
        
        titleArray = @[@"通知公告",@"任务",@"日程安排",@"工作动态"];
        
    }
    
    
}
- (void)topBtnClicked:(UIButton *)sender {

    switch (sender.tag - 200) {
        case 0:
        {
            [self.navigationController pushViewController:[[ContactViewController alloc]init] animated:YES];
        
        
        
        }
            
            
            break;
        case 1:
            
            
            break;
        case 2:
            
            
            break;
        case 3:
            
            
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
    
    return 3;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
//    cell.imageView.image = [UIImage imageNamed:@"icon"];
    cell.textLabel.text = @"2222";
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
    [headView addTarget:self action:@selector(headBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    switch (section) {
        case 0:
        {
        
            headView.backgroundColor = [UIColor whiteColor];
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

-(void)headBtnClicked:(UIButton *)sender
{
    //处理单击操作
    switch (sender.tag - 900) {
        case 0:
        {
            [self.navigationController pushViewController:[[PublicNoticeViewController alloc]init] animated:YES];
            
            
            
        }
            
            
            break;
        case 1:
            
            
            break;
        case 2:
            
            
            break;
        case 3:
            
            
            break;
            
        default:
            break;
    }
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
    NSLog(@"---点击了第%ld张图片", (long)index);
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getRequestData {
   
}
- (void)getListData {

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
                                  "</soap12:Envelope>",[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],@"huiyitongzhi",0,0,@""];
        ReturnValueBlock returnBlock = ^(id resultValue){
            NSLog(@"%@",[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]);
            NSDictionary *listDic = [NSJSONSerialization JSONObjectWithData:[[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];

            NSLog(@"%@",listDic);

        };
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"GetJsonListDataResult"] WithReturnValeuBlock:returnBlock WithErrorCodeBlock:nil];

}



@end

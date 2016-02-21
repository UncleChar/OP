//
//  PublicNoticeViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/20.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "PublicNoticeViewController.h"
#import "SendNotifiactionViewController.h"

@interface PublicNoticeViewController ()<HorizontalMenuDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UITableView    *showTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView         *topSearchView;
@property (nonatomic, strong) UITextField    *meetingSearchTF;      //
@property (nonatomic, strong) UITextField    *activeSearchTF;      //
@property (nonatomic, strong) UITextField    *otherSearchTF;
@property (nonatomic, strong) HorizontalMenu *menu;//


@end

@implementation PublicNoticeViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = 0;
    self.title = @"通知公告";
    //    //    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    //    //    {
    //            self.navigationController.navigationBar.translucent = NO;
    //    //    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBackColor;
    
   _menu  = [[HorizontalMenu alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30) withTitles:@[@"会议通知", @"其他通知", @"我发出的通知"]];
    _menu.delegate = self;
    [self.view addSubview:_menu];
    
    
    _topSearchView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_menu.frame) + 15, kScreenWidth, 40)];
    _topSearchView.backgroundColor = kBackColor;
    [self.view addSubview:_topSearchView];

    [_topSearchView addSubview:[self searchTextFieldWithTag:0]];
    [self initShowTableView];
    
    
   
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    

    UIButton *sendNotiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [sendNotiBtn setBackgroundImage:[UIImage imageNamed:@"send"] forState:UIControlStateNormal];
    sendNotiBtn.backgroundColor = kTinColor;
    sendNotiBtn.layer.cornerRadius = 4;
    sendNotiBtn.layer.masksToBounds = 1;
    sendNotiBtn.frame = CGRectMake(20, CGRectGetMaxY(_showTableView.frame) + 5.5 , kScreenWidth - 40, 40);
//    sendNotiBtn.alpha = 0.7;
    [sendNotiBtn setTitle:@"发通知" forState:UIControlStateNormal];
    [sendNotiBtn addTarget:self action:@selector(sendNotiBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendNotiBtn];
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
    //        cell.textLabel.text = _cellTitleArray[indexPath.row]
    
 
    cell.textLabel.text  = @"业务指导";
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    MultiTextView *labelView = [self richLabelWithFrame:CGRectMake(75, 48, kScreenWidth - 80, 20)];
    
    [cell addSubview:labelView];
    
    
    
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

- (void)initShowTableView{
    
    if (!_showTableView) {
        _showTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topSearchView.frame), kScreenWidth, kScreenHeight - 40 - CGRectGetMaxY(_topSearchView.frame) - 75) style:UITableViewStylePlain];
        
        _showTableView.delegate=self;
        _showTableView.dataSource=self;
        
        
    }
    [self.view addSubview:_showTableView];
    
}


- (UITextField *)searchTextFieldWithTag:(NSInteger)tag {
    
    UITextField *tf;
    UIImageView *leftImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"condSearch@2x"]];
    leftImg.frame = CGRectMake(5, 7.5, 15, 15);
    
    switch (tag) {
        case 0:
        {
            if (nil == _meetingSearchTF) {
                
                _meetingSearchTF = [[UITextField alloc]initWithFrame:CGRectMake(5, 3, kScreenWidth - 10, 30)];
                _meetingSearchTF.delegate = self;
                _meetingSearchTF.backgroundColor = [UIColor whiteColor];
                _meetingSearchTF.leftView = leftImg;
//                _meetingSearchTF.text = @"";
                _meetingSearchTF.leftViewMode = UITextFieldViewModeUnlessEditing;
                _meetingSearchTF.borderStyle = UITextBorderStyleRoundedRect;
                _meetingSearchTF.clearButtonMode = UITextFieldViewModeAlways;
                
            }
            
            tf = _meetingSearchTF;
        }
            
            break;
            
        case 1:
        {
            if (nil == _activeSearchTF) {
                
                _activeSearchTF = [[UITextField alloc]initWithFrame:CGRectMake(5, 3, kScreenWidth - 10, 30)];
                _activeSearchTF.delegate = self;
                _activeSearchTF.backgroundColor = [UIColor whiteColor];
                _activeSearchTF.leftView = leftImg;
//                _activeSearchTF.text = @"_activeSearchTF";
                _activeSearchTF.leftViewMode = UITextFieldViewModeUnlessEditing;
                _activeSearchTF.borderStyle = UITextBorderStyleRoundedRect;
                _activeSearchTF.clearButtonMode = UITextFieldViewModeAlways;
                
            }
            
            tf = _activeSearchTF;
        }
            
            break;
        case 2:
        {
            if (nil == _otherSearchTF) {
                
                _otherSearchTF = [[UITextField alloc]initWithFrame:CGRectMake(5, 3, kScreenWidth - 10, 30)];
                _otherSearchTF.delegate = self;
                _otherSearchTF.backgroundColor = [UIColor whiteColor];
                _otherSearchTF.leftView = leftImg;
//                _otherSearchTF.text = @"_otherSearchTF";
                _otherSearchTF.leftViewMode = UITextFieldViewModeUnlessEditing;
                _otherSearchTF.borderStyle = UITextBorderStyleRoundedRect;
                _otherSearchTF.clearButtonMode = UITextFieldViewModeAlways;
                
            }
            
            tf = _otherSearchTF;
        }
            
            break;
            
        default:
            break;
    }
    
    return  tf;
    
}




- (MultiTextView *)richLabelWithFrame:(CGRect)frame {
    
    NSMutableArray* setArray_f = [[NSMutableArray alloc] initWithCapacity:5];
    [setArray_f addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],@"Color",[UIFont systemFontOfSize:15],@"Font",nil]];
    [setArray_f addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],@"Color",[UIFont systemFontOfSize:15],@"Font",nil]];

    
    MultiTextView* showLable = [[MultiTextView alloc] initWithFrame:frame];
    showLable.alignmentType = Muti_Alignment_Left_Type;
    [showLable setShowText:@"急|   刘德华   2016-2-19" Setting:setArray_f];

    return showLable;
    
}

#pragma mark - HorizontalMenuDelegate

- (void)clieckButton:(UIButton *)button
{
    NSLog(@"%ld", button.tag);
    
    switch (button.tag) {
        case 0:

            [_meetingSearchTF removeFromSuperview];
            [_topSearchView addSubview: [self searchTextFieldWithTag:0]];
            
            break;
        case 1:

            if (_activeSearchTF) {
                [_activeSearchTF removeFromSuperview];
            }
            [_topSearchView addSubview: [self searchTextFieldWithTag:1]];
            
            break;
        case 2:
            
            if (_otherSearchTF) {
                [_otherSearchTF removeFromSuperview];
            }
           [_topSearchView addSubview: [self searchTextFieldWithTag:2]];
            
            break;
            
        default:
            break;
    }
   
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    NSLog(@"%@",_meetingSearchTF.text);
    [self.view endEditing:YES];
    return 1;
}

- (void)sendNotiBtnClicked:(UIButton *)sender {

    [self.navigationController pushViewController:[[SendNotifiactionViewController alloc]init] animated:YES];
    
}

@end

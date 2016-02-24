//
//  ActivityViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/24.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "ActivityViewController.h"

@interface ActivityViewController ()<HorizontalMenuDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UITableView    *activityTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView         *topSearchView;
@property (nonatomic, strong) UITextField    *meetingSearchTF;      //
@property (nonatomic, strong) UITextField    *activeSearchTF;      //
@property (nonatomic, strong) UITextField    *otherSearchTF;
@property (nonatomic, strong) HorizontalMenu *menu;//



@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作动态";
    _menu  = [[HorizontalMenu alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) withTitles:@[@"我收到的动态", @"我发出的动态"]];
    _menu.delegate = self;
    [self.view addSubview:_menu];
    
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        
    }

    [self initShowTableView];
    
    
    

    
    
    UIButton *addActivityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [sendNotiBtn setBackgroundImage:[UIImage imageNamed:@"send"] forState:UIControlStateNormal];
    addActivityBtn.backgroundColor = kBtnColor;
    addActivityBtn.layer.cornerRadius = 4;
    addActivityBtn.layer.masksToBounds = 1;
    addActivityBtn.frame = CGRectMake(20, CGRectGetMaxY(_activityTableView.frame) + 5 , kScreenWidth - 40, 40);
    //    sendNotiBtn.alpha = 0.7;
    [addActivityBtn setTitle:@"新建动态" forState:UIControlStateNormal];
    [addActivityBtn addTarget:self action:@selector(addActivityBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addActivityBtn];
}



- (void)initShowTableView{
    
    if (!_activityTableView) {
        _activityTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 45, kScreenWidth, kScreenHeight - 45 - 64 - 50) style:UITableViewStylePlain];
        _activityTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _activityTableView.delegate=self;
        _activityTableView.dataSource=self;

        
        
    }
    [self.view addSubview:_activityTableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count + 15;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
        cell.imageView.image = [UIImage imageNamed:@"iconfont-iconfont73（合并）-拷贝-3"];
        cell.textLabel.text  = @"业务指导";
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.detailTextLabel.text = @"test again 李小龙 2016 - 2 - 25";
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.imageView.image = [UIImage imageNamed:_cellImgArray[(indexPath.row + 1) / 2 - 1]];
//        cell.textLabel.text = _cellTitleArray[(indexPath.row + 1) / 2 - 1];
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    UserInfoViewController  *use = [[UserInfoViewController alloc]init];
    //    [self.navigationController pushViewController:use animated:YES];
    //    [self.navigationController pushViewController:_controllersArray[indexPath.row] animated:NO];
    
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
    OPLog(@"%d", button.tag);
    
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
    
    OPLog(@"%@",_meetingSearchTF.text);
    [self.view endEditing:YES];
    return 1;
}

- (void)addActivityBtnClicked:(UIButton *)sender {
    
//    [self.navigationController pushViewController:[[SendNotifiactionViewController alloc]init] animated:YES];
//    
}


@end

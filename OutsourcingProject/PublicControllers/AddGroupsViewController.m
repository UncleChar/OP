//
//  AddGroupsViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/22.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "AddGroupsViewController.h"
#import "UserDeptViewController.h"
#define kHeight 40
@interface AddGroupsViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSArray  *elementArray;

@property (nonatomic, strong) UITextField  *groupNamesTF;
@property (nonatomic, strong) UITextField  *remarkTF;
@property (nonatomic, strong) UIButton  *usersSelectedBtn;

@end

@implementation AddGroupsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发通知";

    [self initElement];
    
    
}


- (void)initElement{
    
    if (!_elementArray) {//90 173 243
        
        _elementArray = @[@"iconfont-banshizhinan",@"组名:    ",@"iconfont-mingcheng（合并）",@"备注:    ",@"iconfont-people",@"选择人员:"];
    }
    
    for (int i = 0; i < 3; i ++) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, i * (kHeight + 1), kScreenWidth, kHeight)];
        [self.view addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 11 , 18, 18)];
        img.image = [UIImage imageNamed:_elementArray[2 * i]];
        [view addSubview:img];
        
        UILabel *titleLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(38, 10, 60, 20)];
        titleLabel1.text = _elementArray[i * 2 + 1];
        titleLabel1.font = [UIFont systemFontOfSize:12];
        [view addSubview:titleLabel1];
    }
    
        UIButton  *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.backgroundColor = kTestColor;
        submitBtn.tag = 333 + 1;
//        [submitBtn setBackgroundImage:[UIImage imageNamed:@"矩形-9"] forState:UIControlStateNormal];

    submitBtn.backgroundColor = kBtnColor;
        [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        submitBtn.layer.cornerRadius = 4;
        submitBtn.layer.masksToBounds = 1;
        submitBtn.frame = CGRectMake(20, 140, kScreenWidth - 40, 40);
//        submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        submitBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:submitBtn];
    
    [self addSubviews];
    
    
    
    
}

- (void)addSubviews {
    
    
    _groupNamesTF = [[UITextField alloc]initWithFrame:CGRectMake(95, 0, kScreenWidth - 120, kHeight)];
    [self.view addSubview:_groupNamesTF];
    
    _remarkTF = [[UITextField alloc]initWithFrame:CGRectMake(95, 1 * kHeight + 1, kScreenWidth - 120, kHeight)];
    [self.view addSubview:_remarkTF];
    
    
    
//    _notiTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _notiTypeBtn.tag = 888 + 0;
//    _notiTypeBtn.backgroundColor = kTestColor;
//    [_notiTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_notiTypeBtn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    _notiTypeBtn.frame = CGRectMake(95, 0, kScreenWidth - 120, 40);
//    _notiTypeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    _notiTypeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//    [_backgroungScrollView addSubview:_notiTypeBtn];
   
    _usersSelectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _usersSelectedBtn.backgroundColor = kTestColor;
    _usersSelectedBtn.tag = 333 + 0;
    [_usersSelectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_usersSelectedBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _usersSelectedBtn.frame = CGRectMake(95, 2 * kHeight + 2, kScreenWidth - 120, 40);
    _usersSelectedBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _usersSelectedBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_usersSelectedBtn];
    
//
//    _meetingAddress = [[UITextField alloc]init];
//    
//    _meetingAddress.backgroundColor = kTestColor;
//    _meetingAddress.frame = CGRectMake(95, 3 * kHeight+  3, kScreenWidth - 120, 40);
//    _meetingAddress.font = [UIFont systemFontOfSize:12];
//    _meetingAddress.delegate = self;
//    [_backgroungScrollView addSubview:_meetingAddress];
//    
    
    
    
    
}

//- (UIScrollView *)backgScrollView {
//
//    _backgroungScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    _backgroungScrollView.backgroundColor = [UIColor redColor];
////    _backgroungScrollView.contentSize = CGSizeMake(0, 0);
//
//    return _backgroungScrollView;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    

    return 1;
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {

    
}







- (void)btnClicked:(UIButton *)sender {
    
    switch (sender.tag - 333) {
        case 0:
        {
           
            UserDeptViewController *userDep = [[UserDeptViewController alloc]init];
            userDep.isJump = YES;
            userDep.selectedBlock = ^(NSMutableArray *array){
                
                OPLog(@"block %@",array);
                
                NSString *title = @"";
                if (array.count > 0) {
                    NSMutableArray *arr = [[NSMutableArray alloc]init];
                    for (NSDictionary *dict in array) {

                        [arr addObject:[dict objectForKey:@"name"]];
                         
                        
                    }
                    
                    title = [(NSArray *)arr componentsJoinedByString:@"、"];
                }

               
                
                [_usersSelectedBtn setTitle:title forState:UIControlStateNormal];
                
            };
            
            [self.navigationController pushViewController:userDep animated:YES];
            
            
        }
            
            break;
            
        case 1:
        {

        }
            break;
            
        default:
            break;
    }
    
}

@end


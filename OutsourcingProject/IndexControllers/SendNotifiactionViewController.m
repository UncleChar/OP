//
//  SendNotifiactionViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/21.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "SendNotifiactionViewController.h"

@interface SendNotifiactionViewController ()

@property (nonatomic, strong) UIScrollView *backgroungScrollView;

@property (nonatomic, strong) NSArray  *elementArray;
@property (nonatomic, strong) UIView   *coverView;
@property (nonatomic, strong) UIView   *topView;
@property (nonatomic, strong) UIButton  *notiTypeBtn;

@end

@implementation SendNotifiactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发通知";

    [self.view addSubview:[self backgroungScrollView]];
    [self initElement];
    
    
}


- (void)initElement{

    if (!_elementArray) {//90 173 243
        
        _elementArray = @[@"iconfont-leixing",@"通知类型",@"iconfont-zhidingfanwei",@"发送范围",@"iconfont-banshizhinan",@"会议时间:",@"iconfont-18didian",@"会议地点:",@"iconfont-people",@"与会领导:",@"iconfont-zixun(1)",@"内       容:"];
    }
    
    for (int i = 0; i < 6; i ++) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, i * 40, kScreenWidth, 39)];
        [self.view addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10 , 18, 18)];
        img.image = [UIImage imageNamed:_elementArray[2 * i]];
        [view addSubview:img];
        
        UILabel *titleLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(38, 9, 60, 20)];
        titleLabel1.text = _elementArray[i * 2 + 1];
        titleLabel1.font = [UIFont systemFontOfSize:12];
        [view addSubview:titleLabel1];
    }
    
    
    _notiTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _notiTypeBtn.tag = 888 + 0;
    _notiTypeBtn.backgroundColor = [UIColor redColor];
    [_notiTypeBtn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _notiTypeBtn.frame = CGRectMake(100, 10, kScreenWidth - 120, 20);
//    [_notiTypeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - (kScreenWidth - 120) / 2, 0, 0)];

    _notiTypeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _notiTypeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:_notiTypeBtn];

}

- (UIScrollView *)backgScrollView {
    
    _backgroungScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    _backgroungScrollView.contentSize = CGSizeMake(0, 0);
    
    return _backgroungScrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)allBtnClicked:(UIButton *)sender {

    switch (sender.tag - 888) {
        case 0:
            
            [self showNotiTypeView];
            
            break;
        case 1:
            
            
            break;
        case 2:
            
            
            break;
        case 3:
            
            
            break;
        case 4:
            
            
            break;
        case 5:
            
            
            break;
            
        default:
            break;
    }

}

- (void)showNotiTypeView {


    _coverView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0.7;
    
    // 添加单击手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePopupView:)];
    _coverView.userInteractionEnabled = YES;
    [_coverView addGestureRecognizer:gesture];
    [[UIApplication sharedApplication].keyWindow addSubview:_coverView];
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth / 6, [UIScreen mainScreen].bounds.size.height / 2 - 50, kScreenWidth * 2 / 3, 103)];
    _topView.backgroundColor = [UIColor whiteColor];
    _topView.layer.cornerRadius = 4;
    _topView.layer.masksToBounds = 1;

    
    [[UIApplication sharedApplication].keyWindow addSubview:_topView];
    
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, kScreenWidth * 2 / 3 - 10, 30)];
    infoLabel.font = [UIFont systemFontOfSize:20];
    infoLabel.textAlignment = 1;
    infoLabel.textColor = [ConfigUITools colorWithR:90 G:173 B:243 A:1];
    infoLabel.text = @"选择类型";
    [_topView addSubview:infoLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth * 2 / 3, 1)];
    line.backgroundColor = [ConfigUITools colorWithR:90 G:173 B:243 A:1];

    [_topView addSubview:line];
    
    
    UIButton *meetingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [meetingBtn setTitle:@"会议通知" forState:UIControlStateNormal];
    [meetingBtn addTarget:self action:@selector(typeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    meetingBtn.frame = CGRectMake(0, 41, kScreenWidth * 2 / 3, 30);
    meetingBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [meetingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_topView addSubview:meetingBtn];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 71, kScreenWidth * 2 / 3, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    
    [_topView addSubview:line1];
    
    
    
}

- (void)hidePopupView:(UITapGestureRecognizer*)gesture {
    
    [_coverView removeFromSuperview];
    [_topView removeFromSuperview];
}

- (void)typeBtnClicked:(UIButton *)sender {

//    _notiTypeBtn.titleLabel.text = sender.titleLabel.text;
    [_notiTypeBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
    [_coverView removeFromSuperview];
    [_topView removeFromSuperview];
}

@end

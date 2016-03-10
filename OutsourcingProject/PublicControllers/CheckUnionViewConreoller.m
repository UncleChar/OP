//
//  CheckUnion.m
//  OutsourcingProject
//
//  Created by LingLi on 16/3/1.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "CheckUnionViewConreoller.h"
#import "SubjectDetailViewController.h"
#import "ClassifyModel.h"
#import "WorkModel.h"
#import "MyFavorViewController.h"
#import "MySendingViewController.h"
#import "MyConsultViewController.h"
#import "SearchUnionViewController.h"

#define kHeight 40
#define kFont  15
#define kLabelWidth 75
#define kContentStart 105
#define kContentWidth  [UIScreen mainScreen].bounds.size.width - kContentStart - 10


#define kBtnWdith 60
#define kRow 4
#define kTopToBot  10
#define kBtnMargin (kScreenWidth - kRow * kBtnWdith) / (kRow + 1)

@interface CheckUnionViewConreoller ()
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
@implementation CheckUnionViewConreoller

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"工会查询";
    
    [self configSearchView];
    
    
}





- (void)configSearchView {
    
    
    _backgroungScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49)];
    _backgroungScrollView.backgroundColor = kBackColor;
    _backgroungScrollView.userInteractionEnabled = YES;
    [self.view addSubview:_backgroungScrollView];
    
    
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [_backgroungScrollView endEditing:YES];
}

- (void)searchBtnClicked {

    
//    [SVProgressHUD showSuccessWithStatus:@"我要查询了哦"];
    SearchUnionViewController *serachVC = [[SearchUnionViewController alloc]init];
    serachVC.filter = [NSString stringWithFormat:@"Gonghuimingcheng like \"%%%@%%\" or gonghuidaima like \"%%%@%%\"  or gonghuidizhi like \"%%%@%%\"  or gonghuizhuxi like \"%%%@%%\"",_unionNameTF.text,_unionCodeTF.text,_unionAddressTF.text,_unionPresidentTF.text];
    OPLog(@"  s%@",serachVC.filter);
//    
//    NSString *filter = [NSString stringWithFormat:@"Gonghuimingcheng like \"%%%@%%\"",@"工"];
    [self.navigationController pushViewController:serachVC animated:YES];

}




@end

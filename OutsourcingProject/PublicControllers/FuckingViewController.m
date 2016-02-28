//
//  FuckingViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/28.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "FuckingViewController.h"

@interface FuckingViewController ()<UIWebViewDelegate>
{

    UIWebView * showWebView;
}
@end

@implementation FuckingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleTop;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, kScreenWidth, 29)];
    titleLabel.text =   [NSString stringWithFormat:@"发布者:    %@",self.senderName];
//    titleLabel.textAlignment = 1;
    titleLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    UILabel *titleLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, 30)];
    titleLabel1.text = [NSString stringWithFormat:@"发布时间:    %@",self.sendDate];
//    titleLabel1.textAlignment = 1;
    titleLabel1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel1];
    
    
    
    
    showWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight - 150 )];
    
    
    showWebView.dataDetectorTypes = UIDataDetectorTypeAll;
    
    
    NSString *content = [self.content htmlEntityDecode];
    //    [showWebView sizeToFit];
    showWebView.scalesPageToFit = YES;
//    showWebView
    showWebView.delegate = self;
    content = [content stringByReplacingOccurrencesOfString:@"/ueditor/server/upload/../../../../" withString:@" http://101.231.51.219:888/"];
    [showWebView loadHTMLString:content baseURL:nil];
    //                weakWebView.text = content;
    //                weakWebView.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:showWebView];

    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(showWebView.frame) - 48, kScreenWidth,80 )];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIButton *zanBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth / 3 - 17.5, 12, 35, 35)];
    zanBtn.tag = 100;
    [zanBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-dianzan(1)（合并）"] forState:UIControlStateNormal];
     [zanBtn setBackgroundImage:[UIImage imageNamed:@"点击后点赞"] forState:UIControlStateSelected];
    [zanBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    zanBtn.selected = NO;
    [bottomView addSubview:zanBtn];
    
    
    UIButton *favBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth / 3 * 2 - 17.5, 12, 35, 35)];
    [favBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-shoucang(5)（合并）"] forState:UIControlStateNormal];
    [favBtn setBackgroundImage:[UIImage imageNamed:@"点击后收藏"] forState:UIControlStateSelected];
    [favBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    favBtn.selected = NO;
    favBtn.tag = 101;
    [bottomView addSubview:favBtn];
    


}
- (void)btnClicked:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    switch (sender.tag - 100 ) {
        case 0:
        {
        
            if (sender.selected) {
                
                [SVProgressHUD showSuccessWithStatus:@"点赞成功"];
            }else {
            
            
                 [SVProgressHUD showSuccessWithStatus:@"取消点赞"];
            }
        
        }
            
            break;
        case 1:
        {
            if (sender.selected) {
                
                [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
            }else {
                
                
                [SVProgressHUD showSuccessWithStatus:@"取消收藏"];
            }
        
        
        }
            
            break;
            
        default:
            break;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {


    

}



/*

 #pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  IndexViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/2/18.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "IndexViewController.h"

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
    [self getRequestData];
    
    // Do any additional setup after loading the view.
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

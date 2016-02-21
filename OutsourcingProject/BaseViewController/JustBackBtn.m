//
//  JustBackBtn.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/20.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "JustBackBtn.h"

@interface JustBackBtn ()

@end

@implementation JustBackBtn

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationController.navigationBarHidden = 0;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(backBack)];
    leftItem.image = [UIImage imageNamed:@"backk"];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.tabBarController.tabBar.hidden = 1;
    self.view.backgroundColor = kBackColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backBack {

    [self.navigationController popViewControllerAnimated:YES];
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

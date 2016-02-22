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

- (void)backBack {

    [self.navigationController popViewControllerAnimated:YES];
}


@end

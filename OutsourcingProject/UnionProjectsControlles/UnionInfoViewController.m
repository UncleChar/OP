//
//  UnionInfoViewController.m
//  OutsourcingProject
//
//  Created by LingLi on 16/3/10.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "UnionInfoViewController.h"
#import "BaiduMapViewController.h"

@interface UnionInfoViewController()

@end

@implementation UnionInfoViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"工会详情";

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"地图" style:UIBarButtonItemStylePlain target:self action:@selector(mapBtnClicked)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    UILabel  *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, kScreenWidth, 50)];
    nameLabel.text =self.name;
    nameLabel.textAlignment = 1;
    nameLabel.backgroundColor = [UIColor whiteColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:18];
    nameLabel.textColor = [UIColor blackColor];
    [self.view addSubview:nameLabel];
    
    UILabel  *addrLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 52, kScreenWidth, 40)];
    addrLabel.text = [NSString stringWithFormat:@"工会地址:      %@",self.address];
    addrLabel.backgroundColor = [UIColor whiteColor];
    addrLabel.textColor = [UIColor grayColor];
    [self.view addSubview:addrLabel];
    
    UILabel  *codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 93, kScreenWidth, 40)];
    codeLabel.text = [NSString stringWithFormat:@"工会代码:      %@",self.code];
    codeLabel.backgroundColor = [UIColor whiteColor];
    codeLabel.textColor = [UIColor grayColor];
    [self.view addSubview:codeLabel];
    
    UILabel  *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 134, kScreenWidth, 40)];
    timeLabel.text = [NSString stringWithFormat:@"工会成立时间:  %@",self.createTime];
    timeLabel.backgroundColor = [UIColor whiteColor];
    timeLabel.textColor = [UIColor grayColor];
    [self.view addSubview:timeLabel];
    
    UILabel  *presidentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 175, kScreenWidth, 40)];
    presidentLabel.text = [NSString stringWithFormat:@"工会主席:      %@",self.president];
    presidentLabel.backgroundColor = [UIColor whiteColor];
    presidentLabel.textColor = [UIColor grayColor];
    [self.view addSubview:presidentLabel];
    
    [self locationDestion];
}

- (void)locationDestion{


        CLLocation *location = [[CLLocation alloc]initWithLatitude:[self.latitude doubleValue] longitude:[self.longitude doubleValue]];
    
    // 反地理编码(逆地理编码) : 把坐标信息转化为地址信息
    // 地理编码 : 把地址信息转换为坐标信息
    
    // 地理编码类
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    // 参数1:用户位置
    // 参数2:反地理编码完成之后的block
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
            if (error) {
                NSLog(@"反地理编码失败");
                _locationName = _name;
                return ;
            }else {
                
                
                CLPlacemark *placeMark = [placemarks firstObject];
                NSLog(@"国家:%@ 城市:%@ 区:%@ 具体位置:%@", placeMark.country, placeMark.locality, placeMark.subLocality, placeMark.name);
                _locationName = placeMark.name;
            }
        
        });
       
  
    }];
}


- (void)mapBtnClicked{
    
    BaiduMapViewController  *locationVC = [[BaiduMapViewController alloc]init];
    locationVC.latitude = self.latitude;
    locationVC.longitude = self.longitude;
    locationVC.destination = _locationName;
    [self.navigationController pushViewController:locationVC animated:YES];
    
}
@end

//
//  ScheduleViewController.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/23.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "ScheduleViewController.h"
#import "AddScheduleViewController.h"
#import "FSCalendar.h"

#define kFont 16
@interface ScheduleViewController ()<FSCalendarDataSource,FSCalendarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView      *scheduleTableView;
@property (nonatomic, strong) NSMutableArray   *dataArray;

@property (strong , nonatomic) FSCalendar      *calendar;
@property (strong , nonatomic) UIScrollView    *backScrollView;
@property (strong , nonatomic) UILabel         *activeLabel;
@property (strong,  nonatomic) NSMutableArray  *modelsArray;
@end

@implementation ScheduleViewController
//- (void)viewWillAppear:(BOOL)animated {
//
////    [super viewWillAppear:YES];
//}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"日程安排";

    [self initArray];
    [self configCalender];

    
}

- (void)initArray {


    if (!_modelsArray) {
        
        _modelsArray = [NSMutableArray arrayWithCapacity:0];
    }

}

- (void)configCalender {

    
    _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.5 - 40 )];
    _calendar.dataSource = self;
    _calendar.delegate = self;
//    _calendar.backgroundColor = [UIColor redColor];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    //设置日期转换格式
    df.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = @"2000-01-01";
    //dateFromString字符喘转日期
    NSDate *datea = [df dateFromString:dateStr];
    
    NSLog(@"wo :%@",datea);
    NSLog(@"ni :%@",[NSDate date]);
    [self.view addSubview:_calendar];
    self.calendar = _calendar;
    
    
    NSDateFormatter *dff = [[NSDateFormatter alloc]init];
    //设置日期转换格式
    dff.dateFormat = @"yyyy-MM-dd";
//    NSString *dateStrf = @"2000-01-01";
    //dateFromString字符喘转日期
    NSString *dateaf = [dff stringFromDate:[NSDate date]];
    
    _activeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,  kScreenHeight * 0.5 - 40 , kScreenWidth - 10, 25)];
    _activeLabel.text = dateaf;
//    _activeLabel.textAlignment = 1;
    _activeLabel.textColor = [UIColor purpleColor];
    _activeLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_activeLabel];
    
    
    if (!_scheduleTableView) {
        _scheduleTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_activeLabel.frame)+ 1, kScreenWidth, kScreenHeight - CGRectGetMaxY(_activeLabel.frame) - 115) style:UITableViewStylePlain];
        
        _scheduleTableView.delegate=self;
        _scheduleTableView.dataSource=self;
        _scheduleTableView.backgroundColor = kBackColor;
        [self.view addSubview:_scheduleTableView];
//        _favorTableView.scrollEnabled = NO;
        
    }
    
    
//    _backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.5 + 31 - 40, kScreenWidth, kScreenHeight - 73  - (kScreenHeight * 0.5 + 31) )];
//
//    _backScrollView.backgroundColor = [UIColor purpleColor];
//    [self.view addSubview:_backScrollView];

    
//    [self configScheduleUIWithModelsArray:_modelsArray];
    
    UIButton *creatBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kScreenHeight - 64  - 45, kScreenWidth - 40, 40)];
    creatBtn.tag = 333 +  0;
    creatBtn.layer.cornerRadius = 4;
    creatBtn.layer.masksToBounds = 1;
    creatBtn.backgroundColor = kBtnColor;
    [creatBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [creatBtn addTarget:self action:@selector(scheduleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [creatBtn setTitle:@"新建日程" forState:UIControlStateNormal];
    [self.view addSubview:creatBtn];
    
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _modelsArray.count + 11;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        
        
        cell.imageView.image = [UIImage imageNamed:@"iconfont-biaoti"];
        //        cell.textLabel.text = _cellTitleArray[indexPath.row];
        
        cell.textLabel.text = @"新建日程";
        
//        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        
    }else {
    
        cell.imageView.image = [UIImage imageNamed:@"iconfont-weibiaoti4"];
        //        cell.textLabel.text = _cellTitleArray[indexPath.row];
        
        cell.textLabel.text = @"测试收藏的view";
//        cell.detailTextLabel.text = @"业务指导";
//        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
        
    }
    
    cell.backgroundColor = kBackColor;

    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == _modelsArray.count) {
        
        [self.navigationController pushViewController:[[AddScheduleViewController alloc]init] animated:YES];
        
    }
    
}


- (void)didSelectDate:(NSDate *)date{
    
    
    NSLog(@"selected :%@",date);
    
}
//- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date {
//
//
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"date"]) {
//        if ([date isEqualToDate:[_calendar dateByIgnoringTimeComponentsOfDate:[[NSUserDefaults standardUserDefaults] objectForKey:@"date"]]]) {
//
//            return @"√";
//        }
//
//
//        return @"";
//
//
//    }else {
//
//
//
//        return @"";
//
//    }
//}


- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date {
    
    
    
    
    
    
    //    NSDateComponents *components = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour fromDate:date];
    //    components.hour = FSCalendarDefaultHourComponent;
    //
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    //设置日期转换格式
    df.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = @"2016-02-014";
    //dateFromString字符喘转日期
    NSDate *datea = [df dateFromString:dateStr];
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"date"]) {
        if ([date isEqualToDate:datea]) {
            
            return 1;
        }
        
        
        return 0;
        
        
    }else {
        
        
        
        return 0;
        
    }
    
    
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date {
    
    
    NSLog(@"fff:%@",date);
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"date"];
    
    NSDateFormatter *dff = [[NSDateFormatter alloc]init];
    //设置日期转换格式
    dff.dateFormat = @"yyyy-MM-dd";
    //    NSString *dateStrf = @"2000-01-01";
    //dateFromString字符喘转日期
    NSString *dateaf = [dff stringFromDate:date];

    _activeLabel.text = dateaf;
    _activeLabel.textColor = [UIColor purpleColor];
    
}


- (void)scheduleBtnClicked:(UIButton *)sender {


    switch (sender.tag - 333) {
        case 0:
            
            [self.navigationController pushViewController:[[AddScheduleViewController alloc]init] animated:YES];
            
            break;
        case 1:
            
//            [self.navigationController pushViewController:[[AddScheduleViewController alloc]init] animated:YES];
            
            break;
        case 2:

            
            
            break;
        case 3:

            
            break;
        case 4:
        {
            

            
        }
            
            break;
        case 5:
            
            
            break;
            
        default:
            break;
    }

}




- (void)configScheduleUIWithModelsArray:(NSMutableArray *)array {
    
    if (array.count == 0) {
        
        UIView  *tagView = [[UIView alloc]init];
        tagView.frame = CGRectMake(10, 0, 21, 100);
        
        UIView *verticalLine = [[UIView alloc]init];
        verticalLine.frame = CGRectMake(10.5, 0, 1, 24);
        verticalLine.backgroundColor = [UIColor lightGrayColor];
        [tagView addSubview:verticalLine];
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 24, 21, 21)];
        img.image = [UIImage imageNamed:@"iconfont-biaoti"];
        [tagView addSubview:img];
        [_backScrollView addSubview:tagView];
        UIButton *newBnt = [[UIButton alloc]initWithFrame:CGRectMake(40, 14, kScreenWidth - 60, 40)];
        newBnt.tag = 333 + 1;
        newBnt.layer.cornerRadius = 4;
        newBnt.layer.masksToBounds = 1;
        newBnt.backgroundColor = [UIColor grayColor];
        [newBnt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [newBnt addTarget:self action:@selector(scheduleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        newBnt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        newBnt.titleLabel.font = [UIFont systemFontOfSize:kFont];
        [newBnt setTitle:@"    新建日程" forState:UIControlStateNormal];
        [_backScrollView addSubview:newBnt];
        
    }else {
        
        
        
    }
    
    
    
}

@end
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
#import "ScheModel.h"

#define kFont 16
@interface ScheduleViewController ()<FSCalendarDataSource,FSCalendarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    ReturnValueBlock returnBlockDate;
    ReturnValueBlock returnBlockSingle;

}
@property (nonatomic, strong) UITableView      *scheduleTableView;
@property (nonatomic, strong) NSMutableArray   *dataArray;
@property (nonatomic, strong) NSMutableArray   *dateStringArray;

@property (strong , nonatomic) FSCalendar      *calendar;
@property (strong , nonatomic) UIScrollView    *backScrollView;
@property (strong , nonatomic) UILabel         *activeLabel;
@property (strong,  nonatomic) NSMutableArray  *modelsArray;
@property (strong , nonatomic) NSString        *deleteDateString;
@end

@implementation ScheduleViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"日程安排";

    [self initArray];
    [self configCalender];
    
    NSDateFormatter *charuncle = [[NSDateFormatter alloc]init];
    charuncle.dateFormat = @"yyyy-MM-dd";
    NSString *dateStringFilter = [charuncle stringFromDate:[NSDate date]];

//    NSString *dateStringFilter = [NSString stringWithFormat:@"DateDiff(day,&quot;%@&quot;,fld_30_5)&gt;=0 and DateDiff(day,fld_30_5,&quot;%@&quot;)&gt;=0",[self today:[NSDate date] BeforeOrAfterMonths:-2],[self today:[NSDate date] BeforeOrAfterMonths:2]];
    [self handleRequsetDetaiDate];
    [self getMyEventDataWithType:@"richenganpaidate" pageSize:8 navIndex:0 filter:dateStringFilter];
    
    //    [self NotiDetailWithType:@"newrichenganpai" chid:[self.ChID integerValue]];
   
}

- (void)initArray {


    if (!_modelsArray) {
        
        _modelsArray = [NSMutableArray arrayWithCapacity:0];
    }
    if (!_dateStringArray) {
        
        _dateStringArray = [NSMutableArray arrayWithCapacity:0];
    }

}

- (void)configCalender {

    
    _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.5 - 40 )];
    _calendar.dataSource = self;
    _calendar.delegate = self;
//    NSDateFormatter *df = [[NSDateFormatter alloc]init];
//    //设置日期转换格式
//    df.dateFormat = @"yyyy-MM-dd";
//    NSString *dateStr = @"2000-01-01";
//    //dateFromString字符喘转日期
//    NSDate *datea = [df dateFromString:dateStr];
//    
//    NSLog(@"wo :%@",datea);
//    NSLog(@"ni :%@",[NSDate date]);
    [self.view addSubview:_calendar];
    self.calendar = _calendar;

    
    _activeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,  kScreenHeight * 0.5 - 40 , kScreenWidth - 10, 25)];
    _activeLabel.text = [ConfigUITools returnDateStringWithDate:[NSDate date]];
    _activeLabel.textColor = [UIColor purpleColor];
    _activeLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_activeLabel];

    if (!_scheduleTableView) {
        _scheduleTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_activeLabel.frame)+ 1, kScreenWidth, kScreenHeight - CGRectGetMaxY(_activeLabel.frame) - 115) style:UITableViewStylePlain];
        
        _scheduleTableView.delegate=self;
        _scheduleTableView.dataSource=self;
//        _scheduleTableView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_scheduleTableView];

        
    }
    

    
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

- (void)handleRequsetDetaiDate {
    
    
        __weak typeof (self) weakSelf = self;
    returnBlockDate = ^(id resultValue){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            OPLog(@"-fucucucu-%@",[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]);

            if ([NSNull null] ==[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]) {
                
                
                
            }else {
                
                SBJSON *jsonParser = [[SBJSON alloc] init];
                NSError *parseError = nil;
                NSDictionary * result = [jsonParser objectWithString:[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]
                                                               error:&parseError];
                NSLog(@"jsonParserresult:%@",[result objectForKey:@"rows"]);
                for (NSDictionary *dateDict in [result objectForKey:@"rows"]) {

                    NSDateFormatter *eventDate = [[NSDateFormatter alloc]init];
                    
                    eventDate.dateFormat = @"yyyy-MM-dd";
                    
                    NSDate *dateCompare = [eventDate dateFromString:[dateDict valueForKey:@"datestr"]];
                    
                    [weakSelf.dateStringArray addObject:dateCompare];
                    
                }
                [weakSelf.calendar reloadData];
                
            }
            
        });
        
        
        
    };
    
}




- (void)getMyEventDataWithType:(NSString *)type pageSize:(NSInteger)pageSize navIndex:(NSInteger)index filter:(NSString *)filter{
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        NSString * requestBody = [NSString stringWithFormat:
                                  @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                                  "<soap12:Envelope "
                                  "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                                  "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                                  "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                                  "<soap12:Body>"
                                  "<GetJsonListData xmlns=\"Net.GongHuiTong\">"
                                  "<logincookie>%@</logincookie>"
                                  "<datatype>%@</datatype>"
                                  "<pagesize>%ld</pagesize>"
                                  "<navindex>%ld</navindex>"
                                  "<filter>%@</filter>"
                                  " </GetJsonListData>"
                                  "</soap12:Body>"
                                  "</soap12:Envelope>",[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],type,(long)pageSize,(long)index,filter];

        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"GetJsonListDataResult"] WithReturnValeuBlock:returnBlockDate WithErrorCodeBlock:nil];
        
        
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
   
    }
   
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _modelsArray.count + 1;
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

        
        cell.textLabel.text = @"新建日程";

        
    }else {
    
        cell.imageView.image = [UIImage imageNamed:@"iconfont-weibiaoti4"];

        
        cell.textLabel.text = [_modelsArray[indexPath.row - 1] ChContent];

    
        
    }
    
    cell.backgroundColor = kBackColor;

    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        
        AddScheduleViewController *schVC = [[AddScheduleViewController alloc]init];
        schVC.enum_schedule = ENUM_ScheduleCreate;
        [self.navigationController pushViewController:schVC animated:YES];
        
    }else {
    
        AddScheduleViewController *schVC = [[AddScheduleViewController alloc]init];
        schVC.enum_schedule = ENUM_ScheduleEdit;
        schVC.deleteBlock = ^(BOOL isSeccess ){
        
            if (isSeccess) {
                
                [_modelsArray removeAllObjects];
                [_scheduleTableView reloadData];
                NSString *str = [NSString stringWithFormat:@"DateDiff(day,&quot;%@&quot;,fld_30_5)&gt;=0 and DateDiff(day,fld_30_5,&quot;%@&quot;)&gt;=0",_deleteDateString,_deleteDateString];
                [self getSingleDayEventWithType:@"richenganpai" pageSize:0 navIndex:0 filter:str];
            }

        };
        schVC.schId = [_modelsArray[indexPath.row - 1] ChID];
        [self.navigationController pushViewController:schVC animated:YES];
    
    }
    
}


- (void)didSelectDate:(NSDate *)date{
    
    
    NSLog(@"selected :%@",date);
    
}

- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date {

    if (_dateStringArray.count > 0) {
        
        
        if ([_dateStringArray containsObject:date]) {
            
            return 1;
        }else {
        
            return 0;
        }

    }else {
    
        return 0;
    }
   
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar {

    [_modelsArray removeAllObjects];
    [_scheduleTableView reloadData]; 
    [self getMyEventDataWithType:@"richenganpaidate" pageSize:8 navIndex:0 filter:[ConfigUITools returnDateStringWithDate:calendar.currentPage]];
   
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date {
    
    [_modelsArray removeAllObjects];
    [_scheduleTableView reloadData];
    
    NSString *dateString = [ConfigUITools returnDateStringWithDate:date];
    _deleteDateString = dateString;
    _activeLabel.text = dateString;
    _activeLabel.textColor = [UIColor purpleColor];
    NSString *str = [NSString stringWithFormat:@"DateDiff(day,&quot;%@&quot;,fld_30_5)&gt;=0 and DateDiff(day,fld_30_5,&quot;%@&quot;)&gt;=0",dateString,dateString];
    [self handleSingleDayDate];
    [self getSingleDayEventWithType:@"richenganpai" pageSize:0 navIndex:0 filter:str];
    
    
}

- (void)handleSingleDayDate {
    
    
    __weak typeof (self) weakSelf = self;
    returnBlockSingle = ^(id resultValue){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            OPLog(@"-single-%@",[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]);
            
            if ([NSNull null] ==[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]) {
                
                
                
            }else {
               
                SBJSON *jsonParser = [[SBJSON alloc] init];
                NSError *parseError = nil;
                NSDictionary * result = [jsonParser objectWithString:[[resultValue lastObject] objectForKey:@"GetJsonListDataResult"]
                                                               error:&parseError];
                NSLog(@"jsonParserresult:%@",[result objectForKey:@"rows"]);
                for (NSDictionary *dateDict in [result objectForKey:@"rows"]) {
                    
                    ScheModel *model = [[ScheModel alloc]init];
                    [model setValuesForKeysWithDictionary:dateDict];
                    
                    [weakSelf.modelsArray addObject:model];
                    
                }
                [weakSelf.scheduleTableView reloadData];
                
            }
            
        });
        
        
        
    };
    
}

- (void)getSingleDayEventWithType:(NSString *)type pageSize:(NSInteger)pageSize navIndex:(NSInteger)index filter:(NSString *)filter{
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        NSString * requestBody = [NSString stringWithFormat:
                                  @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                                  "<soap12:Envelope "
                                  "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                                  "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                                  "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                                  "<soap12:Body>"
                                  "<GetJsonListData xmlns=\"Net.GongHuiTong\">"
                                  "<logincookie>%@</logincookie>"
                                  "<datatype>%@</datatype>"
                                  "<pagesize>%ld</pagesize>"
                                  "<navindex>%ld</navindex>"
                                  "<filter>%@</filter>"
                                  " </GetJsonListData>"
                                  "</soap12:Body>"
                                  "</soap12:Envelope>",[[NSUserDefaults standardUserDefaults] objectForKey:@"logincookie"],type,(long)pageSize,(long)index,filter];
        
        [JHSoapRequest operationManagerPOST:REQUEST_HOST requestBody:requestBody parseParameters:@[@"GetJsonListDataResult"] WithReturnValeuBlock:returnBlockSingle WithErrorCodeBlock:nil];
        
        
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
    }
    
}

- (void)scheduleBtnClicked:(UIButton *)sender {


    switch (sender.tag - 333) {
        case 0:
        {
            AddScheduleViewController *schVC = [[AddScheduleViewController alloc]init];
            schVC.enum_schedule = ENUM_ScheduleCreate;
            [self.navigationController pushViewController:schVC animated:YES];
        }
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
- (NSString *)today:(NSDate *)date BeforeOrAfterMonths:(NSInteger)scopeInt{

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitMonth fromDate:date];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setMonth:scopeInt];

    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    
    NSDateFormatter *dff = [[NSDateFormatter alloc]init];
    //设置日期转换格式
    dff.dateFormat = @"yyyy-MM-dd";
    //    NSString *dateStrf = @"2000-01-01";
    //dateFromString字符喘转日期
    NSString *string = [dff stringFromDate:newdate];
    return string;

}




@end

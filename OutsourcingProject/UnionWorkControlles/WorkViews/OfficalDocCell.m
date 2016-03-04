//
//  OfficalDocCell.m
//  OutsourcingProject
//
//  Created by LingLi on 16/3/4.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "OfficalDocCell.h"
#import "OfficalDocModel.h"
@interface OfficalDocCell ()
{
    
    UILabel      *nameLabel;
    UILabel      *urgLabel;
    UILabel      *otherLabel;
    UIImageView  *headImageView;
    
}

@end
@implementation OfficalDocCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //        self.backgroundColor = [ConfigUITools colorRandomly];
        self.backgroundColor = [UIColor whiteColor];
        
        [self creatSelectBtn];
        
    }
    return self;
    
    
}

- (void)creatSelectBtn {
    
    
    headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 9, 42,42)];
    headImageView.image = [UIImage imageNamed:@"iconfont-gongwenbao（合并）-拷贝-5"];
    [self.contentView addSubview:headImageView];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame) + 10, 0, kScreenWidth - CGRectGetMaxX(headImageView.frame) - 10 - 10 , 40)];
    [nameLabel setTextColor:[UIColor whiteColor]];
    nameLabel.textColor = [UIColor blackColor];
    //    emailLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:nameLabel];
    
    urgLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame) + 10, 40, 30, 20)];
    [urgLabel setTextColor:[UIColor whiteColor]];
    urgLabel.font = [UIFont systemFontOfSize:13];
    urgLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:urgLabel];
    
    otherLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(urgLabel.frame) + 10, 40, kScreenWidth - CGRectGetMaxX(urgLabel.frame) - 20, 20)];
    [otherLabel setTextColor:[UIColor grayColor]];
    otherLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:otherLabel];
    
    
}
-(void)setModel:(id)model {
    
    
    
    
    _model  = model;
    nameLabel.text = _model.chtopic;
    if ([_model.secretlevel isEqualToString:@"机密"]) {
        
        urgLabel.textColor = [UIColor orangeColor];
        urgLabel.text = _model.secretlevel;
        
    }else if([_model.secretlevel isEqualToString:@"绝密"]) {
        
        
        urgLabel.textColor = [UIColor redColor];
        urgLabel.text = _model.secretlevel;
        
    }else {
        
        urgLabel.textColor = [ConfigUITools colorWithR:89 G:145 B:50 A:1];
        urgLabel.text = _model.secretlevel;
        
    }
    
    if (_model.isChecking) {
        
        otherLabel.text = [NSString stringWithFormat:@"     %@",_model.publishDate]; 
    }else {
    
        otherLabel.text = [NSString stringWithFormat:@"%@   %@",_model.readStatus,_model.publishDate];
    
    }
    
    otherLabel.textColor = [UIColor grayColor];
    
    
}
@end


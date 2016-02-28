//
//  NotiTableViewCell.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/2/26.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "NotiTableViewCell.h"
#import "IndexNotiModel.h"
@interface NotiTableViewCell ()
{

    UILabel      *nameLabel;
    UILabel      *urgLabel;
    UILabel      *otherLabel;
    UIImageView  *headImageView;
  
}

@end
@implementation NotiTableViewCell

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
    headImageView.image = [UIImage imageNamed:@"iconfont-iconfont73（合并）-拷贝-3"];
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
    nameLabel.text = _model.ChTopic;
    if ([_model.urgLevel isEqualToString:@"急"]) {
        
        urgLabel.textColor = [UIColor redColor];
        urgLabel.text = _model.urgLevel;
   
    }else {
    
    
        urgLabel.textColor = [UIColor grayColor];
        urgLabel.text = _model.urgLevel;
    
    }
    
    otherLabel.text = [NSString stringWithFormat:@"%@   %@",_model.senderName,_model.sendDate];
    otherLabel.textColor = [UIColor grayColor];


}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

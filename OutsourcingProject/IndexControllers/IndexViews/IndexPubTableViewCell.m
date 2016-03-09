//
//  IndexPubTableViewCell.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/3/3.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "IndexPubTableViewCell.h"

#import "TaskModel.h"
#import "NotiModel.h"
#import "ActivityModel.h"
#import "SubGuideModel.h"
//#import ""
@interface IndexPubTableViewCell ()
{
    
    UILabel      *nameLabel;
    UILabel      *urgLabel;
    UILabel      *otherLabel;
//    UIImageView  *headImageView;
    
}
@end
@implementation IndexPubTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //        self.backgroundColor = [ConfigUITools colorRandomly];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = 0;
        [self creatSelectBtn];
        
    }
    return self;
    
    
}

- (void)creatSelectBtn {
    

    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth / 3 * 2   -15, 40)];
    [nameLabel setTextColor:[UIColor whiteColor]];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:nameLabel];
    
    urgLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 3 * 2 + 5 , 0, kScreenWidth / 3 - 15, 40)];
    [urgLabel setTextColor:[UIColor whiteColor]];
    urgLabel.textAlignment = 2;
    urgLabel.font = [UIFont systemFontOfSize:13];
    urgLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:urgLabel];
  
}

- (void)setPubModel:(id)pubModel {


    if ([pubModel isMemberOfClass:[NotiModel class]]) {
        
        nameLabel.text = [pubModel chtopic];
        urgLabel.text = [NSString stringWithFormat:@"[ %@ ]",[pubModel urgLevel]];
        if ([[pubModel urgLevel] isEqualToString:@"急"]) {
            
            urgLabel.textColor = [UIColor orangeColor];
            nameLabel.textColor = [UIColor orangeColor];

        }else if([[pubModel urgLevel] isEqualToString:@"一般"]) {
            
            urgLabel.textColor = [UIColor blackColor];
            nameLabel.textColor = [UIColor blackColor];
            
        }else {
            
            
                urgLabel.textColor = [UIColor redColor];
                nameLabel.textColor = [UIColor redColor];
            
        }
        
    }
    
    if ([pubModel isMemberOfClass:[TaskModel class]]) {
        
        
        nameLabel.text = [pubModel chtopic];
        urgLabel.text = [NSString stringWithFormat:@"[ %@ ]",[pubModel ExpDate]];
        urgLabel.textColor = [UIColor blackColor];
        nameLabel.textColor = [UIColor blackColor];

    }
    
    if ([pubModel isMemberOfClass:[SubGuideModel class]]) {
        
        
        nameLabel.text = [pubModel ChTopic];
        urgLabel.text = [NSString stringWithFormat:@"[ %@ ]",[pubModel sendDate]];
        
        urgLabel.textColor = [UIColor blackColor];
        nameLabel.textColor = [UIColor blackColor];
    }



}

@end

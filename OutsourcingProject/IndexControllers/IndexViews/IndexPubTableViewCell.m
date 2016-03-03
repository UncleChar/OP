//
//  IndexPubTableViewCell.m
//  OutsourcingProject
//
//  Created by UncleChar on 16/3/3.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "IndexPubTableViewCell.h"
#import "IndexNotiModel.h"
#import "TaskModel.h"
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
        
        [self creatSelectBtn];
        
    }
    return self;
    
    
}

- (void)creatSelectBtn {
    

    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, kScreenWidth / 2 -  10 , 40)];
    [nameLabel setTextColor:[UIColor whiteColor]];
    nameLabel.textColor = [UIColor blackColor];
    //    emailLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:nameLabel];
    
    urgLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 2 + 10 , 40, kScreenWidth / 2 - 15, 40)];
    [urgLabel setTextColor:[UIColor whiteColor]];
    urgLabel.font = [UIFont systemFontOfSize:13];
    urgLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:urgLabel];
  
}

- (void)setPubModel:(id)pubModel {

    if ([pubModel isKindOfClass:[IndexNotiModel class]]) {
        
        nameLabel.text = [pubModel chtopic];
        urgLabel.text = [NSString stringWithFormat:@"[ %@ ]",[pubModel urgLevel]];
        if ([[pubModel urgLevel] isEqualToString:@"急"]) {
            
            urgLabel.textColor = [UIColor orangeColor];

        }else if([[pubModel urgLevel] isEqualToString:@"一般"]) {
            
               urgLabel.textColor = [UIColor grayColor];
            
        }else {
            
            
                urgLabel.textColor = [UIColor redColor];
            
        }
        
    }
    
    if ([pubModel isKindOfClass:[TaskModel class]]) {
        
        
        nameLabel.text = [pubModel chtopic];
        urgLabel.text = [NSString stringWithFormat:@"[ %@ ]",[pubModel ExpDate]];
       
          urgLabel.textColor = [UIColor grayColor];
    }


}

@end

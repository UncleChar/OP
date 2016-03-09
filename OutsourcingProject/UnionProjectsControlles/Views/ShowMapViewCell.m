//
//  ShowMapViewCell.m
//  OutsourcingProject
//
//  Created by LingLi on 16/3/9.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import "ShowMapViewCell.h"
#import "ShowMapModel.h"
@interface ShowMapViewCell ()
{
    
    UILabel      *nameLabel1;
    UILabel      *addresLabel;
    
}

@end

@implementation ShowMapViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //        self.backgroundColor = [ConfigUITools colorRandomly];
        self.backgroundColor = [UIColor whiteColor];
        
        [self creatSelectBtn];
        
    }
    return self;
    
    
}

- (void)creatSelectBtn {
    
    UIImageView *nameImg = [[UIImageView alloc]initWithFrame:CGRectMake(5, 9, 21,21)];
    nameImg.image = [UIImage imageNamed:@"iconfont-mingcheng（合并）"];
    [self.contentView addSubview:nameImg];
    
    UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameImg.frame) + 5, 0, 80, 40)];
    nameLable.text = @"工会名字:";
    nameLable.font = [UIFont systemFontOfSize:14];
    nameLable.textColor = [UIColor blackColor];
    [self.contentView addSubview:nameLable];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameImg.frame) + 5, 40, kScreenWidth - CGRectGetMaxX(nameImg.frame)  - 10, 1)];
    lineView.backgroundColor = [ConfigUITools colorWithR:231 G:231 B:231 A:1];
//    [self.contentView addSubview:lineView];
    
    
    UIImageView *addrImg = [[UIImageView alloc]initWithFrame:CGRectMake(7, 52, 19,19)];
    addrImg.image = [UIImage imageNamed:@"iconfont-dizhi"];
    [self.contentView addSubview:addrImg];
    
    UILabel *addrLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(addrImg.frame) + 5, 41, 80, 40)];
    addrLable.text = @"工会地址:";
        addrLable.font = [UIFont systemFontOfSize:14];
    addrLable.textColor = [UIColor blackColor];
    [self.contentView addSubview:addrLable];

    nameLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLable.frame) + 5, 0, kScreenWidth - CGRectGetMaxX(nameLable.frame) - 20 , 39)];
    nameLabel1.textColor = [UIColor blackColor];
        nameLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:nameLabel1];
    
    addresLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLable.frame) + 5, 41, kScreenWidth - CGRectGetMaxX(nameLable.frame) - 20, 40)];
    addresLabel.font = [UIFont systemFontOfSize:14];
    addresLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:addresLabel];
    
    
    
}
-(void)setModel:(id)model {

    _model  = model;
    
    nameLabel1.text = _model.gonghuimingcheng;
    addresLabel.text = _model.gonghuidizhi;
    
}
@end

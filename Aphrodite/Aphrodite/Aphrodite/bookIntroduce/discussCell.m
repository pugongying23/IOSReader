//
//  discussCell.m
//  Aphrodite
//
//  Created by XuanLiang on 10/3/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "discussCell.h"

@implementation discussCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        
        self.img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        self.img.layer.cornerRadius = 20;
        self.img.layer.masksToBounds = true;
        
        
        self.userName = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, kScreenWidth - 140, 20)];
        self.userName.numberOfLines = 0;
        self.userName.font =[UIFont fontWithName:MY_FONT_VALUE size:14];
        
        
        self.content = [[UILabel alloc]initWithFrame:CGRectMake(80, 25, kScreenWidth - 90, 50)];
        self.content.numberOfLines = 0;
        self.content.font =[UIFont fontWithName:MY_FONT_VALUE size:14];
        
        
        self.createAt = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 170, 80, 160, 20)];
        self.createAt.numberOfLines = 0;
        self.createAt.font =[UIFont fontWithName:MY_FONT_VALUE size:14];
        
        
        [self addSubview:self.img];
        [self addSubview:self.userName];
        [self addSubview:self.content];
        [self addSubview:self.createAt];
    }
    
    return  self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

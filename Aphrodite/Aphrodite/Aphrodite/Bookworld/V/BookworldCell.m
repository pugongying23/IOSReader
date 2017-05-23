//
//  BookworldCell.m
//  Aphrodite
//
//  Created by XuanLiang on 26/2/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "BookworldCell.h"

@implementation BookworldCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
         self.bookCoverImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 90, 120)];
        
         self.bookName = [[UILabel alloc]initWithFrame:CGRectMake(120, 10,  kScreenWidth - 120, 30)];
        
         self.bookAuthor = [[UILabel alloc]initWithFrame:CGRectMake(120, 50,  kScreenWidth - 120, 30)];
        
         self.createdAt = [[UILabel alloc]initWithFrame:CGRectMake(120, 90,  kScreenWidth - 120, 30)];
        
         self.bookName.font = [UIFont fontWithName:MY_FONT_VALUE size:14];
         self.bookAuthor.font = [UIFont fontWithName:MY_FONT_VALUE size:14];
         self.createdAt.font = [UIFont fontWithName:MY_FONT_VALUE size:14];
        
        [self addSubview:self.bookCoverImg];
        [self addSubview:self.bookName];
        [self addSubview:self.bookAuthor];
        [self addSubview:self.createdAt];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end

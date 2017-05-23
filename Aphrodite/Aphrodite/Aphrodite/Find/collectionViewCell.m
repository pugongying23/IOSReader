//
//  collectionViewCell.m
//  Aphrodite
//
//  Created by XuanLiang on 26/4/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "collectionViewCell.h"

@implementation collectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
        self.lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (kScreenWidth-6) / 3, 60)];
        self.lab.textAlignment=NSTextAlignmentCenter;
        self.lab.font=[UIFont fontWithName:MY_FONT_VALUE size:16];
        self.lab.textColor=[UIColor blackColor];
        [self addSubview:self.lab];
    }
    return self;
}


@end

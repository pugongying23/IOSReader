//
//  myselfUIView.m
//  Aphrodite
//
//  Created by XuanLiang on 4/3/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "myselfUIView.h"

@implementation myselfUIView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self createUIView];
    }
    
    return self;
}

-(void)createUIView{
    CGFloat w = self.bounds.size.width;
    CGFloat h= self.bounds.size.height;
    
    self.imgview = [[UIImageView alloc]initWithFrame:CGRectMake((w-40)*0.5,10,40,40)];
    self.imgview.layer.cornerRadius = 10;
    
    [self addSubview:self.imgview];
    
    self.btn = [[UIButton alloc]initWithFrame:CGRectMake(0, h-30 ,w,20)];
    self.btn.titleLabel.font = [UIFont fontWithName:MY_FONT_VALUE size:14];
    self.btn.titleLabel.textAlignment =  NSTextAlignmentCenter;
    [self.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.btn];

}


@end

//
//  topHead.m
//  Aphrodite
//
//  Created by XuanLiang on 4/5/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "topHead.h"

@implementation topHead

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor=[UIColor blackColor];
        self.alpha=0.8;
        self.back = [[UIButton alloc]init];
        [self addSubview:self.back];
    }
    return self;
}

-(void)btnClick:(UIButton *)btn{
    switch (btn.tag) {
        case 1:
            [self.delgate backFunc];
            break;
        case 2:
            [self.delgate tipFunc];
            break;
        case 3:
            [self.delgate moreFunc];
            break;
        case 4:
            [self.delgate collectionShow];
            
        default:
            break;
    }
}

- (void)layoutSubviews {
    // 一定要调用super的方法
    [super layoutSubviews];
    // 确定子控件的frame（这里得到的self的frame/bounds才是准确的）
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    
    self.back.frame = CGRectMake(0, 0, height, height);
    self.back.tag =1;
    self.back.titleLabel.font = [UIFont fontWithName:MY_FONT_VALUE size:14];
    [self.back setTitle:@"返回" forState:UIControlStateNormal];
    [self.back addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton * tip =[[UIButton alloc]initWithFrame:CGRectMake(width - height*3 -10, 0, height, height)];
    tip.tag =2;
    tip.titleLabel.font = [UIFont fontWithName:MY_FONT_VALUE size:14];
    [tip setTitle:@"标签" forState:UIControlStateNormal];
    [tip addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tip];
    
    UIButton * more =[[UIButton alloc]initWithFrame:CGRectMake(width - height*2 -10, 0, height*2, height)];
    more.tag =3;
    more.titleLabel.font = [UIFont fontWithName:MY_FONT_VALUE size:14];
    [more setTitle:@"音乐" forState:UIControlStateNormal];
    [more addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:more];
    
    UIButton * collection =[[UIButton alloc]initWithFrame:CGRectMake(height*2, 0, height*2, height)];
    collection.tag =4;
    collection.titleLabel.font = [UIFont fontWithName:MY_FONT_VALUE size:14];
    [collection setTitle:@"收藏列表" forState:UIControlStateNormal];
    [collection addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:collection];

    
}

@end

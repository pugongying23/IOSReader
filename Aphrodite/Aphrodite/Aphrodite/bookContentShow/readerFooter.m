//
//  readerFooter.m
//  Aphrodite
//
//  Created by XuanLiang on 4/5/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "readerFooter.h"

@implementation readerFooter

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor=[UIColor blackColor];
        self.alpha=0.6;
        self.directory = [[UIButton alloc]init];
        self.progress = [[UIButton alloc]init];
        self.settings = [[UIButton alloc]init];

        [self addSubview:self.directory];
        [self addSubview:self.progress];
        [self addSubview:self.settings];
    }
    
    return self;
}

-(void)btnClick:(UIButton *)btn{
    switch (btn.tag) {
        case 1:
            [self.delegate directoryFunc];
            break;
        case 2:
            [self.delegate progressFunc];
            break;
        case 3:
            [self.delegate settingsFunc];
            break;
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
    self.directory.frame = CGRectMake(0, 0, width/3, height);
    self.directory.tag =1;
    self.directory.titleLabel.font = [UIFont fontWithName:MY_FONT_VALUE size:14];
    [self.directory setTitle:@"目录" forState:UIControlStateNormal];
    [self.directory addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.progress.frame = CGRectMake(width/3, 0, width/3, height);
    self.progress.tag =2;
    self.progress.titleLabel.font = [UIFont fontWithName:MY_FONT_VALUE size:14];
    [self.progress setTitle:@"标签记录" forState:UIControlStateNormal];
    [self.progress addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    
    self.settings.frame = CGRectMake(width/3*2, 0, width/3, height);
    self.settings.tag =3;
    self.settings.titleLabel.font = [UIFont fontWithName:MY_FONT_VALUE size:14];
    [self.settings setTitle:@"设置" forState:UIControlStateNormal];
    [self.settings addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    
}

@end

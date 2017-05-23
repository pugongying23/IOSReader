//
//  readerSetting.m
//  Aphrodite
//
//  Created by XuanLiang on 4/5/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "readerSetting.h"

@implementation readerSetting


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor=[UIColor blackColor];
        self.alpha=0.8;
        self.fontsize=16;
        self.fontfmily=[NSArray arrayWithObjects:@"Bauhaus ITC", @"Bauhaus ITC",@"more",nil];
        self.backimgs=[NSArray arrayWithObjects:@"1", @"2",@"3",@"4",@"5",@"6",nil];
        self.brightness=[[UISlider alloc]init];
        self.fontlab=[[UILabel alloc]init];
        [self addSubview:self.fontlab];
        [self addSubview:self.brightness];
    }
    return self;
}


- (void)layoutSubviews {
    // 一定要调用super的方法
    [super layoutSubviews];
    // 确定子控件的frame（这里得到的self的frame/bounds才是准确的）
    CGFloat width = self.bounds.size.width;
    
    self.brightness.frame=CGRectMake(10, 0, width-60, 40);
    self.brightness.maximumValue=100;
    self.brightness.minimumValue=0;
    self.brightness.value=50;
    
    UIButton * defaultbrightness=[[UIButton alloc]initWithFrame:CGRectMake(width-50, 0, 40, 40)];
    [defaultbrightness setTitle:@"系统" forState:UIControlStateNormal];
    [defaultbrightness setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    defaultbrightness.titleLabel.font=[UIFont fontWithName:MY_FONT_VALUE size:12];
    [defaultbrightness addTarget:self action:@selector(defaultbrightnessFunc) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:defaultbrightness];
    
    
    
    
    //字体设置
    UIButton * fontSizeAdd=[[UIButton alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth/3, 40)];
    [fontSizeAdd setTitle:@"A+" forState:UIControlStateNormal];
    [fontSizeAdd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    fontSizeAdd.titleLabel.font=[UIFont fontWithName:MY_FONT_VALUE size:14];
    fontSizeAdd.tag=1;
    fontSizeAdd.titleLabel.textAlignment=NSTextAlignmentCenter;
    [fontSizeAdd addTarget:self action:@selector(fontSizeFunc:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:fontSizeAdd];
    
    
    self.fontlab.frame=CGRectMake(kScreenWidth/3, 40, kScreenWidth/3, 40);
    self.fontlab.text=[NSString stringWithFormat:@"%.0f",self.fontsize];
    self.fontlab.font=[UIFont fontWithName:MY_FONT_VALUE size:14];
    self.fontlab.textAlignment=NSTextAlignmentCenter;
    self.fontlab.textColor=[UIColor whiteColor];
    [self addSubview:self.fontlab];
    
    UIButton * fontSizeDown=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/3*2, 40, kScreenWidth/3, 40)];
    [fontSizeDown setTitle:@"A-" forState:UIControlStateNormal];
    [fontSizeDown setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    fontSizeDown.titleLabel.font=[UIFont fontWithName:MY_FONT_VALUE size:14];
    fontSizeDown.tag=2;
    fontSizeDown.titleLabel.textAlignment=NSTextAlignmentCenter;
    [fontSizeDown addTarget:self action:@selector(fontSizeFunc:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:fontSizeDown];
    
    //字体风格设置
    CGFloat fontfamilyW=width / self.fontfmily.count;
    for (int i=0; i<self.fontfmily.count; i++) {
        UIButton * btn=[[UIButton alloc]initWithFrame:CGRectMake(fontfamilyW*i, 80, fontfamilyW, 40)];
        [btn setTitle:self.fontfmily[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont fontWithName:MY_FONT_VALUE size:14];
        btn.tag=i;
        btn.titleLabel.textAlignment=NSTextAlignmentCenter;
        [btn addTarget:self action:@selector(fontfamilyFunc:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    //背景设置
    for (int i=0; i<self.backimgs.count; i++) {
        UIButton * btn=[[UIButton alloc]initWithFrame:CGRectMake(30*i + 13 *(i+1)+20, 120, 30, 30)];
        [btn setImage:[UIImage imageNamed:self.backimgs[i]] forState:UIControlStateNormal];
        btn.layer.cornerRadius=15;
        btn.layer.masksToBounds=true;
        btn.tag=i;
        [btn addTarget:self action:@selector(backimgFun:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }

    
}

#pragma 亮度选择
-(void)defaultbrightnessFunc{
    self.brightness.value=[UIScreen mainScreen].brightness*100;
    [self.delegate brightness:self.brightness.value];
   
}

#pragma 字体大小
-(void)fontSizeFunc:(UIButton *)btn{
    switch (btn.tag) {
        case 1:{
            if (self.fontsize<36) {
                self.fontsize=self.fontsize+1;
            }else{
                self.fontsize=36;
            }
        }
            break;
        case 2:{
            if (self.fontsize>14) {
                self.fontsize=self.fontsize-1;
            }else{
                self.fontsize=14;
            }
        }
            
            break;
        default:
            break;
    }
    self.fontlab.text=[NSString stringWithFormat:@"%.0f",self.fontsize];
    [self.delegate fontsizebackFunc:self.fontsize];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [user setObject:[NSString stringWithFormat:@"%.0f",self.fontsize] forKey:MY_FONT_SIZE_KEY];
    [user synchronize];
}
#pragma 字体风格设置
-(void)fontfamilyFunc:(UIButton *)btn{
    if (btn.tag!=(self.fontfmily.count-1)) {
        [self.delegate fontfmilybackFunc:self.fontfmily[btn.tag]];
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:self.fontfmily[btn.tag] forKey:MY_FONT_KEY];
        [user synchronize];
    }else{
        NSLog(@"more");
    }
   
}
#pragma 背景设置
-(void)backimgFun:(UIButton *)btn{
    if (btn.tag!=(self.backimgs.count-1)) {
        [self.delegate backimgsBackFunc:self.backimgs[btn.tag]];
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:self.backimgs[btn.tag] forKey:READER_BACKGROUNDCOLOR_KEY];
        [user synchronize];
    }else{
        NSLog(@"more");
    }

   
}
@end

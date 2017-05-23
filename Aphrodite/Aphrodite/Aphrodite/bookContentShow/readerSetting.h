//
//  readerSetting.h
//  Aphrodite
//
//  Created by XuanLiang on 4/5/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol readerSettingdelegate <NSObject>

@optional

-(void)brightness:(CGFloat)value;
-(void)fontsizebackFunc:(CGFloat)value;
-(void)fontfmilybackFunc:(NSString *)str;
-(void)backimgsBackFunc:(NSString * )str;


@end


@interface readerSetting : UIView


@property(nonatomic,strong) id<readerSettingdelegate>  delegate;


//滑块
@property(nonatomic,strong) UISlider *  brightness;

//字体大小
@property(nonatomic,assign) CGFloat   fontsize;
@property(nonatomic,strong) UILabel *  fontlab;
//字体风格
@property(nonatomic,strong) NSArray *  fontfmily;
//背景图片
@property(nonatomic,strong) NSArray *  backimgs;

@end

//
//  config.h
//  Aphrodite
//
//  Created by XuanLiang on 25/2/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#ifndef config_h
#define config_h

//获取屏幕宽度与高度  backgroundColor
#define kScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
//字体颜色
#define MY_FONT_COLOR    [UIColor blackColor]
//定义背景颜色
#define BACKGROUNDCOLOR   [UIColor colorWithRed:100 green:100 blue:100 alpha:0.8]
//便好设置
//userId
#define USER_ID_KEY  @"USER_ID"
#define USER_NAME_KEY  @"USER_NAME"
//字体风格
#define MY_FONT_VALUE  @"Bauhaus ITC"
#define MY_FONT_KEY    @"MY_FONT"
//大小
#define MY_FONT_SIZE_VALUE   @16
#define MY_FONT_SIZE_KEY   @"MY_FONT_SIZE"
//阅读的背景颜色
#define READER_BACKGROUNDCOLOR_VALUE   @"1"
#define READER_BACKGROUNDCOLOR_KEY  @"READER_BACKGROUNDCOLOR"
//旧的账户
#define USER_OLD_ID_KEY  @"USER_OLD_ID"
//数据存储的路径
#define INFO_FOLDER  @"localStorageInfo"
//背景的色调
#define TINT_COLOR  [UIColor orangeColor]

#endif

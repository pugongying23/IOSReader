//
//  readerFooter.h
//  Aphrodite
//
//  Created by XuanLiang on 4/5/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol readerFooterdelegate <NSObject>

@optional

-(void)directoryFunc;
-(void)progressFunc;
-(void)settingsFunc;

@end

@interface readerFooter : UIView

@property(nonatomic,strong) id<readerFooterdelegate>   delegate;


@property(nonatomic,strong) UIButton *  directory;
@property(nonatomic,strong) UIButton *  progress;
@property(nonatomic,strong) UIButton *  settings;

@end

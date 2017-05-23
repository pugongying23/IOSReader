//
//  topHead.h
//  Aphrodite
//
//  Created by XuanLiang on 4/5/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol topHeaddelegate <NSObject>

@optional
-(void)backFunc;
-(void)tipFunc;
-(void)moreFunc;
-(void)collectionShow;

@end

@interface topHead : UIView

@property(nonatomic,strong) UIButton *  back;

@property(nonatomic,strong) id<topHeaddelegate>  delgate;

@end

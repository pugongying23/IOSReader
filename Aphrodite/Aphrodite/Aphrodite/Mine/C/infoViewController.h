//
//  infoViewController.h
//  Aphrodite
//
//  Created by XuanLiang on 2/4/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>
#import "LemonBubble.h"
#import "localStorage.h"

@interface infoViewController : UIViewController


@property(nonatomic,strong) UIImage *  image;

@property(nonatomic,retain) UIButton *  userName;

@property(nonatomic,strong) AVObject *  obj;

@property(nonatomic,strong) NSString *  str;

@property(nonatomic,strong) UIImageView * imgHead;
@end

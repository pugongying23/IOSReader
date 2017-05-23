//
//  bookIntroduceViewController.h
//  Aphrodite
//
//  Created by XuanLiang on 5/3/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>
#import <UIImageView+WebCache.h>
#import "ReaderViewController.h"
#import "discussViewController.h"
#import "LoginViewController.h"
#import "newOrderViewController.h"
#import "LemonBubble.h"
#import "localStorage.h"
 

@interface bookIntroduceViewController :UIViewController

@property(nonatomic,strong) AVObject *  obj;

@property(nonatomic,strong) NSMutableArray *  array;

@end

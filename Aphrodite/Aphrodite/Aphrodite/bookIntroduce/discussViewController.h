//
//  discussViewController.h
//  Aphrodite
//
//  Created by XuanLiang on 10/3/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>
#import <UIImageView+WebCache.h>
#import "LoginViewController.h"
#import <MJRefresh.h>
#import "discussCell.h"
#import "localStorage.h"

@interface discussViewController :UIViewController

@property(nonatomic,strong) NSString *  discussName;

@property(nonatomic,strong) UITableView *  tableView;

@property(nonatomic,strong) NSMutableArray *  mutableArray;

@property(nonatomic,strong) NSString *  str;

@end

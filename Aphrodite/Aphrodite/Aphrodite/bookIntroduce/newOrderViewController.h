//
//  newOrderViewController.h
//  Aphrodite
//
//  Created by XuanLiang on 30/4/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>
#import <MJRefresh/MJRefresh.h>
#import "ReaderViewController.h"

@interface newOrderViewController : UIViewController


@property(nonatomic,strong) NSMutableArray *  MutableArray;

@property(nonatomic,strong) UITableView *  tableview;

@property(nonatomic,strong) NSString *  bookContentClassName;

@end

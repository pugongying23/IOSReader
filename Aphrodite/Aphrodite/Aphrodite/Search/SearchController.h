//
//  SearchController.h
//  Aphrodite
//
//  Created by XuanLiang on 28/2/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>
#import "BookworldCell.h"
#import <UIImageView+WebCache.h>
#import "bookIntroduceViewController.h"
#import <MJRefresh.h>

@interface SearchController : UIViewController

@property(nonatomic,strong) UITextField * searchTextField;

@property(nonatomic,strong) NSMutableArray *  arrayData;

@property(nonatomic,strong) UITableView *  tableView;

@end

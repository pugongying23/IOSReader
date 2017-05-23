//
//  BookworldViewController.h
//  Aphrodite
//
//  Created by XuanLiang on 25/2/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
#import <AVOSCloud/AVOSCloud.h>
#import "BookworldCell.h"
#import <UIImageView+WebCache.h>
#import "bookIntroduceViewController.h"
#import "QRCodeViewController.h"
#import "SearchController.h"
#import "localStorage.h"

@interface BookworldViewController : UIViewController

@property(nonatomic,strong) NSMutableArray *  dateArray;

@property(nonatomic,strong) UITableView *  tableView;
 

@end

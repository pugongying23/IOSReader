//
//  typeSearchController.h
//  Aphrodite
//
//  Created by XuanLiang on 27/4/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>
#import "BookworldCell.h"
#import "bookIntroduceViewController.h"

@interface typeSearchController : UIViewController

@property(nonatomic,strong) NSString *  typeName;

@property(nonatomic,strong) NSMutableArray *  MutableArray;

@property(nonatomic,strong) UITableView *  TableView;

@end

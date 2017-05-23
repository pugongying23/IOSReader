//
//  tipView.h
//  Aphrodite
//
//  Created by XuanLiang on 5/5/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>
#import "tools.h"
#import "notesRead.h"

@protocol tipViewdelegate <NSObject>

@optional

-(void)backviewfunc;
-(void)backviewfuncnotesRead:(notesRead *)read;

@end

@interface tipView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSString *  bookContentClassName;

@property(nonatomic,strong) UITableView *  TableView;

@property(nonatomic,strong) NSMutableArray *  array;

@property(nonatomic,strong) id<tipViewdelegate>   delegate;

@end

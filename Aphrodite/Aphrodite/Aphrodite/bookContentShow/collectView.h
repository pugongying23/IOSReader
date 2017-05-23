//
//  collectView.h
//  Aphrodite
//
//  Created by XuanLiang on 15/5/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>
#import "tools.h"
#import "notesRead.h"

@protocol collectViewdelegate <NSObject>

@optional

-(void)collectViewHiden;
-(void)bcollectViewHidennotesRead:(notesRead *)read;

@end

@interface collectView : UIView<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong) NSMutableArray *  array;

@property(nonatomic,strong) UITableView *  TableView;

@property(nonatomic,strong) NSString *  bookContentClassName;

@property(nonatomic,strong) id<collectViewdelegate>   delegate;

@end

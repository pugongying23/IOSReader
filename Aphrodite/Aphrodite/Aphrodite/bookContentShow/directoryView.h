//
//  directoryView.h
//  Aphrodite
//
//  Created by XuanLiang on 5/5/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>
#import <MJRefresh/MJRefresh.h>

@protocol directoryViewdelegate <NSObject>

@optional
-(void)directoryViewHiden;
-(void)chooseCheap:(NSInteger)cheap;

@end

@interface directoryView : UIView<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong) NSMutableArray *  array;

@property(nonatomic,strong) UITableView *  TableView;

@property(nonatomic,strong) NSString *  bookContentClassName;

@property(nonatomic,strong) id<directoryViewdelegate>   delegate;
@end

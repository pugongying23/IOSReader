//
//  songerView.h
//  Aphrodite
//
//  Created by XuanLiang on 9/5/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGMusic.h"

@protocol songerViewdelegate <NSObject>

@optional

-(void)directoryViewHiden;

-(void)chooseCheap:(XMGMusic *)cheap;

@end


@interface songerView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSMutableArray *  array;

@property(nonatomic,strong) UITableView *  TableView;

@property(nonatomic,strong) NSString *  bookContentClassName;

@property(nonatomic,strong) id<songerViewdelegate>   delegate;

@end

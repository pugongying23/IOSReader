//
//  directoryView.m
//  Aphrodite
//
//  Created by XuanLiang on 5/5/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "directoryView.h"

@implementation directoryView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.TableView = [[UITableView alloc]init];
        self.TableView.delegate=self;
        self.TableView.dataSource=self;
        [self.TableView  registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self addSubview:self.TableView];
        self.array = [[NSMutableArray alloc]init];
    }
    
    return self;
}


-(void)layoutSubviews{
    
    self.TableView.frame = CGRectMake(0, 0, self.frame.size.width*0.8, self.frame.size.height);
    self.TableView.tableFooterView = [[UIView alloc]init];
    self.TableView.mj_header =  [MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(datePre)];
    self.TableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(dateNext)];
    [self.TableView.mj_header  beginRefreshing];
    
    UIButton * btn =[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width*0.8, 0, self.frame.size.width*0.2, self.frame.size.height)];
    btn.backgroundColor=[UIColor clearColor];
    [btn addTarget:self  action:@selector(backview) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}


-(void)datePre{
    
    AVQuery *  query  = [[AVQuery alloc]initWithClassName:self.bookContentClassName];
    query.limit = 10;
    [query orderByAscending:@"bookorder"];
    query.skip = 0;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable result, NSError * _Nullable error) {
        [self.TableView.mj_header  endRefreshing];
        [self.array removeAllObjects];
        [self.array  addObjectsFromArray:result];
        [self.TableView reloadData];
        
    }];
}

-(void)dateNext{
    
    AVQuery *  query  = [[AVQuery alloc]initWithClassName:self.bookContentClassName];
    
    query.limit = 10;
    
    [query orderByAscending:@"bookorder"];
    
    query.skip = self.array.count;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable result, NSError * _Nullable error) {
        
        [self.TableView.mj_footer  endRefreshing];
        
        [self.array  addObjectsFromArray:result];
        
        [self.TableView reloadData];
        
    }];
}



-(void)backview{
    [self.delegate directoryViewHiden];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [self.TableView dequeueReusableCellWithIdentifier:@"cell"];
    //去重叠
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    AVObject * obj = self.array[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",obj[@"title"]];
    cell.textLabel.font = [UIFont fontWithName:MY_FONT_VALUE size:16];
    cell.textLabel.frame = CGRectMake(20, 10, kScreenWidth - 40, 40);
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AVObject * obj = self.array[indexPath.row];
    NSString * str = [NSString stringWithFormat:@"%@",obj[@"bookorder"]];
    [self.delegate chooseCheap:[str integerValue]];
}

@end

//
//  newOrderViewController.m
//  Aphrodite
//
//  Created by XuanLiang on 30/4/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "newOrderViewController.h"

@interface newOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation newOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"目录";
    self.view.backgroundColor =[UIColor whiteColor];
    self.MutableArray = [[NSMutableArray alloc]init];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableview];
    
    
    self.tableview.tableFooterView = [[UIView alloc]init];
    self.tableview.mj_header =  [MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(datePre)];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(dateNext)];
    [self.tableview.mj_header  beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = true;
}


-(void)datePre{
    
    AVQuery *  query  = [[AVQuery alloc]initWithClassName:self.bookContentClassName];
    query.limit = 10;
    [query orderByAscending:@"bookorder"];
    query.skip = 0;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable result, NSError * _Nullable error) {
        [self.tableview.mj_header  endRefreshing];
        [self.MutableArray removeAllObjects];
        [self.MutableArray  addObjectsFromArray:result];
        [self.tableview reloadData];
        
    }];
}

-(void)dateNext{
    
    AVQuery *  query  = [[AVQuery alloc]initWithClassName:self.bookContentClassName];
    
    query.limit = 10;
    
    [query orderByAscending:@"bookorder"];
    
    query.skip = self.MutableArray.count;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable result, NSError * _Nullable error) {
        
        [self.tableview.mj_footer  endRefreshing];
        
        [self.MutableArray  addObjectsFromArray:result];
        
        [self.tableview reloadData];
        
    }];
}
 
//---------------------------代理  ------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.MutableArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [self.tableview dequeueReusableCellWithIdentifier:@"cell"];
    //去重叠
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    AVObject * obj = self.MutableArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",obj[@"title"]];
    cell.textLabel.font = [UIFont fontWithName:MY_FONT_VALUE size:16];
    cell.textLabel.frame = CGRectMake(20, 10, kScreenWidth - 40, 40);
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AVObject * obj = self.MutableArray[indexPath.row];
   
    ReaderViewController * vc = [[ReaderViewController alloc]init];
    vc.bookorder= [[NSString stringWithFormat:@"%@",obj[@"bookorder"]] intValue];
    vc.bookContentClassName= self.bookContentClassName;
    [self presentViewController:vc animated:true completion:^{
        
    }];
    
}
@end

//
//  typeSearchController.m
//  Aphrodite
//
//  Created by XuanLiang on 27/4/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "typeSearchController.h"

@interface typeSearchController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation typeSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UIFont *  font = [UIFont fontWithName:MY_FONT_VALUE size:21];
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSForegroundColorAttributeName: [UIColor blackColor]};
    self.navigationController.navigationBar.titleTextAttributes =dic;
    self.navigationItem.title = self.typeName;
    
    self.MutableArray=[[NSMutableArray alloc]init];
    
    self.TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.TableView.delegate=self;
    self.TableView.dataSource=self;
    [self.TableView registerClass:[BookworldCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.TableView];
    
    self.TableView.mj_header =  [MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(datePre)];
    self.TableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(dateNext)];
    
    [self.TableView.mj_header  beginRefreshing];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = false;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.MutableArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  140;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BookworldCell * cell = [self.TableView  dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    AVObject * obj =  self.MutableArray[indexPath.row];
    cell.bookName.text = [NSString stringWithFormat:@"《%@》",obj[@"bookName"]];
    cell.bookAuthor.text =[NSString stringWithFormat:@"作者:%@",obj[@"bookAuthor"]];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:SS";
    
    NSString * createdAtDate = [dateFormatter stringFromDate:obj[@"createdAt"]];
    
    cell.createdAt.text = createdAtDate;
    
    AVFile * fileImg = obj[@"bookCoverImg"];
    
    NSURL * url = [NSURL URLWithString:fileImg.url];
    
    [cell.bookCoverImg sd_setImageWithURL: url placeholderImage:[UIImage imageNamed:@"Coverimg"]];
    return cell;
    
    
}

//上拉下载，下拉刷新
-(void)datePre{
    
    AVQuery *query = [AVQuery queryWithClassName:@"bookInfo"];
    [query whereKey:@"bookType" containsString:self.typeName];
    query.limit = 10;
    [query orderByDescending:@"createAt"];
    query.skip = 0;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable result, NSError * _Nullable error) {
        [self.TableView.mj_header  endRefreshing];
        [self.MutableArray removeAllObjects];
        [self.MutableArray  addObjectsFromArray:result];
        [self.TableView reloadData];
    }];
}

-(void)dateNext{
    
    AVQuery *  query  = [[AVQuery alloc]initWithClassName:@"bookInfo"];
       [query whereKey:@"bookType" containsString:self.typeName];
    query.limit = 10;
    [query orderByDescending:@"createAt"];
    query.skip = self.MutableArray.count;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable result, NSError * _Nullable error) {
        [self.TableView.mj_footer  endRefreshing];
        [self.MutableArray  addObjectsFromArray:result];
        [self.TableView reloadData];
    }];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard  * storyboard = [UIStoryboard storyboardWithName:@"bookIntrouceStoryboard" bundle:nil];
    bookIntroduceViewController * vc = [storyboard  instantiateInitialViewController];
    vc.obj= self.MutableArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:true];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

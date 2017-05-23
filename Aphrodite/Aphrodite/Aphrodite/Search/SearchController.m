//
//  SearchController.m
//  Aphrodite
//  搜索界面
//  Created by XuanLiang on 28/2/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "SearchController.h"

@interface SearchController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=BACKGROUNDCOLOR;
    self.navigationItem.title=@"搜索";
    self.arrayData = [[NSMutableArray alloc]init];
    
    
    self.searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(8, 50, (kScreenWidth - 16) * 0.8, 30)];
    [self.searchTextField setPlaceholder:@"书名或者作者"];
    self.searchTextField.layer.cornerRadius = 5;
    self.searchTextField.layer.masksToBounds = true;
    self.searchTextField.layer.borderWidth = 1;
    self.searchTextField.layer.borderColor = [UIColor grayColor].CGColor;
    self.searchTextField.backgroundColor=[UIColor colorWithRed:181 green:181 blue:181 alpha:1];
    [self.searchTextField setFont:[UIFont fontWithName:MY_FONT_VALUE size:16]];
    [self.view addSubview:self.searchTextField];
    
    
    UIButton * searchBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth - 16) * 0.8 + 8, 50,(kScreenWidth - 16) *0.2, 30)];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    searchBtn.layer.cornerRadius = 8;
    searchBtn.layer.masksToBounds = true;
    searchBtn.titleLabel.font = [UIFont fontWithName:MY_FONT_VALUE size:14];
    [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [searchBtn addTarget:self action:@selector(searchFunc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 85, kScreenWidth, kScreenHeight-60) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[BookworldCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(datePre)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingTarget:self refreshingAction:@selector(dataNext)];
    [self datePre];
}

-(void)viewWillAppear:(BOOL)animated{
      self.tabBarController.tabBar.hidden = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)searchFunc{
    
    if (self.searchTextField.text.length < 1) {
        
        UIAlertController  * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入书名或者作者" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:true completion:^{}];
    }else{
        [self.arrayData removeAllObjects];
        AVQuery *  bookNameQuery = [AVQuery queryWithClassName:@"bookInfo"];
        [bookNameQuery  whereKey:@"bookName" containsString:self.searchTextField.text];
        
        AVQuery *  bookAuthorQuery = [AVQuery queryWithClassName:@"bookInfo"];
        [bookAuthorQuery  whereKey:@"bookAuthor" containsString:self.searchTextField.text];

        AVQuery * query = [AVQuery  orQueryWithSubqueries:[NSArray arrayWithObjects:bookNameQuery,bookAuthorQuery, nil]];
        query.limit = 10;
        [query orderByDescending:@"createAt"];
        [query  findObjectsInBackgroundWithBlock:^(NSArray * _Nullable result, NSError * _Nullable error) {
            if (error == NULL) {
                [self.arrayData addObjectsFromArray:result];
                [self.tableView reloadData];
                //[self.tableView.mj_header beginRefreshing];
            }
        }];
    }
}


#pragma tableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.arrayData.count;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  140;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BookworldCell * cell = [self.tableView  dequeueReusableCellWithIdentifier:@"cell" ];
    AVObject * obj = self.arrayData[indexPath.row];
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

//点击选择的图书
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard  * storyboard = [UIStoryboard storyboardWithName:@"bookIntrouceStoryboard" bundle:nil];
    bookIntroduceViewController * vc = [storyboard  instantiateInitialViewController];
    vc.obj= self.arrayData[indexPath.row];
    [self.navigationController pushViewController:vc animated:true];
}


#pragma 刷新
-(void)datePre{
    
    AVQuery *  bookNameQuery = [AVQuery queryWithClassName:@"bookInfo"];
    [bookNameQuery  whereKey:@"bookName" containsString:self.searchTextField.text];
    
    AVQuery *  bookAuthorQuery = [AVQuery queryWithClassName:@"bookInfo"];
    [bookAuthorQuery  whereKey:@"bookAuthor" containsString:self.searchTextField.text];
    
    AVQuery * query = [AVQuery  orQueryWithSubqueries:[NSArray arrayWithObjects:bookNameQuery,bookAuthorQuery, nil]];
    query.limit = 10;
    [query orderByDescending:@"createAt"];
    query.skip = 0;
    [query  findObjectsInBackgroundWithBlock:^(NSArray * _Nullable result, NSError * _Nullable error) {
        if (error == NULL) {
            [self.tableView.mj_header  endRefreshing];
            [self.arrayData removeAllObjects];
            [self.arrayData addObjectsFromArray:result];
            [self.tableView reloadData];
        }
    }];
}

-(void)dataNext{
    AVQuery *  bookNameQuery = [AVQuery queryWithClassName:@"bookInfo"];
    [bookNameQuery  whereKey:@"bookName" containsString:self.searchTextField.text];
    
    AVQuery *  bookAuthorQuery = [AVQuery queryWithClassName:@"bookInfo"];
    [bookAuthorQuery  whereKey:@"bookAuthor" containsString:self.searchTextField.text];
    
    AVQuery * query = [AVQuery  orQueryWithSubqueries:[NSArray arrayWithObjects:bookNameQuery,bookAuthorQuery, nil]];
    query.limit = 10;
    [query orderByDescending:@"createAt"];
    query.skip = self.arrayData.count;
    [query  findObjectsInBackgroundWithBlock:^(NSArray * _Nullable result, NSError * _Nullable error) {
        if (error == NULL) {
            [self.tableView.mj_footer  endRefreshing];
            [self.arrayData addObjectsFromArray:result];
            [self.tableView reloadData];
        }
    }];
}

@end

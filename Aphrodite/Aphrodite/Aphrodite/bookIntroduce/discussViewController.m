//
//  discussViewController.m
//  Aphrodite
//
//  Created by XuanLiang on 10/3/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "discussViewController.h"

@interface discussViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation discussViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title=@"书评";
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addDiscuss)];
    
        self.navigationItem.rightBarButtonItem=right;
        self.mutableArray = [[NSMutableArray alloc]init];
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = [[UIView alloc]init];
        [self.tableView registerClass:[discussCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:self.tableView];
        self.tableView.mj_header =  [MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(datePre)];
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(dateNext)];
        [self.tableView.mj_header  beginRefreshing];
        [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma 添加品论
-(void)addDiscuss{

    if ([localStorage IsLogin]) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入内容" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if (self.str.length>0) {
                NSString * userid = [localStorage getUserId];
                NSString * bookname = self.discussName;
                
                AVObject *todoFolder = [[AVObject alloc] initWithClassName:bookname];
                [todoFolder setObject:userid forKey:@"userId"];
                [todoFolder setObject:self.str forKey:@"content"];
                [todoFolder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    if (succeeded) {
                          [self.tableView.mj_header  beginRefreshing];
                          [self.tableView reloadData];
                    }else{
                        
                    }
                }];
                
            }
        }]];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            //事件的监听
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
            
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        LoginViewController * vc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:true];
    }
    
    

}


//事件的监听事件
                          
-(void)alertTextFieldDidChange:(NSNotification *)Notification{
    UIAlertController * alert = (UIAlertController *)self.presentedViewController;
    if (alert) {
        self.str = alert.textFields.firstObject.text;
    }
}


#pragma tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.mutableArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    discussCell * cell = [self.tableView  dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AVObject * obj = self.mutableArray[indexPath.row];

    AVQuery *query = [AVQuery queryWithClassName:@"userInfo"];
    [query whereKey:@"userId" equalTo:obj[@"userId"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (objects.count > 0) {
            
            cell.content.text = [NSString stringWithFormat:@"%@",obj[@"content"]];
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:SS";
            NSString * createdAtDate = [dateFormatter stringFromDate:obj[@"createdAt"]];
            cell.createAt.text = createdAtDate;
            
            AVObject *  objs = objects[0];
            AVFile * fileImg = objs[@"head"];
            NSURL * url = [NSURL URLWithString:fileImg.url];
            [cell.img sd_setImageWithURL: url placeholderImage:[UIImage imageNamed:@"Coverimg"]];
            cell.userName.text = [NSString stringWithFormat:@"%@",objs[@"userName"]];
        }
    
    }];
    
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}



//上拉下载，下拉刷新
-(void)datePre{
    
    AVQuery *  query  = [[AVQuery alloc]initWithClassName:self.discussName];
    
    query.limit = 3;
    
    [query orderByDescending:@"createAt"];
    
    query.skip = 0;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable result, NSError * _Nullable error) {
        
        [self.tableView.mj_header  endRefreshing];
        
        [self.mutableArray removeAllObjects];
        
        [self.mutableArray  addObjectsFromArray:result];
        [self.tableView reloadData];

        if (self.mutableArray.count==0) {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"现在没有评论" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:true completion:^{
                
            }];
        }
    }];
}

-(void)dateNext{
    
    AVQuery *  query  = [[AVQuery alloc]initWithClassName:self.discussName];
    
    query.limit = 3;
    
    [query orderByDescending:@"createAt"];
    
    query.skip = self.mutableArray.count;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable result, NSError * _Nullable error) {
        
        [self.tableView.mj_footer  endRefreshing];
        
        [self.mutableArray  addObjectsFromArray:result];
        
        [self.tableView reloadData];
        
    }];
    
    
}



@end

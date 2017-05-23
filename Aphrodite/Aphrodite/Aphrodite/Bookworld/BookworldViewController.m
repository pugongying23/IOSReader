//
//  BookworldViewController.m
//  Aphrodite
//
//  Created by XuanLiang on 25/2/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "BookworldViewController.h"

@interface BookworldViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation BookworldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor  =  BACKGROUNDCOLOR;
   
    [self navigation];

    self.dateArray = [[NSMutableArray alloc]init];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView  registerClass:[BookworldCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header =  [MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(datePre)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(dateNext)];
    
    [self.tableView.mj_header  beginRefreshing];

}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma navigationItem

-(void)navigation{
    
    self.navigationItem.title=@"书籍";
    
    
    
    //两个按钮的父类view
    UIView *leftButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    //历史浏览按钮
    UIButton *search = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 30, 30)];
    [search setBackgroundImage:[UIImage imageNamed:@"Find"] forState:UIControlStateNormal];
    [leftButtonView addSubview:search];
    [search addTarget:self action:@selector(searchFunc) forControlEvents:UIControlEventTouchUpInside];
    
    //主页搜索按钮
    UIButton *timebtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 50, 50)];
    [leftButtonView addSubview:timebtn];
    [timebtn setTitle:@"时间" forState:UIControlStateNormal];
    timebtn.titleLabel.font=[UIFont fontWithName:MY_FONT_VALUE size:14];
    [timebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [timebtn addTarget:self action:@selector(timeSearch) forControlEvents:UIControlEventTouchUpInside];
    
    //把右侧的两个按钮添加到rightBarButtonItem
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:leftButtonView];
    self.navigationItem.leftBarButtonItem = rightCunstomButtonView;
    
    
    
    
    
    
    
    
    
    
    
    
    
//    
//    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Find"] style:UIBarButtonItemStylePlain target:self action:@selector(searchFunc)];
//    self.view.backgroundColor  =  [UIColor whiteColor];
//    UIFont *  font = [UIFont fontWithName:MY_FONT_VALUE size:21];
//    NSDictionary *dic = @{NSFontAttributeName:font,
//                          NSForegroundColorAttributeName: [UIColor blackColor]};
//    self.navigationController.navigationBar.titleTextAttributes =dic;
//    self.navigationItem.leftBarButtonItem = left;
    
    
    
    UIButton * rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setImage:[UIImage imageNamed:@"codenormal"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(codeFunc) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

-(void)timeSearch{
  

    AVQuery *  query  = [[AVQuery alloc]initWithClassName:@"bookInfo"];
    
    query.limit = 10;
    
    [query orderByDescending:@"updatedAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable result, NSError * _Nullable error) {
        
        [self.dateArray removeAllObjects];
        [self.dateArray  addObjectsFromArray:result];
        [self.tableView reloadData];
        
    }];

    
}
//搜索界面
-(void)searchFunc{
    
    SearchController * search = [[SearchController alloc]init];
    
    [self.navigationController pushViewController:search animated:true];
    
}

//扫一扫
-(void)codeFunc{
    QRCodeViewController  *vc = [[QRCodeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:true];
}



#pragma tableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dateArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BookworldCell * cell = [self.tableView  dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    AVObject * obj =  self.dateArray[indexPath.row];

    cell.bookName.text = [NSString stringWithFormat:@"《%@》",obj[@"bookName"]];

    cell.bookAuthor.text =[NSString stringWithFormat:@"作者:%@",obj[@"bookAuthor"]];
    
    
    
    NSString *  intrudelab =  [NSString stringWithFormat:@"%@",obj[@"bookIntroduce"]];

    
    
//    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
//    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:SS";
//    NSString * createdAtDate = [dateFormatter stringFromDate:obj[@"createdAt"]];
    
    cell.createdAt.text = [intrudelab substringWithRange:NSMakeRange(0, 20)];
    
    AVFile * fileImg = obj[@"bookCoverImg"];
    
    NSURL * url = [NSURL URLWithString:fileImg.url];
    
    [cell.bookCoverImg sd_setImageWithURL: url placeholderImage:[UIImage imageNamed:@"Coverimg"]];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard  * storyboard = [UIStoryboard storyboardWithName:@"bookIntrouceStoryboard" bundle:nil];
    bookIntroduceViewController * vc = [storyboard  instantiateInitialViewController];
    vc.obj=self.dateArray[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:true];
}

//上拉下载，下拉刷新
-(void)datePre{
    
    AVQuery *  query  = [[AVQuery alloc]initWithClassName:@"bookInfo"];
    
    query.limit = 10;
    
    [query orderByDescending:@"createAt"];
    
    query.skip = 0;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable result, NSError * _Nullable error) {
        
        [self.tableView.mj_header  endRefreshing];
        
        [self.dateArray removeAllObjects];
        
        [self.dateArray  addObjectsFromArray:result];
        
        [self.tableView reloadData];
        
    }];
}

-(void)dateNext{
    
    AVQuery *  query  = [[AVQuery alloc]initWithClassName:@"bookInfo"];
    
    query.limit = 10;
    
    [query orderByDescending:@"createAt"];
    
    query.skip = self.dateArray.count;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable result, NSError * _Nullable error) {
        
        [self.tableView.mj_footer  endRefreshing];
        
        [self.dateArray  addObjectsFromArray:result];
        
        [self.tableView reloadData];
        
    }];
}
@end

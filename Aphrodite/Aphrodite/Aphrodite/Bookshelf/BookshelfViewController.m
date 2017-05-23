//
//  BookshelfViewController.m
//  Aphrodite
//
//  Created by XuanLiang on 25/2/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "BookshelfViewController.h"
#import "ReaderViewController.h"

@interface BookshelfViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation BookshelfViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  =  [UIColor whiteColor];
    self.MutableArray = [[NSMutableArray alloc]init];
    self.navigationItem.title = @"书架";
    self.view.backgroundColor  =  [UIColor whiteColor];
    UIFont *  font = [UIFont fontWithName:MY_FONT_VALUE size:21];
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSForegroundColorAttributeName: [UIColor blackColor]};
    self.navigationController.navigationBar.titleTextAttributes =dic;
    self.count=0;
    
    
    UIBarButtonItem * rigthAdd = [[UIBarButtonItem alloc]initWithTitle:@"导入本地" style:UIBarButtonItemStylePlain target:self action:@selector(getLocalBook)];
    self.navigationItem.rightBarButtonItem = rigthAdd;
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    // 设置每个item的大小，
    flowLayout.itemSize = CGSizeMake(120, 160);
    //flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    // 设置列的最小间距
    flowLayout.minimumInteritemSpacing =30;
    // 设置最小行间距
    flowLayout.minimumLineSpacing = 15;
    // 设置布局的内边距
    CGFloat space = (kScreenWidth - 246)/3;
    flowLayout.sectionInset = UIEdgeInsetsMake(20, space, 10, space);
    // 滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.CollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 70) collectionViewLayout:flowLayout];
    self.CollectionView.delegate = self;
    self.CollectionView.dataSource = self;
    self.CollectionView.backgroundColor = [UIColor whiteColor];
    [self.CollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview: self.CollectionView];
    //添加长安事件
    UILongPressGestureRecognizer * longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpressfunc:)];
    [self.CollectionView addGestureRecognizer:longpress];
    
    
}

//导入本地图书
-(void)getLocalBook{
    NSLog(@"导入本地图书");
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = false;
    if ([localStorage IsLogin]) {
        if ([localStorage IsChangeLogin]) {
            NSString * BookShelfStr = [NSString stringWithFormat:@"Bookshelf%@", [localStorage getUserId]];
            AVQuery *query = [AVQuery queryWithClassName:BookShelfStr];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (error==NULL) {
                    if (self.count != objects.count) {
                        self.count = self.MutableArray.count;
                        [self.MutableArray removeAllObjects];
                        [self.MutableArray addObjectsFromArray:objects];
                        [self.CollectionView reloadData];
                    }else if (objects.count==0){
                        LKErrorBubble(@"暂无数据", 0.5);
                    }
                }else{
                    LKErrorBubble(@"网络出错", 0.5);
                }
            }];
        }
    }else{
        
        
        [self getBookfromData];
        
        
    }
}

//长按删除
-(void)longpressfunc:(UILongPressGestureRecognizer *)longppres{
    
    CGPoint point =[longppres locationInView:self.CollectionView];
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"标题" message:@"是否删除本书" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteBookById:point];
    }];
    
    UIAlertAction * cancer = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:ok];
    [alert addAction:cancer];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}


//从书库中随机获取几本书
-(void)getBookfromData{
    AVQuery *  query  = [[AVQuery alloc]initWithClassName:@"bookInfo"];
    query.limit = 10;
    [query orderByDescending:@"createAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [self.MutableArray removeAllObjects];
        [self.MutableArray addObjectsFromArray:objects];
        [self.CollectionView reloadData];
    }];

}


-(void)deleteBookById:(CGPoint)point{
    NSIndexPath *notSureIndexPath = [self.CollectionView  indexPathForItemAtPoint:point];
    NSString * userId = [localStorage getUserId];
    if (notSureIndexPath && notSureIndexPath.row < self.MutableArray.count && userId.length>9) {
        AVObject * obj = self.MutableArray[notSureIndexPath.row];
        [self.MutableArray removeObjectAtIndex:notSureIndexPath.row];
        [self.CollectionView reloadData];
        [localStorage DelFromArchiver:obj[@"bookId"]];
        //删除数据
        NSString * BookShelfStr = [NSString stringWithFormat:@"Bookshelf%@",userId];
        NSString  * query = [NSString stringWithFormat:@"delete from %@ where objectId='%@'",BookShelfStr,obj.objectId];
        [AVQuery doCloudQueryInBackgroundWithCQL:query callback:^(AVCloudQueryResult *result, NSError *error) {
            // 如果 error 为空，说明保存成功
            if (error==NULL) {
                LKErrorBubble(@"已删除", 1);
            }else{
                LKErrorBubble(@"删除出错", 1);
            }
        }];
    }else{
        LoginViewController * vc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:true];

    }
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.MutableArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    AVObject * obj = self.MutableArray[indexPath.row];
    AVFile * fileImg = obj[@"bookCoverImg"];
    NSURL * url = [NSURL URLWithString:fileImg.url];
    UIImageView *  imgview = [[UIImageView alloc]init];
    [imgview sd_setImageWithURL: url placeholderImage:[UIImage imageNamed:@"Coverimg"]];
    imgview.layer.cornerRadius=10;
    imgview.layer.masksToBounds=true;
    imgview.frame = CGRectMake(0, 0, 120, 160);
    [cell addSubview:imgview];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPat{
     AVObject * obj = self.MutableArray[indexPat.row];
    ReaderViewController * v  = [[ReaderViewController alloc]init];
    v.bookContentClassName = obj[@"bookContentClassName"];
    v.bookorder=0;
    [self presentViewController:v animated:true completion:^{
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

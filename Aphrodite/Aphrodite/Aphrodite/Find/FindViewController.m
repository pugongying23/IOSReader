//
//  FindViewController.m
//  Aphrodite
//  发现界面
//  Created by XuanLiang on 25/2/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "FindViewController.h"

@interface FindViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation FindViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor  =  [UIColor colorWithRed:220 green:220 blue:20 alpha:0.7];
    UIFont *  font = [UIFont fontWithName:MY_FONT_VALUE size:21];
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSForegroundColorAttributeName: [UIColor blackColor]};
    self.navigationController.navigationBar.titleTextAttributes =dic;
    self.navigationItem.title = @"分类";
    
    self.MutableArray = [[NSMutableArray alloc]init];

    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat w = (kScreenWidth- 6) / 3;
    CGFloat h=60;
    layout.itemSize = CGSizeMake(w, h);
    layout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
    
    
    
    self.CollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(2, 5,kScreenWidth-4, kScreenHeight-5) collectionViewLayout:layout];
    self.CollectionView.delegate=self;
    self.CollectionView.dataSource=self;
    self.CollectionView.backgroundColor=[UIColor colorWithRed:220 green:20 blue:20 alpha:0.7];
    [self.CollectionView registerClass:[collectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.CollectionView];
    
    [self getData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = false;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.MutableArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
     collectionViewCell * cell =[self.CollectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[collectionViewCell alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    }
    cell.layer.borderColor=[[UIColor grayColor]CGColor];
    cell.layer.borderWidth=0.5;
    AVObject * obj = self.MutableArray[indexPath.row];
    cell.lab.text=[NSString stringWithFormat:@"%@",obj[@"bookTypeName"]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    typeSearchController * vc = [[typeSearchController alloc]init];
    AVObject * obj = self.MutableArray[indexPath.row];
    vc.typeName = [NSString stringWithFormat:@"%@",obj[@"bookTypeName"]];
    [self.navigationController pushViewController:vc animated:true];
    
}

-(void)getData{
    AVQuery *  query  = [[AVQuery alloc]initWithClassName:@"bookType"];
   [query orderByDescending:@"createAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable result, NSError * _Nullable error) {
        [self.MutableArray  addObjectsFromArray:result];
        [self.CollectionView reloadData];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
    
}




@end

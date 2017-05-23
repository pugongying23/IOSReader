//
//  tipView.m
//  Aphrodite
//
//  Created by XuanLiang on 5/5/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "tipView.h"

@implementation tipView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
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
    
    self.TableView.frame = CGRectMake(self.frame.size.width*0.2, 0, self.frame.size.width*0.8, self.frame.size.height);
    self.array =  [tools getDataFromArchiver:self.bookContentClassName];
    
    self.TableView.tableFooterView = [[UIView alloc]init];
    self.TableView.mj_header =  [MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(datePre)];
    self.TableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(dateNext)];
    [self.TableView.mj_header  beginRefreshing];
    
    
    
    UIButton * btn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width*0.2, self.frame.size.height)];
    btn.backgroundColor=[UIColor clearColor];
    [btn addTarget:self  action:@selector(backview) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}




-(void)datePre{
    [self.TableView.mj_header  endRefreshing];
    self.array =  [tools getDataFromArchiver:self.bookContentClassName];
    [self.TableView reloadData];

}

-(void)dateNext{
        [self.TableView.mj_footer  endRefreshing];
        self.array =  [tools getDataFromArchiver:self.bookContentClassName];
        [self.TableView reloadData];
}


-(void)backview{
    [self.delegate backviewfunc];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [self.TableView  dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    notesRead * obj =  self.array[indexPath.row];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString * readeDate = [dateFormatter stringFromDate:obj.readeDate];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ | %@",obj.title,readeDate];
    cell.textLabel.font = [UIFont fontWithName:MY_FONT_VALUE size:12];
    cell.textLabel.frame = CGRectMake(0, 5, kScreenWidth*0.8-40, 40);
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(kScreenWidth*0.8-50, 5, 40, 30);
    btn.backgroundColor=[UIColor redColor];
    [btn setTitle:@"删除" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.tag=indexPath.row;
    [btn addTarget:self action:@selector(del:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:btn];
    
    return cell;
}

-(void)del:(UIButton *)btn{
    [tools DelFromArchiver:self.bookContentClassName index:btn.tag];
    [self dateNext];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    notesRead * read = self.array[indexPath.row];
    
    [self.delegate backviewfuncnotesRead:read];
}





@end

//
//  songerView.m
//  Aphrodite
//
//  Created by XuanLiang on 9/5/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "songerView.h"
#import "XMGMusicTool.h"


@implementation songerView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.TableView = [[UITableView alloc]init];
        self.TableView.delegate=self;
        self.TableView.dataSource=self;
        [self.TableView  registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self addSubview:self.TableView];
        self.array = [[NSMutableArray alloc]init];
        [self.array addObjectsFromArray:[XMGMusicTool musics]];
    }
    
    return self;
}


-(void)layoutSubviews{
    
    self.TableView.frame = CGRectMake(0, 0, self.frame.size.width*0.8, self.frame.size.height);
    self.TableView.tableFooterView = [[UIView alloc]init];
    
    UIButton * btn =[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width*0.8, 0, self.frame.size.width*0.2, self.frame.size.height)];
    btn.backgroundColor=[UIColor clearColor];
    [btn addTarget:self  action:@selector(backview) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
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
    XMGMusic * music = self.array[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",music.name];
    cell.textLabel.font = [UIFont fontWithName:MY_FONT_VALUE size:16];
    cell.textLabel.frame = CGRectMake(20, 10, kScreenWidth - 40, 40);
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate chooseCheap:self.array[indexPath.row]];
     [self.delegate directoryViewHiden];
}

@end

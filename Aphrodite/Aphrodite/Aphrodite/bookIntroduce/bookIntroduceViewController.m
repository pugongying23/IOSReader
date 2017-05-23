//
//  bookIntroduceViewController.m
//  Aphrodite
//  comment
//  Created by XuanLiang on 5/3/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "bookIntroduceViewController.h"

@interface bookIntroduceViewController () 

 
//加入书架
@property (weak, nonatomic) IBOutlet UIView *Bookadd;
//阅读
@property (weak, nonatomic) IBOutlet UIView *readerBtn;
//评论
@property (weak, nonatomic) IBOutlet UIView *commentBtn;
//下载
@property (weak, nonatomic) IBOutlet UIView *downloadBtn;

//加入书架
@property (weak, nonatomic) IBOutlet UILabel *addbookshlfLab;
@property (weak, nonatomic) IBOutlet UILabel *readLab;
@property (weak, nonatomic) IBOutlet UILabel *commandLab;
@property (weak, nonatomic) IBOutlet UILabel *downloadLab;



@property (weak, nonatomic) IBOutlet UIScrollView *scrollView; //滚动视图
@property (weak, nonatomic) IBOutlet UILabel *intrudelab;


@property (weak, nonatomic) IBOutlet UIImageView *imghead;
@property (weak, nonatomic) IBOutlet UILabel *bookname;
@property (weak, nonatomic) IBOutlet UILabel *typeAndAuthor;
@property (weak, nonatomic) IBOutlet UILabel *booknNmCount;
@property (weak, nonatomic) IBOutlet UILabel *likeNum;
@property (weak, nonatomic) IBOutlet UIButton *lastCheapBtn;
 
@end

@implementation bookIntroduceViewController

- (void)viewDidLoad {
    
    self.view.backgroundColor = BACKGROUNDCOLOR;
    
    self.navigationItem.title=@"书籍详情";
    [super viewDidLoad];
    
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight * 2);
    self.scrollView.scrollEnabled = true;
    self.scrollView.showsVerticalScrollIndicator = true;

    self.imghead.layer.cornerRadius=20;
    self.imghead.layer.masksToBounds=true;
    
    self.bookname.font=[UIFont fontWithName:MY_FONT_VALUE size:16];
    self.typeAndAuthor.font=[UIFont fontWithName:MY_FONT_VALUE size:14];
    self.booknNmCount.font=[UIFont fontWithName:MY_FONT_VALUE size:14];
    self.likeNum.font=[UIFont fontWithName:MY_FONT_VALUE size:14];
    
    self.intrudelab.numberOfLines=0;
    self.intrudelab.font=[UIFont fontWithName:MY_FONT_VALUE size:16];

     self.addbookshlfLab.font=[UIFont fontWithName:MY_FONT_VALUE size:14];
     self.readLab.font=[UIFont fontWithName:MY_FONT_VALUE size:14];
     self.commandLab.font=[UIFont fontWithName:MY_FONT_VALUE size:14];
     self.downloadLab.font=[UIFont fontWithName:MY_FONT_VALUE size:14];
    
    
    //加入书架
    UITapGestureRecognizer * BookaddTap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AddShelfAction)];
    [self.Bookadd addGestureRecognizer:BookaddTap];
    
    //阅读
    UITapGestureRecognizer * readerBtnTap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ReaderBtnAction)];
    [self.readerBtn addGestureRecognizer:readerBtnTap];
    
    //评论
    UITapGestureRecognizer * commentBtnTap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CommentBtnAction)];
    [self.commentBtn addGestureRecognizer:commentBtnTap];
    
    
    //下载
    UITapGestureRecognizer * downloadBtnTap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(DownloadBtnAction)];
    [self.downloadBtn addGestureRecognizer:downloadBtnTap];
    
    
    [self upData];
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = true;
    [super viewWillAppear:animated];
    self.array = [localStorage getDataFromArchiver];
    if ([localStorage IsContentString:self.obj[@"objectId"] array:self.array]) {
        self.addbookshlfLab.text = @"加入书架";
    }else{
          self.addbookshlfLab.text = @"已添加";
    }

}

#pragma 按钮的动作
//书评
- (void)CommentBtnAction{
    discussViewController  * vc = [[discussViewController alloc]init];
    vc.discussName = self.obj[@"bookDiscussClassName"];
    [self.navigationController pushViewController:vc animated:true];
}
//阅读
- (void)ReaderBtnAction{
    ReaderViewController * v  = [[ReaderViewController alloc]init];
    v.bookContentClassName = self.obj[@"bookContentClassName"];
    v.bookorder=0;
    [self presentViewController:v animated:true completion:^{
        
    }];
}
//下载
- (void)DownloadBtnAction{
    NSLog(@"000");
}
//加入书架
- (void)AddShelfAction{
     NSLog(@"0111");
    if ([localStorage IsLogin]) {
        if ([localStorage IsContentString:self.obj[@"objectId"] array:self.array]) {
            NSString * BookShelfStr = [NSString stringWithFormat:@"Bookshelf%@",[localStorage getUserId]];
            AVObject *todo = [AVObject objectWithClassName:BookShelfStr];
            [todo setObject:self.obj[@"objectId"] forKey:@"bookId"];
            [todo setObject:self.obj[@"bookName"] forKey:@"bookName"];
            [todo setObject:self.obj[@"bookCoverImg"] forKey:@"bookCoverImg"];
            [todo setObject:self.obj[@"bookContentClassName"] forKey:@"bookContentClassName"];
            [todo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    // 存储成功
                    self.addbookshlfLab.text =@"已添加";
                    [localStorage putDataIntoArchiver:self.obj[@"objectId"]];
                    LKRightBubble(@"成功", 0.5);
                    self.array = [localStorage getDataFromArchiver];
                } else {
                    // 失败的话，请检查网络环境以及 SDK 配置是否正确
                    LKErrorBubble(@"添加失败，请检查网络环境", 1);
                }
            }];
        }else{
            LKErrorBubble(@"已添加", 1);
        }
    }else{
        LoginViewController * vc = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:true];
    }
}



//目录
- (IBAction)lastCheapBtnAction:(UIButton *)sender {
    
    newOrderViewController * vc = [[newOrderViewController alloc]init];
    vc.bookContentClassName = self.obj[@"bookContentClassName"];
    [self.navigationController pushViewController:vc animated:true];
    
    

}

#pragma 更新数据
-(void)upData{
    self.bookname.text = [NSString stringWithFormat:@"%@",self.obj[@"bookName"]];
    AVFile * file = self.obj[@"bookCoverImg"];
    NSURL * url = [NSURL URLWithString:file.url];
    [self.imghead   sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Coverimg"]];
    //作者
    self.typeAndAuthor.text = [NSString stringWithFormat:@"%@",self.obj[@"bookAuthor"]];
    //阅读量
    self.likeNum.text=[NSString stringWithFormat:@"%@",self.obj[@"bookType"]];
    NSNumber * bookIsOver =  self.obj[@"bookIsOver"];
    NSNumber * p = [NSNumber numberWithInt:0];
    NSNumber * bookReaderNum =  self.obj[@"bookReaderNum"];
    //NSOrderedAscending , NSOrderedSame, NSOrderedDescending
    self.booknNmCount.text =[NSString stringWithFormat:@"%@万字  | %@",(([bookReaderNum compare:p] == NSOrderedSame)? @"1" : bookReaderNum),(([bookIsOver compare:p] == NSOrderedSame) ? @"连载中" :@"完结")];
    self.intrudelab.text =  [NSString stringWithFormat:@"%@",self.obj[@"bookIntroduce"]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

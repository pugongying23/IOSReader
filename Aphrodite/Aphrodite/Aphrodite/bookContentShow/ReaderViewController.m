//
//  ReaderViewController.m
//  Aphrodite
//
//  Created by XuanLiang on 4/5/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "ReaderViewController.h"
#import "tipView.h"
#import "directoryView.h"
#import "collectView.h"

@interface ReaderViewController ()<topHeaddelegate,readerFooterdelegate,readerSettingdelegate,tipViewdelegate,directoryViewdelegate,UITextViewDelegate,collectViewdelegate>

@property(nonatomic,assign)Boolean settingIsShow;
@property(nonatomic,strong)topHead * top;
@property(nonatomic,strong)readerFooter * footer;
@property(nonatomic,strong)readerSetting * setting;
@property(nonatomic,strong)UIImageView* backimgsview;
@property(nonatomic,strong)tipView * t;
@property(nonatomic,strong)collectView * c;
@property(nonatomic,strong)directoryView * d;
 

@property(nonatomic,strong)NSString * backimg;
@property(nonatomic,assign)CGFloat fontsize;
@property(nonatomic,strong)NSString * fontfamily;


@property(nonatomic,strong)NSArray * array;
@property(nonatomic,strong)NSString * str;


@property(nonatomic,strong)NSString * booktitle;


@property(nonatomic,strong)NSString * selected;
@end

@implementation ReaderViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.view.layer.masksToBounds=true;
    
    self.backimgsview= [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.backimg]];
    self.backimgsview.frame =  self.view.frame;
    [self.view addSubview:self.backimgsview];
    
    self.fontsize=16;
    self.fontfamily=@"Bauhaus ITC";
    self.backimg=@"1";
    
    self.TextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.TextView.scrollEnabled=false;
    self.TextView.font=[UIFont fontWithName:self.fontfamily size:self.fontsize];
    self.TextView.delegate=self;
    self.TextView.backgroundColor=[UIColor clearColor];
    self.TextView.editable=false;
    
    /*点击部分
     左边  上一页  leftPre
     中间  弹出设置 centerSetting
     右边  下一页  rightNext
     */
    UITapGestureRecognizer * tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(UITapGestureRecognizerfun:)];
    [self.TextView addGestureRecognizer:tap];
    [self.view addSubview:self.TextView];
    self.settingIsShow=true;
   
    
    UIMenuItem *menuItem = [[UIMenuItem alloc]initWithTitle:@"收藏" action:@selector(changeText)];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuItems:[NSArray arrayWithObjects:menuItem,nil]];
    
    
    
    
    //上面的返回导航条
    self.top = [[topHead alloc]initWithFrame:CGRectMake(0, -40, kScreenWidth, 40)];
    self.top.delgate=self;
    [self.view addSubview:self.top];
    
    //下面的设置导航条
    self.footer = [[readerFooter alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 40)];
    self.footer.delegate=self;
    [self.view addSubview:self.footer];
    
    //设置面板
    self.setting = [[readerSetting alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 150)];
    self.setting.delegate=self;
    [self.view addSubview:self.setting];
    
    
    self.t =[[tipView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight)];
    self.t.bookContentClassName=self.bookContentClassName;
    self.t.delegate=self;
    [self.view addSubview:self.t];
    
    
    self.c =[[collectView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight)];
    self.c.bookContentClassName=self.bookContentClassName;
    self.c.delegate=self;
    [self.view addSubview:self.c];
    
    
    self.d =[[directoryView alloc]initWithFrame:CGRectMake(-kScreenWidth, 0, kScreenWidth, kScreenHeight)];
    self.d.bookContentClassName=self.bookContentClassName;
    self.d.delegate=self;
    [self.view addSubview:self.d];
    
    
    self.pagenum = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-40, kScreenHeight-40, 30, 30)];
    [self.view addSubview:self.pagenum];
    self.pagenum.font=[UIFont fontWithName:MY_FONT_VALUE size:10];
    self.pagenum.textColor=[UIColor blackColor];
    self.pagenum.text=@"0/0";

    
    
    
}

#pragma UITextViewDelegate

-(void)UITapGestureRecognizerfun:(UITapGestureRecognizer *)tap{
    
    CGPoint  p =[tap locationInView:self.TextView];
    
    if (p.x < kScreenWidth * 0.4) {
        [self leftPreFunc];
    }else if (p.x < kScreenWidth *0.6){
        [self centerSettingFunc];
    }else if (p.x < kScreenWidth){
        [self rightNextFunc];
    }else{
        
    }
    
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if(action==@selector(changeText) || action ==@selector(copy:))
    {
        if(self.TextView.selectedRange.length>0)
            return  [super canPerformAction:action withSender:sender];
    }
    return NO;
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    UITextRange * range = [textView selectedTextRange];
     self.selected = [textView textInRange:range];
}

-(void)changeText{
    
    notesRead * note = [notesRead new];
    note.title=self.selected;
    note.bookorder=self.bookorder;
    note.pageIndex=self.pageIndex;
    note.readeDate=[NSDate  date];
    NSString * name = [NSString stringWithFormat:@"%@collection",self.bookContentClassName];
    [tools putDataIntoArchiver:name content:note];
}





#pragma 点击部分
-(void)leftPreFunc{
    
    if (self.pageIndex>0) {
        self.pageIndex=self.pageIndex-1;
        NSValue * value = self.array[self.pageIndex];
        NSRange index =  [value rangeValue];
        self.TextView.text=[self.str substringWithRange:index];
    }else{
        if (self.bookorder>0) {
            self.bookorder = self.bookorder-1;
            [self getContentFromDataOld];
        }else{
            self.bookorder = 0;
            [self getContentFromData];
        }
       
    }
    NSString * str = [NSString stringWithFormat:@"%ld/%lu",(long)self.pageIndex,(unsigned long)self.array.count];
     self.pagenum.text=str;

}

-(void)centerSettingFunc{
    
    if (self.settingIsShow) {
        [UIView animateWithDuration:1 animations:^{
            self.top.frame = CGRectMake(0, 0, kScreenWidth, 40);
            self.footer.frame = CGRectMake(0, kScreenHeight-40, kScreenWidth, 40);
            
        }];
    }else{
        
        [UIView animateWithDuration:1 animations:^{
            self.top.frame = CGRectMake(0, -40, kScreenWidth, 40);
            self.footer.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 40);
            self.setting.frame= CGRectMake(0, kScreenHeight, kScreenWidth, 150);
        }];
    }
    
    self.settingIsShow = ! self.settingIsShow;
    
}

-(void)rightNextFunc{
    if (self.pageIndex+1<self.array.count) {
        self.pageIndex=self.pageIndex+1;
        NSValue * value = self.array[self.pageIndex];
        NSRange index =  [value rangeValue];
        self.TextView.text=[self.str substringWithRange:index];
    }else{
        self.bookorder = self.bookorder+1;
        self.pageIndex=0;
        [self getContentFromData];
    }
    NSString * str = [NSString stringWithFormat:@"%ld/%lu",(long)self.pageIndex,(unsigned long)self.array.count];
    self.pagenum.text=str;
}


#pragma 代理的实现

-(void)backFunc{
    
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
}


-(void)directoryFunc{
    self.top.frame = CGRectMake(0, -40, kScreenWidth, 40);
    self.footer.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 40);
    self.setting.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 150);
    self.t.frame =CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
    [UIView animateWithDuration:1 animations:^{
        self.d.frame =CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        
    }];

}

-(void)directoryViewHiden{
    self.top.frame = CGRectMake(0, -40, kScreenWidth, 40);
    self.footer.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 40);
    self.setting.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 150);
    self.t.frame =CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
    [UIView animateWithDuration:1 animations:^{
        self.d.frame =CGRectMake(-kScreenWidth, 0, kScreenWidth, kScreenHeight);
        
    }];
}
-(void)chooseCheap:(NSInteger)cheap{
    self.bookorder=cheap;
    self.pageIndex=0;
    [self getContentFromData];
    [self directoryViewHiden];
}


-(void)progressFunc{
    
    self.top.frame = CGRectMake(0, -40, kScreenWidth, 40);
    self.footer.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 40);
    self.setting.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 150);
    self.d.frame =CGRectMake(-kScreenWidth, 0, kScreenWidth, kScreenHeight);
    self.c.frame =CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
    [UIView animateWithDuration:1 animations:^{
        self.t.frame =CGRectMake(0, 0, kScreenWidth, kScreenHeight);

    }];
}



-(void)backviewfunc{
    [UIView animateWithDuration:1 animations:^{
        self.t.frame =CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
        
    }];
}

-(void)backviewfuncnotesRead:(notesRead *)read{
    self.pageIndex=read.pageIndex;
    self.bookorder=read.bookorder;
    [self getContentFromDatacurent];
    [self backviewfunc];
}


-(void)settingsFunc{
    self.top.frame = CGRectMake(0, -40, kScreenWidth, 40);
    self.footer.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 40);
    self.settingIsShow=false;
    [UIView animateWithDuration:1 animations:^{
        self.setting.frame= CGRectMake(0, kScreenHeight-150, kScreenWidth, 150);
    }];
}

-(void)tipFunc{
    
    notesRead * note = [notesRead new];
    note.title=self.booktitle;
    note.bookorder=self.bookorder;
    note.pageIndex=self.pageIndex;
    note.readeDate=[NSDate  date];
    [tools putDataIntoArchiver:self.bookContentClassName content:note];
    
}

-(void)collectionShow{
    
    self.top.frame = CGRectMake(0, -40, kScreenWidth, 40);
    self.footer.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 40);
    self.setting.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 150);
    self.d.frame =CGRectMake(-kScreenWidth, 0, kScreenWidth, kScreenHeight);
    self.t.frame =CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
    [UIView animateWithDuration:1 animations:^{
        self.c.frame =CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        
    }];

}

-(void)collectViewHiden{
    [UIView animateWithDuration:1 animations:^{
        self.c.frame =CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
        
    }];

}

-(void)bcollectViewHidennotesRead:(notesRead *)read{
    self.pageIndex=read.pageIndex;
    self.bookorder=read.bookorder;
    [self getContentFromDatacurent];
}

//音乐

-(void)moreFunc{
    
    UIStoryboard * st = [UIStoryboard storyboardWithName:@"Music" bundle:nil];
    
    UIViewController * vc= [st instantiateInitialViewController];
    
    [self presentViewController:vc animated:true completion:^{
         
    }];
    
    
}

-(void)brightness:(CGFloat)value{
    [[UIScreen mainScreen]setBrightness:value/100];
}
-(void)fontsizebackFunc:(CGFloat)value{
    self.fontsize=value;
    self.TextView.font=[UIFont fontWithName:self.fontfamily size:self.fontsize];
    [self getContentFromData];

}
-(void)fontfmilybackFunc:(NSString *)str{
    self.fontfamily=str;
    self.TextView.font=[UIFont fontWithName:self.fontfamily size:self.fontsize];
    [self getContentFromData];

}
-(void)backimgsBackFunc:(NSString * )str{
    self.backimg=str;
    self.backimgsview.image = [UIImage imageNamed:str];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 获取数据
-(void)getContentFromData{
    AVQuery * query = [AVQuery queryWithClassName:self.bookContentClassName];
    [query whereKey:@"bookorder" equalTo:@(self.bookorder)];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            AVObject * obj =  objects[0];
            NSString * str = [NSString stringWithFormat:@"%@",obj[@"content"]];
            NSString * title = [NSString stringWithFormat:@"%@",obj[@"title"]];
            self.booktitle=title;
            self.str = [NSString stringWithFormat:@"%@\n\n%@",title,str];
            self.array = [tools NSStringPages:self.str CGSizeMax:CGSizeMake(kScreenWidth, 1000000) fontSize:self.fontsize ViewSize:self.TextView.frame.size fontFamily:self.fontfamily];
            NSValue * value = self.array[self.pageIndex];
            NSRange index =  [value rangeValue];
            self.TextView.text=[self.str substringWithRange:index];
         
            self.pagenum.text=[NSString stringWithFormat:@"%ld/%lu",(long)self.pageIndex,(unsigned long)self.array.count];
        }
    }];
}

-(void)getContentFromDataOld{
    AVQuery * query = [AVQuery queryWithClassName:self.bookContentClassName];
    [query whereKey:@"bookorder" equalTo:@(self.bookorder)];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            AVObject * obj =  objects[0];
            NSString * str = [NSString stringWithFormat:@"%@",obj[@"content"]];
            self.booktitle = [NSString stringWithFormat:@"%@",obj[@"title"]];
            self.str = [NSString stringWithFormat:@"%@\n\n%@",self.booktitle,str];
            self.array = [tools NSStringPages:self.str CGSizeMax:CGSizeMake(kScreenWidth, 1000000) fontSize:self.fontsize ViewSize:self.TextView.frame.size fontFamily:self.fontfamily];
            self.pageIndex=self.array.count;
            NSValue * value = self.array[self.pageIndex-1];
            NSRange index =  [value rangeValue];
            self.TextView.text=[self.str substringWithRange:index];
             self.pagenum.text=[NSString stringWithFormat:@"%ld/%lu",(long)self.pageIndex,(unsigned long)self.array.count];
        }
    }];
}

-(void)getContentFromDatacurent{
    AVQuery * query = [AVQuery queryWithClassName:self.bookContentClassName];
    [query whereKey:@"bookorder" equalTo:@(self.bookorder)];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            AVObject * obj =  objects[0];
            NSString * str = [NSString stringWithFormat:@"%@",obj[@"content"]];
            self.booktitle = [NSString stringWithFormat:@"%@",obj[@"title"]];
            self.str = [NSString stringWithFormat:@"%@\n\n%@",self.booktitle,str];
            self.array = [tools NSStringPages:self.str CGSizeMax:CGSizeMake(kScreenWidth, 1000000) fontSize:self.fontsize ViewSize:self.TextView.frame.size fontFamily:self.fontfamily];
            NSValue * value = self.array[self.pageIndex];
            NSRange index =  [value rangeValue];
            self.TextView.text=[self.str substringWithRange:index];
             self.pagenum.text=[NSString stringWithFormat:@"%ld/%lu",(long)self.pageIndex,(unsigned long)self.array.count];
        }
    }];
}

#pragma 显示数据
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
     NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
     self.fontsize= [[user objectForKey:MY_FONT_SIZE_KEY] intValue];
     self.fontfamily = [user objectForKey:MY_FONT_KEY];
     self.backimg = [user objectForKey:READER_BACKGROUNDCOLOR_KEY];
     self.backimgsview.image = [UIImage imageNamed: self.backimg];
    
     [self getContentFromData];
}

@end

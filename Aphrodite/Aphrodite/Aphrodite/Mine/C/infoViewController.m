//
//  infoViewController.m
//  Aphrodite
//
//  Created by XuanLiang on 2/4/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "infoViewController.h"

@interface infoViewController ()

@end

@implementation infoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    UIView * toolHead = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    toolHead.backgroundColor = [UIColor blackColor];
    toolHead.alpha = 0.6;
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 60, 20)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont fontWithName:MY_FONT_VALUE size:14];
    [toolHead addSubview:btn];
    [self.view addSubview:toolHead];
    
    
    self.imgHead = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 100)*0.5, 60, 100, 100)];
    self.imgHead.layer.cornerRadius = 20;
    self.imgHead.layer.masksToBounds = true;
    self.imgHead.image = self.image;
    self.imgHead.userInteractionEnabled=true;
    [self.view addSubview:self.imgHead];
    
    self.userName = [[UIButton alloc]initWithFrame:CGRectMake(10, 190, kScreenWidth-20, 40)];
    self.userName.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.userName setTitle:@"小华" forState:UIControlStateNormal];
    self.userName.titleLabel.font =[UIFont fontWithName:MY_FONT_VALUE size:16];
    [self.userName setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.userName addTarget:self action:@selector(changeData:) forControlEvents:UIControlEventTouchUpInside];
    self.userName.tag=0;
    [self.view addSubview:self.userName];
    
    [self getData];
    
}

-(void)back{
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
}


-(void)getData{
    
    if (self.obj!=nil && [localStorage IsLogin] ) {
        [self.userName setTitle:self.obj[@"userName"] forState:UIControlStateNormal];
    }
}

#pragma 更改数据
-(void)changeData:(UIButton *)btn{
    switch (btn.tag) {
        case 0:{
            if (self.obj!=nil && [localStorage IsLogin]) {
                [self alertDefault:USER_NAME_KEY title:@"新的昵称" upDataKey:@"userName"];
            }
        }
            break;
        default:
            break;
    }
    
}

-(void)alertDefault:(NSString *)key  title:(NSString *)title upDataKey:(NSString *)userName{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.userName setTitle:self.str forState:UIControlStateNormal];
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [localStorage setValueByKey:key key:self.str];
        [user synchronize];
        [self updata:userName value:self.str];
    }]];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=title;
        //事件的监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
        
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

//事件的监听事件
-(void)alertTextFieldDidChange:(NSNotification *)Notification{
    UIAlertController * alert = (UIAlertController *)self.presentedViewController;
    if (alert) {
        self.str = alert.textFields.firstObject.text;
    }
}

//上传数据
-(void)updata:(NSString *)key  value:(NSString *)value{
    
    if (self.obj!=nil) {
        AVQuery *query = [AVQuery queryWithClassName:@"userInfo"];
        [query getObjectInBackgroundWithId:self.obj.objectId block:^(AVObject *object, NSError *error) {
            [object setObject:value forKey:key];
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (error) {
                    LKErrorBubble(@"更改出错，请重试", 1);
                }
            }];
        }];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    [super viewWillAppear:animated];
    self.str=self.obj[@"userName"];
    self.imgHead.image = self.image;
}



@end

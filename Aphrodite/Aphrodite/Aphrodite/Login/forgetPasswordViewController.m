//
//  forgetPasswordViewController.m
//  Aphrodite
//
//  Created by XuanLiang on 26/2/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "forgetPasswordViewController.h"

@interface forgetPasswordViewController ()

@end

@implementation forgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.navigationItem.title=@"忘记密码";
    [self UIinit];
}


#pragma 页面的设计
-(void)UIinit{

    self.QuickLoginName=[[UITextField alloc]initWithFrame:CGRectMake(10, 80, kScreenWidth-20, 40)];
    self.QuickLoginName.placeholder=@"手机号";
    self.QuickLoginName.font = [UIFont fontWithName:MY_FONT_VALUE size:16];
    self.QuickLoginName.textAlignment=NSTextAlignmentLeft;
    UIView * QuickLoginNamelineView = [[UIView alloc]initWithFrame:CGRectMake(0,self.QuickLoginName.frame.size.height- 1, self.QuickLoginName.frame.size.width, 1)];
    QuickLoginNamelineView.backgroundColor = [UIColor orangeColor];
    [self.QuickLoginName addSubview:QuickLoginNamelineView];
    
    self.QuickLoginPassWorld=[[UITextField alloc]initWithFrame:CGRectMake(10, 140, kScreenWidth-20, 40)];
    self.QuickLoginPassWorld.placeholder=@"验证码";
    self.QuickLoginPassWorld.font = [UIFont fontWithName:MY_FONT_VALUE size:16];
    self.QuickLoginPassWorld.textAlignment=NSTextAlignmentLeft;
    self.QuickLoginPassWorld.secureTextEntry=true;
    UIView * QuickLoginPassWorldlineView = [[UIView alloc]initWithFrame:CGRectMake(0,self.QuickLoginPassWorld.frame.size.height- 1, self.QuickLoginPassWorld.frame.size.width, 1)];
    QuickLoginPassWorldlineView.backgroundColor = [UIColor orangeColor];
    [self.QuickLoginPassWorld addSubview:QuickLoginPassWorldlineView];
    
    //获取验证码
    self.btnSure = [[UIButton alloc]initWithFrame:CGRectMake(self.QuickLoginPassWorld.frame.size.width- 60, 0, 60, self.QuickLoginPassWorld.frame.size.height- 1)];
    [self.btnSure setTitle:@"获取验证码" forState:UIControlStateNormal];
    // self.btnSure.enabled=false;
    self.btnSure.titleLabel.font=[UIFont fontWithName:MY_FONT_VALUE size:12];
    [self.btnSure addTarget:self action:@selector(getEcode) forControlEvents:UIControlEventTouchUpInside];
    [self.btnSure setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.QuickLoginPassWorld addSubview:self.btnSure];
    
    
    UIButton * QuickLoginBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 220, kScreenWidth-20, 40)];
    QuickLoginBtn.layer.cornerRadius=15;
    QuickLoginBtn.layer.masksToBounds=true;
    [QuickLoginBtn setTitle:@"修改" forState:UIControlStateNormal];
    QuickLoginBtn.titleLabel.font=[UIFont fontWithName:MY_FONT_VALUE size:16];
    [QuickLoginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    QuickLoginBtn.backgroundColor=[UIColor greenColor];
    [QuickLoginBtn addTarget:self action:@selector(QuickLoginFunc) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.QuickLoginName];
    [self.view addSubview:self.QuickLoginPassWorld];
    [self.view addSubview:QuickLoginBtn];
    
}

-(void)getEcode{
    [AVUser requestPasswordResetWithPhoneNumber:self.QuickLoginName.text block:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            NSLog(@"%hhd", succeeded);
        } else {
              NSLog(@"%@", error);
        }
    }];
}

-(void)QuickLoginFunc{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

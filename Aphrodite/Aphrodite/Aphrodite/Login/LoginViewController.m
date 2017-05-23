//
//  LoginViewController.m
//  Aphrodite
//
//  Created by XuanLiang on 26/2/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"账号密码登陆";
    self.view.backgroundColor =[UIColor whiteColor];
    //去掉导航栏的默认的文字
    //[[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    //去掉文字和返回按钮
    //UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]init];
    //barBtn.title=@"";
    //self.navigationItem.leftBarButtonItem = barBtn;
    self.IsChoose=false;
    UIFont *  font = [UIFont fontWithName:MY_FONT_VALUE size:21];
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSForegroundColorAttributeName: [UIColor blackColor]};
    self.navigationController.navigationBar.titleTextAttributes =dic;
    
    
    UIButton * rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,40,30)];
    [rightButton setTitle:@"注册" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:MY_FONT_VALUE size:16];
    [rightButton addTarget:self action:@selector(rigisterInfo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.view.layer.masksToBounds=true;
    
    [self UIinit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 页面的设计
-(void)UIinit{
    //账号密码登陆
    self.AccountAndPass = [[UIView alloc]initWithFrame:CGRectMake(0, 140, kScreenWidth, 200)];
    
    self.AccountAndPassName=[[UITextField alloc]initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 40)];
    self.AccountAndPassName.placeholder=@"手机号";
    self.AccountAndPassName.font = [UIFont fontWithName:MY_FONT_VALUE size:16];
    self.AccountAndPassName.textAlignment=NSTextAlignmentLeft;
    UIView * AccountAndPassNamelineView = [[UIView alloc]initWithFrame:CGRectMake(0,self.AccountAndPassName.frame.size.height- 1, self.AccountAndPassName.frame.size.width, 1)];
    AccountAndPassNamelineView.backgroundColor = [UIColor orangeColor];
    [self.AccountAndPassName addSubview:AccountAndPassNamelineView];
    
    
    self.AccountAndPassWorld=[[UITextField alloc]initWithFrame:CGRectMake(10, 80, kScreenWidth-20, 40)];
    self.AccountAndPassWorld.placeholder=@"密码";
    self.AccountAndPassWorld.font = [UIFont fontWithName:MY_FONT_VALUE size:16];
    self.AccountAndPassWorld.textAlignment=NSTextAlignmentLeft;
    self.AccountAndPassWorld.secureTextEntry=true;
    UIView * AccountAndPassWorldlineView = [[UIView alloc]initWithFrame:CGRectMake(0,self.AccountAndPassWorld.frame.size.height- 1, self.AccountAndPassWorld.frame.size.width, 1)];
    AccountAndPassWorldlineView.backgroundColor = [UIColor orangeColor];
    [self.AccountAndPassWorld addSubview:AccountAndPassWorldlineView];
    
    //忘记密码
    UIButton * forgetBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-70, 130, 60,20)];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font=[UIFont fontWithName:MY_FONT_VALUE size:12];
    [forgetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(fotgetPassword) forControlEvents:UIControlEventTouchUpInside];
    [forgetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    
    UIButton * AccountAndPassBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 160, kScreenWidth-20, 40)];
    AccountAndPassBtn.layer.cornerRadius=15;
    AccountAndPassBtn.layer.masksToBounds=true;
    [AccountAndPassBtn setTitle:@"登陆" forState:UIControlStateNormal];
    AccountAndPassBtn.titleLabel.font=[UIFont fontWithName:MY_FONT_VALUE size:16];
    [AccountAndPassBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    AccountAndPassBtn.backgroundColor=[UIColor greenColor];
    [AccountAndPassBtn addTarget:self action:@selector(AccountAndPassLogin) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.AccountAndPass addSubview:self.AccountAndPassName];
    [self.AccountAndPass addSubview:self.AccountAndPassWorld];
    [self.AccountAndPass addSubview:forgetBtn];
    [self.AccountAndPass addSubview:AccountAndPassBtn];
    [self.view addSubview:self.AccountAndPass];
    
    
    //切换按钮
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-80)*0.5, 390,80, 30)];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"快速登陆" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont fontWithName:MY_FONT_VALUE size:12];
    [btn addTarget:self action:@selector(ChooseView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    //快速登陆
    self.QuickLogin = [[UIView alloc]initWithFrame:CGRectMake(-kScreenWidth, 140, kScreenWidth, 200)];
    
    self.QuickLoginName=[[UITextField alloc]initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 40)];
    self.QuickLoginName.placeholder=@"手机号";
    self.QuickLoginName.font = [UIFont fontWithName:MY_FONT_VALUE size:16];
    self.QuickLoginName.textAlignment=NSTextAlignmentLeft;
    UIView * QuickLoginNamelineView = [[UIView alloc]initWithFrame:CGRectMake(0,self.QuickLoginName.frame.size.height- 1, self.QuickLoginName.frame.size.width, 1)];
    QuickLoginNamelineView.backgroundColor = [UIColor orangeColor];
    [self.QuickLoginName addSubview:QuickLoginNamelineView];
    
    self.QuickLoginPassWorld=[[UITextField alloc]initWithFrame:CGRectMake(10, 80, kScreenWidth-20, 40)];
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
    
    
    UIButton * QuickLoginBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 160, kScreenWidth-20, 40)];
    QuickLoginBtn.layer.cornerRadius=15;
    QuickLoginBtn.layer.masksToBounds=true;
    [QuickLoginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    QuickLoginBtn.titleLabel.font=[UIFont fontWithName:MY_FONT_VALUE size:16];
    [QuickLoginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    QuickLoginBtn.backgroundColor=[UIColor greenColor];
    [QuickLoginBtn addTarget:self action:@selector(QuickLoginFunc) forControlEvents:UIControlEventTouchUpInside];
    
    [self.QuickLogin addSubview:self.QuickLoginName];
    [self.QuickLogin addSubview:self.QuickLoginPassWorld];
    [self.QuickLogin addSubview:QuickLoginBtn];
    [self.view addSubview:self.QuickLogin];
}
#pragma 忘记密码
-(void)fotgetPassword{
    forgetPasswordViewController * vc =  [[forgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:true];
}
#pragma 选择方式
-(void)ChooseView:(UIButton *)button{
    
    if (self.IsChoose) {
        self.navigationItem.title=@"账号密码登陆";
        [button setTitle:@"快速登陆" forState:UIControlStateNormal];
        [UIView animateWithDuration:1 animations:^{
            self.QuickLogin.frame = CGRectMake(-kScreenWidth, 140, kScreenWidth, 200);
            self.AccountAndPass.frame = CGRectMake(0, 140, kScreenWidth, 200);
            
        }];
        self.IsChoose = false;
    }else{
        self.navigationItem.title=@"快速登陆";
        [button setTitle:@"账号密码登陆" forState:UIControlStateNormal];
        [UIView animateWithDuration:1 animations:^{
            self.AccountAndPass.frame = CGRectMake(kScreenWidth, 140, kScreenWidth, 200);
            self.QuickLogin.frame = CGRectMake(0, 140, kScreenWidth, 200);
        }];
        self.IsChoose=true;
    }
    
}

#pragma 获取验证码

-(void)getEcode{
    NSString * PhoneNumber = self.QuickLoginName.text;
    [AVOSCloud requestSmsCodeWithPhoneNumber:PhoneNumber callback:^(BOOL succeeded, NSError *error) {
        // 发送失败可以查看 error 里面提供的信息
        if (succeeded) {
            NSLog(@"%hhd", succeeded);
        }else{
            NSLog(@"%@", error);
        }
    }];
    
    
}
#pragma 快速登陆
-(void)QuickLoginFunc{
    NSLog(@"快速登陆");
}
#pragma 账号密码登陆
- (void)AccountAndPassLogin{
    NSString *username = self.AccountAndPassName.text;
    NSString *password =self.AccountAndPassWorld.text;
    if (username.length > 0 && password.length > 0) {
        if ([self valiMobile:username]) {
            [AVUser logInWithMobilePhoneNumberInBackground:username password:password block:^(AVUser * _Nullable user, NSError * _Nullable error) {
                if (error == NULL) {
                    NSUserDefaults  * userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:[userDefaults objectForKey:USER_ID_KEY] forKey:USER_OLD_ID_KEY];
                    [userDefaults setObject:user.objectId forKey:USER_ID_KEY];
                    [userDefaults setObject:user[@"userName"] forKey:USER_NAME_KEY];
                    [userDefaults synchronize];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:true];
                    });
                }else{
                    LKErrorBubble(@"账号或密码错误", 12);
                }
            }];
        }else{
            LKErrorBubble(@"手机号正确输入", 12);
        }
    }else{
        LKErrorBubble(@"正确输入", 12);
        
    }
}

#pragma 手机号码验证
-(BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

#pragma 注册
-(void)rigisterInfo{
    RegisterViewController * vc =[[RegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:true];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = true;
}


@end

//
//  RegisterViewController.m
//  Aphrodite
//
//  Created by XuanLiang on 26/2/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.navigationItem.title=@"注册";
    [self UIinit];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.tabBarController.tabBar.hidden = true;
}

#pragma 页面的设计
-(void)UIinit{
    
    self.username=[[UITextField alloc]initWithFrame:CGRectMake(10, 80, kScreenWidth-20, 40)];
    self.username.placeholder=@"昵称";
    self.username.font = [UIFont fontWithName:MY_FONT_VALUE size:16];
    self.username.textAlignment=NSTextAlignmentLeft;
    UIView * usernamelineView = [[UIView alloc]initWithFrame:CGRectMake(0,self.username.frame.size.height- 1, self.username.frame.size.width, 1)];
    usernamelineView.backgroundColor = [UIColor orangeColor];
    [self.username addSubview:usernamelineView];
    [self.view addSubview:self.username];
    
    
    self.mobilePhoneNumber=[[UITextField alloc]initWithFrame:CGRectMake(10, 140, kScreenWidth-20, 40)];
    self.mobilePhoneNumber.placeholder=@"手机号";
    self.mobilePhoneNumber.font = [UIFont fontWithName:MY_FONT_VALUE size:16];
    self.mobilePhoneNumber.textAlignment=NSTextAlignmentLeft;
    UIView * mobilePhoneNumberlineView = [[UIView alloc]initWithFrame:CGRectMake(0,self.mobilePhoneNumber.frame.size.height- 1, self.mobilePhoneNumber.frame.size.width, 1)];
    mobilePhoneNumberlineView.backgroundColor = [UIColor orangeColor];
    [self.mobilePhoneNumber addSubview:mobilePhoneNumberlineView];
    [self.view addSubview:self.mobilePhoneNumber];

    
    
    self.password=[[UITextField alloc]initWithFrame:CGRectMake(10, 200, kScreenWidth-20, 40)];
    self.password.placeholder=@"密码";
    self.password.font = [UIFont fontWithName:MY_FONT_VALUE size:16];
    self.password.textAlignment=NSTextAlignmentLeft;
    self.password.secureTextEntry=true;
    UIView * passwordlineView = [[UIView alloc]initWithFrame:CGRectMake(0,self.password.frame.size.height- 1, self.password.frame.size.width, 1)];
    passwordlineView.backgroundColor = [UIColor orangeColor];
    [self.password addSubview:passwordlineView];
    [self.view addSubview:self.password];

    
    self.repassword=[[UITextField alloc]initWithFrame:CGRectMake(10, 260, kScreenWidth-20, 40)];
    self.repassword.placeholder=@"确认密码";
    self.repassword.font = [UIFont fontWithName:MY_FONT_VALUE size:16];
    self.repassword.textAlignment=NSTextAlignmentLeft;
    self.repassword.secureTextEntry=true;
    UIView * repasswordlineView = [[UIView alloc]initWithFrame:CGRectMake(0,self.repassword.frame.size.height- 1, self.repassword.frame.size.width, 1)];
    repasswordlineView.backgroundColor = [UIColor orangeColor];
    [self.repassword addSubview:repasswordlineView];
    [self.view addSubview:self.repassword];

    
    self.email=[[UITextField alloc]initWithFrame:CGRectMake(10, 320, kScreenWidth-20, 40)];
    self.email.placeholder=@"email";
    self.email.font = [UIFont fontWithName:MY_FONT_VALUE size:16];
    self.email.textAlignment=NSTextAlignmentLeft;
    UIView * emaillineView = [[UIView alloc]initWithFrame:CGRectMake(0,self.email.frame.size.height- 1, self.email.frame.size.width, 1)];
    emaillineView.backgroundColor = [UIColor orangeColor];
    [self.email addSubview:emaillineView];
    [self.view addSubview:self.email];

    
    UIButton * registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 400, kScreenWidth -20,40)];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.font=[UIFont fontWithName:MY_FONT_VALUE size:18];
    registerBtn.layer.cornerRadius=20;
    registerBtn.layer.masksToBounds=true;
    registerBtn.backgroundColor=[UIColor greenColor];
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerButton) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:registerBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)registerButton{
    
    NSString *usernamestr = self.username.text;
    NSString * mobilePhoneNumberstr = self.mobilePhoneNumber.text;
    NSString *passwordstr = self.password.text;
    NSString *repasswordstr =self.repassword.text;
    NSString *emailstr = self.email.text;
   
    if (usernamestr.length >0  && passwordstr.length > 0 && emailstr.length > 0 && mobilePhoneNumberstr.length >0 && repasswordstr.length > 0) {
        
        if ([passwordstr isEqualToString:repasswordstr]) {
            
            if ([self valiMobile:mobilePhoneNumberstr]) {
                
                if ([self validateEmail:emailstr]) {
                    
                            AVUser *user = [AVUser user];
                            user.username = usernamestr;
                            user.password = passwordstr;
                            user.email = emailstr;
                            user.mobilePhoneNumber=mobilePhoneNumberstr;
                            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                if (succeeded) {
                                    [self createUserInfo:user.objectId];
                                } else {
                                    switch (error.code) {
                                        case 214:
                                             LKErrorBubble(@"手机号已被使用", 12);
                                            break;
                                        case 203:
                                            LKErrorBubble(@"邮箱已被使用", 12);
                                            break;
                                        default:
                                            break;
                                    }
                                }
                            }];
                }else{
                       //邮箱号格式不正确
                    self.email.layer.borderColor = [[UIColor redColor]CGColor];
                     self.email.layer.borderWidth = 1;
                }
                
            }else{
                // LKErrorBubble(@"手机号格式不正确", 1);
                self.mobilePhoneNumber.layer.borderColor = [[UIColor redColor]CGColor];
                self.mobilePhoneNumber.layer.borderWidth = 1;

            }
            
        }else{
             //LKErrorBubble(@"两次密码不一致", 1);
            self.password.layer.borderColor = [[UIColor redColor]CGColor];
            self.password.layer.borderWidth = 1;

        }
    }else{
         LKErrorBubble(@"请填写完整", 12);
    }
}

-(BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

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


-(void)createUserInfo:(NSString *)objectId{
    
    AVObject * userInfo = [AVObject objectWithClassName:@"userInfo"];
    NSString * BookShelfStr = [NSString stringWithFormat:@"Bookshelf%@",objectId];
    [userInfo setObject:objectId forKey:@"userId"];
    [userInfo setObject:self.username.text forKey:@"userName"];
    [userInfo setObject:BookShelfStr forKey:@"bookShelf"];
    [userInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            AVObject * bookShelfClass = [AVObject objectWithClassName:BookShelfStr];
            [bookShelfClass setObject:@"水浒传" forKey:@"bookName"];
            [bookShelfClass setObject:@"58b2b3fdb123db0052ccd762" forKey:@"bookId"];
            [bookShelfClass saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:true];
                    });
                }else{
                     LKErrorBubble(@"注册失败，请重试", 12);
                }
            }];
        } else {
             LKErrorBubble(@"注册失败，请重试", 12);
        }
    }];
}




@end

//
//  LoginViewController.h
//  Aphrodite
//
//  Created by XuanLiang on 26/2/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud.h>
#import "RegisterViewController.h"
#import "forgetPasswordViewController.h"
#import "LemonBubble.h"
  


@interface LoginViewController : UIViewController

//账号密码登陆
@property(nonatomic,strong) UIView * AccountAndPass;
@property(nonatomic,strong) UITextField  *  AccountAndPassName;
@property(nonatomic,strong) UITextField  *  AccountAndPassWorld;

//快速登陆
@property(nonatomic,strong) UIView * QuickLogin;
@property(nonatomic,strong) UITextField  *  QuickLoginName;
@property(nonatomic,strong) UITextField  *  QuickLoginPassWorld;
@property(nonatomic,strong) UIButton * btnSure;

//切换记录
@property(nonatomic,assign) Boolean  IsChoose;
@end

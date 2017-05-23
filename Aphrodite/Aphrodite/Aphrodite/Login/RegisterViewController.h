//
//  RegisterViewController.h
//  Aphrodite
//
//  Created by XuanLiang on 26/2/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud.h>
#import "LemonBubble.h"

@interface RegisterViewController : UIViewController


@property(nonatomic,strong) UITextField *  username;
@property(nonatomic,strong) UITextField *  password;
@property(nonatomic,strong) UITextField *  repassword;
@property(nonatomic,strong) UITextField *  email;
@property(nonatomic,strong) UITextField *  mobilePhoneNumber;

@end

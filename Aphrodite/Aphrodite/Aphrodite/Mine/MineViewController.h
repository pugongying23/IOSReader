//
//  MineViewController.h
//  Aphrodite
//
//  Created by XuanLiang on 25/2/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>
#import <UIImageView+WebCache.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "LoginViewController.h"
#import "LoginViewController.h"
#import "myselfUIView.h"
#import "LemonBubble.h"
#import "infoViewController.h"
#import "localStorage.h"

@interface MineViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UITableView *  tableview;

@property(nonatomic,strong)NSArray *  arrText;
//头像
@property(nonatomic,strong)UIImageView * img;
//昵称
@property(nonatomic,strong)UILabel * loginLab;

@property(nonatomic,strong)UIImagePickerController *  imgPicker;

@property(nonatomic,strong)infoViewController *  vc;

@property(nonatomic,strong)AVObject * obj;

@property(nonatomic,strong)UIButton * LoginOrLonout;
@end

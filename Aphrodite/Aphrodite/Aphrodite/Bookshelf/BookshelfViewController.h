//
//  BookshelfViewController.h
//  Aphrodite
//
//  Created by XuanLiang on 25/2/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>
#import <UIImageView+WebCache.h>
#import "localStorage.h"
#import "LemonBubble.h"
#import "LoginViewController.h"

@interface BookshelfViewController : UIViewController

@property(nonatomic,strong) NSMutableArray *  MutableArray;

@property(nonatomic,strong) UICollectionView *  CollectionView;

@property(nonatomic,assign) NSInteger  count;

@end

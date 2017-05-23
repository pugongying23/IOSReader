//
//  FindViewController.h
//  Aphrodite
//
//  Created by XuanLiang on 25/2/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>
#import "collectionViewCell.h"
#import "typeSearchController.h"


@interface FindViewController : UIViewController

@property(nonatomic,strong) UICollectionView *  CollectionView;

@property(nonatomic,strong) NSMutableArray *  MutableArray;

@end

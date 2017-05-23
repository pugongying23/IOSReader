//
//  ReaderViewController.h
//  Aphrodite
//
//  Created by XuanLiang on 4/5/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>
#import "topHead.h"
#import "readerFooter.h"
#import "readerSetting.h"
#import "notesRead.h"
#import "tools.h"


@interface ReaderViewController : UIViewController
@property(nonatomic,strong) NSString *  bookContentClassName;
@property(nonatomic,strong) UITextView *  TextView;
@property(nonatomic,assign) NSInteger  bookorder;
@property(nonatomic,assign) NSInteger  pageIndex;

@property(nonatomic,strong) UILabel *  pagenum;
@end

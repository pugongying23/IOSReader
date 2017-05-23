//
//  notesRead.h
//  Aphrodite
//
//  Created by XuanLiang on 5/5/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface notesRead : NSObject

@property(nonatomic,strong) NSDate *  readeDate;

@property(nonatomic,assign) NSInteger  bookorder;

@property(nonatomic,assign) NSInteger  pageIndex;

@property(nonatomic,strong) NSString *  title;

@end

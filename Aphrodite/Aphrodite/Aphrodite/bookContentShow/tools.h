//
//  tools.h
//  Aphrodite
//
//  Created by XuanLiang on 5/5/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>
#import "notesRead.h"

@interface tools : NSObject
+(NSArray *)NSStringPages:(NSString *)str  CGSizeMax:(CGSize)CGSizeMax  fontSize:(CGFloat)fontSize  ViewSize:(CGSize)ViewSize  fontFamily:(NSString *)fontFamily;
+(CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize fontFamily:(NSString *)fontFamily;
//归档数据
+(void)putDataIntoArchiver:(NSString *)bookContentClassName content:(notesRead *)note;
//解归档
+(NSMutableArray *)getDataFromArchiver:(NSString *)bookContentClassName;
//删除本地数据数据
+(void)DelFromArchiver:(NSString *)bookContentClassName  index:(NSInteger)index;
@end

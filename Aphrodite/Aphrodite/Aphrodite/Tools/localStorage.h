//
//  localStorage.h
//  Aphrodite
//
//  Created by XuanLiang on 21/4/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface localStorage : NSObject
//获取沙盒的路径
+(NSString *)getHomePath;
//Document的路径
+(NSString *)getDocumentPath;
//lib的路径
+(NSString *)getLibPath;
//tep的路径
+(NSString *)getTmpPath;
//文件内容的操作
+(BOOL)createFolder:(NSString *)folderName;
//文件的操作
+(BOOL)createFile:(NSString *)folderName  fileName:(NSString *)fileName;
//写入文件
+(void)writeFile:(NSString *)folderName  fileName:(NSString *)fileName content:(NSString *)content;
//追加内容
+(void)addFile:(NSString *)folderName  fileName:(NSString *)fileName content:(NSString *)content;
//删除
+(BOOL)deleteFile:(NSString *)folderName  fileName:(NSString *)fileName;
//存储NSUserDefaults的颜色
+(NSData *)NSUserDefaultsColorToString:(UIColor *)color;
//获取颜色
+(UIColor *)NSUserDefaultsStringToColor:(NSString *)color;
//归档数据
+(void)putDataIntoArchiver:(NSString *)str;
//解归档
+(NSMutableArray *)getDataFromArchiver;
//删除本地的存储
+(void)DelFromArchiver:(NSString *)objectId;
//数组是否包含字符串
+(BOOL)IsContentString:(NSString *)objectId  array:(NSMutableArray *)array;
//判断是否登陆
+(Boolean)IsLogin;
//判断账户是否相同
+(Boolean)IsChangeLogin;
//获取用户的id
+(NSString *)getUserId;
//存储数据
+(void)setValueByKey:(NSString *)value  key:(NSString *)key;
//获取账号
+(NSString *)getName;

@end

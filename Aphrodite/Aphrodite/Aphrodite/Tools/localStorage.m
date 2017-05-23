//
//  localStorage.m
//  Aphrodite
//
//  Created by XuanLiang on 21/4/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "localStorage.h"

@implementation localStorage

+(NSString *)getHomePath{
    return NSHomeDirectory();
}

+(NSString *)getDocumentPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) lastObject];
}

+(NSString *)getLibPath{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, true) firstObject];
}

+(NSString *)getTmpPath{
    return NSTemporaryDirectory();
}

+(BOOL)createFolder:(NSString *)folderName{
    NSString * path = [[self getDocumentPath] stringByAppendingPathComponent:folderName];
    NSFileManager * FileManager = [NSFileManager defaultManager];
    BOOL hasCreate = [FileManager createDirectoryAtPath:path withIntermediateDirectories:true attributes: nil error:nil];
    return hasCreate;
}


+(BOOL)createFile:(NSString *)folderName  fileName:(NSString *)fileName{
    NSString * filepath = [ [[self getDocumentPath] stringByAppendingPathComponent:folderName] stringByAppendingPathComponent:fileName];
    NSFileManager * FileManager =[NSFileManager defaultManager];
    BOOL hasFile = [FileManager createFileAtPath:filepath contents:nil attributes:nil];
    return hasFile;
}
+(void)writeFile:(NSString *)folderName  fileName:(NSString *)fileName content:(NSString *)content{
    NSString * filepath = [ [[self getDocumentPath] stringByAppendingPathComponent:folderName] stringByAppendingPathComponent:fileName];
    [content  writeToFile:filepath atomically:true encoding:NSUTF8StringEncoding error:nil];
}

+(void)addFile:(NSString *)folderName  fileName:(NSString *)fileName content:(NSString *)content{
    NSString * filepath = [ [[self getDocumentPath] stringByAppendingPathComponent:folderName] stringByAppendingPathComponent:fileName];
    NSFileHandle * handle =  [NSFileHandle fileHandleForUpdatingAtPath:filepath];
    NSData * data = [content dataUsingEncoding:NSUTF8StringEncoding];
    [handle writeData:data];
    [handle closeFile];
    
}

+(BOOL)deleteFile:(NSString *)folderName  fileName:(NSString *)fileName{
    NSString * filepath = [ [[self getDocumentPath] stringByAppendingPathComponent:folderName] stringByAppendingPathComponent:fileName];
    NSFileManager * FileManager = [NSFileManager defaultManager];
    
    if ([FileManager fileExistsAtPath:filepath]) {
        return [FileManager removeItemAtPath:filepath error:nil];;
    }else{
        return false;
    }
}

//存储NSUserDefaults的颜色
+(NSData *)NSUserDefaultsColorToString:(UIColor *)color{
    NSData *foregndcolorData = [NSKeyedArchiver archivedDataWithRootObject:color];
    return foregndcolorData;
}
//获取颜色
+(UIColor *)NSUserDefaultsStringToColor:(NSString *)color{
    NSData *foregroundcolorData = [[NSUserDefaults standardUserDefaults] objectForKey: color];
    UIColor *foregndcolor = [NSKeyedUnarchiver unarchiveObjectWithData:foregroundcolorData];
    return foregndcolor;
}

//归档数据
+(void)putDataIntoArchiver:(NSString *)str{
    
    NSString * fileName = [NSString stringWithFormat:@"%@.archiver",[localStorage getUserId]];
    NSString *  path = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
    NSFileManager * FileManager = [NSFileManager defaultManager];
    
    if ([FileManager fileExistsAtPath:path]) {
        NSMutableArray * array = [localStorage getDataFromArchiver];
        [array addObject:str];
        NSMutableData * data = [[NSMutableData alloc]init];
        NSKeyedArchiver * KeyedArchiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
        [KeyedArchiver encodeObject:array forKey:@"MutableArray"];
        [KeyedArchiver finishEncoding];
        [data writeToFile:path atomically:true];
        
    }else{
        NSMutableData * data = [[NSMutableData alloc]init];
        NSKeyedArchiver * KeyedArchiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
        NSMutableArray * MutableArray = [[NSMutableArray alloc]init];
        [MutableArray addObject:str];
        [KeyedArchiver encodeObject:MutableArray forKey:@"MutableArray"];
        [KeyedArchiver finishEncoding];
        [data writeToFile:path atomically:true];
    }
}

//解归档
+(NSMutableArray *)getDataFromArchiver{
    NSString * fileName = [NSString stringWithFormat:@"%@.archiver",[localStorage getUserId]];
    NSString *  path = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
    NSMutableData * data = [[NSMutableData alloc]initWithContentsOfFile:path];
    NSKeyedUnarchiver * UnKeyedArchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    NSMutableArray * array = [UnKeyedArchiver decodeObjectForKey:@"MutableArray"];
    return array;
}

//删除本地数据数据
+(void)DelFromArchiver:(NSString *)objectId{
    NSMutableArray * MutableArray = [localStorage getDataFromArchiver];
    [MutableArray removeObject:objectId];
    NSString * fileName = [NSString stringWithFormat:@"%@.archiver",[localStorage getUserId]];
    NSString *  path = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
    NSMutableData * data = [[NSMutableData alloc]init];
    NSKeyedArchiver * KeyedArchiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [KeyedArchiver encodeObject:MutableArray forKey:@"MutableArray"];
    [KeyedArchiver finishEncoding];
    [data writeToFile:path atomically:true];
}

//数组中是否包含字段
+(BOOL)IsContentString:(NSString *)objectId  array:(NSMutableArray *)array{
    BOOL b=true;
    if (array.count==0) {
        b=true;
    }else{
        if ([array indexOfObject:objectId]>array.count) {
            b=true;
        }else{
            b=false;
        }
    }
    return b;
}

//获取用户的id
+(NSString *)getUserId{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * userId = [user objectForKey:USER_ID_KEY];
    return userId;
}

+(NSString *)getName{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * username = [user objectForKey:USER_NAME_KEY];
    return username;
}
//存储数据
+(void)setValueByKey:(NSString *)value  key:(NSString *)key{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [user setObject:value forKey:key];
}
//判断是否登陆
+(Boolean)IsLogin{
    NSString * userId = [localStorage getUserId];
    if (userId.length>9) {
        return true;
    }else{
        return false;
    }
}
//判断账户是否相同
+(Boolean)IsChangeLogin{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * userId = [user objectForKey:USER_ID_KEY];
    NSString * userOldId = [user objectForKey:USER_OLD_ID_KEY];
    if ([userId isEqual:userOldId]) {
        return false;
    }else{
         return true;
    }
}
@end

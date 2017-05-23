//
//  tools.m
//  Aphrodite
//
//  Created by XuanLiang on 5/5/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "tools.h"

@implementation tools
//解析数据

+(NSArray *)NSStringPages:(NSString *)str  CGSizeMax:(CGSize)CGSizeMax  fontSize:(CGFloat)fontSize  ViewSize:(CGSize)ViewSize  fontFamily:(NSString *)fontFamily{
    //要返回的数组
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    //根据字符串，返回世纪的高度
    CGSize StringSize=[self sizeWithText:str maxSize:CGSizeMax fontSize:fontSize fontFamily:fontFamily];
    //字符的位置
    CGFloat current = 0;
    if ( ViewSize.height>StringSize.height) {
        //仅有一页
        NSRange range = NSMakeRange (current, str.length-current);
        [arr addObject:[NSValue valueWithRange:range]];
    }else{
        //多页
        //需要的大概的页数
        CGFloat Pages = floor(StringSize.height) / ViewSize.height;
        //字符串进行分割树,每页大概的字数
        CGFloat PageStringNumber=(str.length / floor(Pages));
        //字符串是否遍历结束
        Boolean flag=true;
        //长度
        CGFloat length=0;
        
        while (flag) {
            length = PageStringNumber;
            if (current + PageStringNumber > str.length) {
                NSRange range = NSMakeRange (current, str.length-current);
                [arr addObject:[NSValue valueWithRange:range]];
                flag=false;
            }else{
                
                NSRange range = NSMakeRange(current,PageStringNumber);
                NSString * pageString = [str substringWithRange:range];
                StringSize=[self sizeWithText:pageString maxSize:CGSizeMax fontSize:fontSize fontFamily:fontFamily];
                while (StringSize.height+80> ViewSize.height) {
                    length=length-1;
                    range = NSMakeRange(current,length);
                    pageString = [str substringWithRange:range];
                    StringSize=[self sizeWithText:pageString maxSize:CGSizeMax fontSize:fontSize fontFamily:fontFamily];
                }
                range = NSMakeRange(current,length);
                [arr addObject:[NSValue valueWithRange:range]];
                current = current+ length;
                flag=true;
                
            }
            
        }
        
    }
    return arr;
}



+(CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize fontFamily:(NSString *)fontFamily
{
    //    假设最大CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    //计算文本的大小
    
    CGSize nameSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont  fontWithName:fontFamily size:fontSize]} context:nil].size;
    return nameSize;
}



//归档数据
+(void)putDataIntoArchiver:(NSString *)bookContentClassName content:(notesRead *)note{
    
    NSString * fileName = [NSString stringWithFormat:@"%@.archiver", bookContentClassName];
    NSString *  path = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
    NSFileManager * FileManager = [NSFileManager defaultManager];
    
    if ([FileManager fileExistsAtPath:path]) {
        NSMutableArray * array = [tools getDataFromArchiver:bookContentClassName];
        [array addObject:note];
        NSMutableData * data = [[NSMutableData alloc]init];
        NSKeyedArchiver * KeyedArchiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
        [KeyedArchiver encodeObject:array forKey:@"MutableArray"];
        [KeyedArchiver finishEncoding];
        [data writeToFile:path atomically:true];
        
    }else{
        NSMutableData * data = [[NSMutableData alloc]init];
        NSKeyedArchiver * KeyedArchiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
        NSMutableArray * MutableArray = [[NSMutableArray alloc]init];
        [MutableArray addObject:note];
        [KeyedArchiver encodeObject:MutableArray forKey:@"MutableArray"];
        [KeyedArchiver finishEncoding];
        [data writeToFile:path atomically:true];
    }
}

//解归档
+(NSMutableArray *)getDataFromArchiver:(NSString *)bookContentClassName{
    NSString * fileName = [NSString stringWithFormat:@"%@.archiver",bookContentClassName];
    NSString *  path = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
    NSMutableData * data = [[NSMutableData alloc]initWithContentsOfFile:path];
    NSKeyedUnarchiver * UnKeyedArchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    NSMutableArray * array = [UnKeyedArchiver decodeObjectForKey:@"MutableArray"];
    return array;
}

//删除本地数据数据
+(void)DelFromArchiver:(NSString *)bookContentClassName  index:(NSInteger)index{
    NSMutableArray * MutableArray = [tools getDataFromArchiver:bookContentClassName];
    [MutableArray  removeObjectAtIndex:index];
    NSString * fileName = [NSString stringWithFormat:@"%@.archiver",bookContentClassName];
    NSString *  path = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
    NSMutableData * data = [[NSMutableData alloc]init];
    NSKeyedArchiver * KeyedArchiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [KeyedArchiver encodeObject:MutableArray forKey:@"MutableArray"];
    [KeyedArchiver finishEncoding];
    [data writeToFile:path atomically:true];
}


 

@end

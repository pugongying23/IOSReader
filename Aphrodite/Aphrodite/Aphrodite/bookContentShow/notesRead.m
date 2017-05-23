//
//  notesRead.m
//  Aphrodite
//
//  Created by XuanLiang on 5/5/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "notesRead.h"

@implementation notesRead

//对对象属性进行编码方法
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInt:self.pageIndex forKey:@"pageIndex"];
    [aCoder encodeInt:self.bookorder forKey:@"bookorder"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.readeDate forKey:@"readeDate"];
}
//对对象属性进行解码方法
- (id)initWithCoder:(NSCoder *)aDecoder{
    self=[super init];
    if (self!=nil) {
        self.pageIndex=[aDecoder decodeIntForKey:@"pageIndex"];
        self.bookorder=[aDecoder decodeIntForKey:@"bookorder"];
        self.readeDate = [aDecoder decodeObjectForKey:@"readeDate"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        
    }
    return self;
}


@end

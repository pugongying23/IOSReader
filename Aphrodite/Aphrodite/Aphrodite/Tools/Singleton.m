//
//  Singleton.m
//  Aphrodite
//
//  Created by XuanLiang on 21/4/17.
//  Copyright © 2017年 xuanHua. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

static Singleton *  _instance;


+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    return _instance ;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [Singleton shareInstance] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    self.IsHasAdd = [[NSMutableArray alloc]init];
    return [Singleton shareInstance] ;
}


@end

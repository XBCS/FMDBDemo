//
//  XBDatabase.h
//  FMDBDemo
//
//  Created by 李泽宇 on 16/3/23.
//  Copyright © 2016年 丶信步沧桑. All rights reserved.
//

#import "FMDatabase.h"


@interface XBDatabase : FMDatabase

// 单例类,只是简单的封装了个FMDatabase的单例.
+ (instancetype)sharedDatabaseManager;


@end

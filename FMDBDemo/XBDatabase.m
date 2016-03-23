//
//  XBDatabase.m
//  FMDBDemo
//
//  Created by 李泽宇 on 16/3/23.
//  Copyright © 2016年 丶信步沧桑. All rights reserved.
//

#import "XBDatabase.h"

@implementation XBDatabase
static id instance = nil;
+ (instancetype)sharedDatabaseManager {
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        
        NSString *dbPath = [docsPath stringByAppendingPathComponent:@"T_Person.db"];
        
        instance = FMDBReturnAutoreleased([[self alloc] initWithPath:dbPath]);
        
    });
//FMDBReturnAutoreleased([[self alloc] initWithPath:aPath]);
    return instance;
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (instance == nil) {
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [super allocWithZone:zone];
        });
    }
    return instance;
}

- (instancetype)initWithPath:(NSString *)inPath {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super initWithPath:inPath];
    });
    
    return instance;
}



@end

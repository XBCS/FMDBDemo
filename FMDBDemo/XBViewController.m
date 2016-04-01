//
//  XBViewController.m
//  FMDBDemo
//
//  Created by 李泽宇 on 16/3/21.
//  Copyright © 2016年 丶信步沧桑. All rights reserved.
//

#import "XBViewController.h"
#import "FMDB.h"
#import "XBStatusBarHUD.h"
#import "XBDatabase.h"
#import <objc/runtime.h>


@interface XBViewController ()

// 属性名 对应 字段名. 因下面想练习一下runtime,顾数据库中的表的字段名与属性名保持一致,来保证条件查询时,sql语句的拼接
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *height;


// 单例FMDatabase
@property (nonatomic, strong) XBDatabase *db;

@end

@implementation XBViewController

/// 懒加载
- (FMDatabase *)db {
    
    if (!_db) {
        
        _db = [XBDatabase sharedDatabaseManager];

    }
    
    return _db;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
   
}



#pragma -Mark - 监听事件
/// 创建表
- (IBAction)create:(id)sender {
    
    //访问修改数据库必须保证数据库是打开的,这样才能保证数据库的读写.
    //打开数据库,如果没有,会创建一个数据库.
    if (![self.db open]) {
        //        NSLog(@"失败");
        [XBStatusBarHUD message:@"失败"];
        return;
    }
    
    // 拼接创建表的sql语句, 字段名与属性名一致.
    NSString *tableString = @"CREATE TABLE IF NOT EXISTS T_Person ('Id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 'name' TEXT, 'age' INTEGER, 'height' REAL)";
    
    // executeUpdate: 此方法用于创建, 更新, 插入..返回值代表成功与否.
    BOOL isSuccess = [self.db executeUpdate:tableString];
    
    // 判断成功失败
    if (!isSuccess) {
        [XBStatusBarHUD message:@"创表失败"];
        return;
    }
    
    // XBStatusBarHUD: 还未完成的小小指示器,会在statusBar弹出一个window显示提示内容.
        [XBStatusBarHUD message:@"创表成功"];

    
}


/// 保存/插入/添加按钮
- (IBAction)saveButtonClick:(id)sender {
    

   // 插入数据
    BOOL isSave = [self.db executeUpdate:@"INSERT INTO T_Person (name, age, height) VALUES (?, ?, ?)",self.name.text,self.age.text,self.height.text];

    // 判断成功与否
    if (!isSave) {
        // UIAlertView, UIAlertView在iOS_9.0过期. UIAlertController iOS_8.0开始
        if ([UIDevice currentDevice].systemVersion.doubleValue >= 9.0) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"保存失败" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            
            [alert addAction:action];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        } else {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"友情提示" message:@"保存失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];

            [alertView show];
        }
    }
    
    [XBStatusBarHUD message:@"保存成功"];
    
}


/// 全部查询
- (IBAction)queryButtonClick:(id)sender {
    
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT id, name, age, height FROM T_Person;"];
    
    // executeQuery: 返回一个FMResultSet类型的结果集合.
    FMResultSet *resultAll = [self.db executeQuery:selectSQL];
    
    // 创表时id为 自增长 主键; 数据库若有数据,id可取值. 通过返回的resultAll调用intForColumn: 传入字段名(列名) 来查询这一列的值
    if (![resultAll intForColumn:@"id"]) {
        
        [XBStatusBarHUD message:@"数据库无数据"];
        
        return;
    }
    
    // 可通过循环调用 next 函数, 来遍历查询结果;
    while ([resultAll next]) {
        
        int Id = [resultAll intForColumn:@"id"];
        
        NSString *name = [resultAll stringForColumn:@"name"];
        
        int age = [resultAll intForColumn:@"age"];
        
        double height = [resultAll doubleForColumn:@"height"];
        
        NSLog(@"ID----%d, name----%@, age----%d, height----%.2f",Id, name, age, height);
    }

}

/// 条件查询
- (IBAction)criteriaqueriesButtonClick:(id)sender {
   
//    if (![self.db open]) {
//        return;
//    }
    
    // 拼接SQL语句, 此处拼接[self sqlString]使用运行时
    NSString *SQL =[NSString stringWithFormat:@"SELECT * %@", [self sqlString]];
    
    // 查看拼接的SQL语句
    NSLog(@"%@",SQL);
    
    FMResultSet *resultAll = [self.db executeQuery:SQL];
    
    // 判断是否查询到数据
    if (![resultAll intForColumn:@"id"]) {
        [XBStatusBarHUD message:@"查无此项"];
        return;
    }

    while ([resultAll next]) {
        
        int Id = [resultAll intForColumn:@"id"];
        
        NSString *name = [resultAll stringForColumn:@"name"];
        
        int age = [resultAll intForColumn:@"age"];
        
        double height = [resultAll doubleForColumn:@"height"];
        
        NSLog(@"ID----%d, name----%@, age----%d, height----%.2f",Id, name, age, height);
    }
    
    [XBStatusBarHUD message:@"查询成功"];
}

/// 删除语句.
- (IBAction)deleteButtonClick:(id)sender {
    
//    if (![self.db open]) {
//        return;
//    }
    
    // 字段若为TEXT = ''  一定要加单引号,不然会造成 text类型找不到错误.而INTEGER,REAL类型不会,为防止错误,所有字段的值都加''
    NSString *deleteSQL = [NSString stringWithFormat:@"DELETE %@",[self sqlString]];
    
    BOOL isDelete = [self.db executeUpdate:deleteSQL];
    
    if (!isDelete) {
        
        [XBStatusBarHUD message:@"删除失败"];
        
        return;
    }
    
    [XBStatusBarHUD message:@"删除成功"];
}


#pragma -Mark - Runtime 拼接字符串
- (NSString *)sqlString {
    
    
    unsigned int outCount;
    
    
    Ivar *ivars = class_copyIvarList([XBViewController class], &outCount);
    
    
    NSMutableDictionary *dictM = [[NSMutableDictionary alloc]init];
    
    
    
    for (int i=0; i<outCount; i++) {
        
        Ivar ivar = ivars[i];
        
        const char *type = ivar_getTypeEncoding(ivar);
        
        NSLog(@"%s",type);
        
        NSString *typeOc = [[NSString stringWithUTF8String:type] substringWithRange:NSMakeRange(2, 11)];
        
        if (![typeOc isEqualToString:@"UITextField"]) {
            continue;
        }
       
        
        const char *field = ivar_getName(ivar);

//        NSLog(@"%s",field);
        
        NSString *fieldString = [[NSString stringWithUTF8String:field] substringFromIndex:1];
        
        
        UITextField *value = [self valueForKey:fieldString];
        
    
        
        if ([value.text isEqualToString:@""]) {
            continue;
        }
        
//        NSLog(@"-----%@",value.text);
        
        [dictM setValue:value.text forKey:fieldString];
        
    }
    
    NSMutableString *sqlM = [NSMutableString stringWithString:@"FROM T_Person WHERE "];
    
    [dictM enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        NSLog(@"key-%@: value-%@",key,obj);
        
        [sqlM appendFormat: @"%@ = '%@' AND ",key ,obj];
        
    }];
    
    
    NSUInteger lenth = sqlM.length;
    
    NSRange range = NSMakeRange(0, lenth - 5);
    
    NSString * sql = [NSString stringWithFormat:@"%@;",[sqlM substringWithRange:range]];
    
    free(ivars);
    
    return sql;
}

@end

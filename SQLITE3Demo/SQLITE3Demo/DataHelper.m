//
//  DataHelper.m
//  SQLITE3Demo
//
//  Created by 刘康 on 16/2/26.
//  Copyright © 2016年 刘康. All rights reserved.
//

#import "DataHelper.h"
#import <sqlite3.h>
#import "Person.h"

@interface DataHelper ()
@property (strong, nonatomic) NSMutableArray* dataList;
@end

@implementation DataHelper
{
    sqlite3* _sqlite3;
}

/**
 *  打开数据库并创建一个表
 */
- (void)openDatabase
{
    //1.设置文件名
    NSString *filename = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"person.db"];
    NSLog(@"filename:%@", filename);
    //2.打开数据库文件，如果没有会自动创建一个文件
    NSInteger result = sqlite3_open(filename.UTF8String, &_sqlite3);
    if (result == SQLITE_OK) {
        NSLog(@"打开数据库成功！");
        //3.创建一个数据库表
        char *errmsg = NULL;
        sqlite3_exec(_sqlite3,
                     "CREATE TABLE IF NOT EXISTS t_person(id integer primary key autoincrement, name text, age integer)",
                     NULL,
                     NULL,
                     &errmsg);
        if (errmsg) {
            NSLog(@"错误：%s", errmsg);
        } else {
            NSLog(@"创表成功！");
        }
    } else {
        NSLog(@"打开数据库失败！");
    }
}

/**
 *  往表中插入1000条数据
 */
- (void)insertData {
    NSString *nameStr;
    NSInteger age;
    for (NSInteger i = 0; i < 1000; i++) {
        nameStr = [NSString stringWithFormat:@"Bourne-%d", arc4random_uniform(10000)];
        age = arc4random_uniform(80) + 20;
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_person (name, age) VALUES('%@', '%ld')", nameStr, age];
        char *errmsg = NULL;
        sqlite3_exec(_sqlite3, sql.UTF8String, NULL, NULL, &errmsg);
        if (errmsg) {
            NSLog(@"错误：%s", errmsg);
        }
    }
    NSLog(@"插入完毕！");
}

/**
 *  从表中读取数据到数组中
 */
- (void)readData {
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:1000];
    char *sql = "select name, age from t_person;";
    sqlite3_stmt *stmt;
    NSInteger result = sqlite3_prepare_v2(_sqlite3, sql, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            char *name = (char *)sqlite3_column_text(stmt, 0);
            NSInteger age = sqlite3_column_int(stmt, 1);
            //创建对象
            Person *person = [Person personWithName:[NSString stringWithUTF8String:name] age:age];
            [mArray addObject:person];
        }
        self.dataList = mArray;
    }
    sqlite3_finalize(stmt);
    [self printData];
}

- (void)printData {
    NSLog(@"data count: %ld\n", (long)self.dataList.count);
    if (self.dataList.count) {
        for (Person* person in self.dataList) {
            NSLog(@"Name: %@, Age:%ld", person.name, person.age);
        }
    }
}

@end

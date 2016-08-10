//
//  Person.h
//  SQLITE3Demo
//
//  Created by 刘康 on 16/2/26.
//  Copyright © 2016年 刘康. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (copy, nonatomic) NSString* name;
@property (assign) NSInteger age;

+ (instancetype)personWithName:(NSString*)name age:(NSInteger)age;

@end

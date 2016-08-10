//
//  Person.m
//  SQLITE3Demo
//
//  Created by 刘康 on 16/2/26.
//  Copyright © 2016年 刘康. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (instancetype)personWithName:(NSString *)name age:(NSInteger)age
{
    Person* person = [[Person alloc] init];
    person.name = name;
    person.age = age;
    return person;
}

@end

//
//  Person.m
//  RuntimeResearch
//
//  Created by Origheart on 16/5/18.
//  Copyright © 2016年 Origheart. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

//注意：归档解档需要遵守<NSCoding>协议，实现以下两个方法
- (void)encodeWithCoder:(NSCoder *)encoder{
    //归档存储自定义对象
    unsigned int count = 0;
    //获得指向该类所有属性的指针
    objc_property_t *properties = class_copyPropertyList([Person class], &count);
    for (int i =0; i < count; i ++) {
        //获得
        objc_property_t property = properties[i];
        //根据objc_property_t获得其属性的名称--->C语言的字符串
        const char *name = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:name];
        // 编码每个属性,利用kVC取出每个属性对应的数值
        [encoder encodeObject:[self valueForKeyPath:key] forKey:key];
    }
}

- (instancetype)initWithCoder:(NSCoder *)decoder{
    //归档存储自定义对象
    unsigned int count = 0;
    //获得指向该类所有属性的指针
    objc_property_t *properties = class_copyPropertyList([Person class], &count);
    for (int i =0; i < count; i ++) {
        objc_property_t property = properties[i];
        //根据objc_property_t获得其属性的名称--->C语言的字符串
        const char *name = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:name];
        //解码每个属性,利用kVC取出每个属性对应的数值
        [self setValue:[decoder decodeObjectForKey:key] forKeyPath:key];
    }
    return self;
}


- (void)eat
{
    NSLog(@"person eat");
}

+ (void)eat
{
    NSLog(@"Person eat");
}

// 默认方法都有两个隐式参数
void walk(id self, SEL sel)
{
    NSLog(@"%@ %@",self,NSStringFromSelector(sel));
}

// 当一个对象调用未实现的方法，会调用这个方法处理,并且会把对应的方法列表传过来.
// 这儿可以用来判断，未实现的方法是不是我们想要动态添加的方法
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(walk)) {
        // 动态添加walk方法
        
        // 第一个参数：给哪个类添加方法
        // 第二个参数：添加方法的方法编号
        // 第三个参数：添加方法的函数实现（函数地址）
        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        class_addMethod(self, sel, walk, "v@:");
        
    }
    return [super resolveInstanceMethod:sel];
}

+ (NSDictionary *)arrayContainModelClass
{
    return @{@"hobby" : @"Hobby"};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"hobby" : [Hobby class]};
}
@end
@implementation Addr

@end


@implementation Hobby

@end



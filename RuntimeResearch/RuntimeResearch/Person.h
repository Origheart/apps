//
//  Person.h
//  RuntimeResearch
//
//  Created by Origheart on 16/5/18.
//  Copyright © 2016年 Origheart. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelDelegate <NSObject>

- (id)arrayContainModelClass;

@end

@class Addr,Hobby;
@interface Person : NSObject <NSCoding, ModelDelegate>

@property (copy, nonatomic) NSString *name, *job;

@property (nonatomic) NSUInteger age;

@property (nonatomic) BOOL gender;

@property (nonatomic, strong) NSArray<Hobby *> *hobby;

@property (nonatomic, strong) Addr *addr;

- (void)eat;
+ (void)eat;

@end


@interface Addr : NSObject

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *code;

@end


@interface Hobby : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *code;

@end


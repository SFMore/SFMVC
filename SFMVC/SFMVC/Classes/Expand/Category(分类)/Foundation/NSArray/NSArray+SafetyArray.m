//
//  NSArray+SafetyArray.m
//  FundSale
//
//  Created by zsf on 16/9/27.
//  Copyright © 2016年 zsf. All rights reserved.
//

#import "NSArray+SafetyArray.h"

#ifdef DEBUG
#define AppLog(format,...)  NSLog((@"[函数名:%s]\n" "[行号:%d]\n" format),__FUNCTION__,__LINE__,##__VA_ARGS__)
#else
#define AppLog(...)
#endif

@implementation NSArray (SafetyArray)

+ (id)arrayWithObjectForSafety:(id)anobject
{
    if (nil != anobject) {
        return [self arrayWithObject:anobject];
    }else
    {
        return nil;
    }
}

- (id)objectAtIndexForSafety:(NSUInteger)index
{
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    else
    {
        NSAssert(NO, @"数组越界了。。。");
        return nil;
    }
}

/* 将指定的数组创建反向数组 */
+ (NSArray *)reversedArray:(NSArray*)array
{
    // 从一个阵列容量初始化阵列
    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:[array count]];
    // 获取NSArray的逆序枚举器
    NSEnumerator *enumerator = [array reverseObjectEnumerator];
    
    for(id element in enumerator) [arrayTemp addObject:element];
    
    return arrayTemp;
}

@end


@implementation NSMutableArray (SafetyMutalbeArray)
- (void)insertObjectForSafety:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject != nil && index <= [self count]) {
        [self insertObject:anObject atIndex:index];
    }else
    {
        NSAssert(NO, @"插入的对象是空或者插入的索引越界了。。。");
    }
}

@end

//
//  NSArray+SafetyArray.h
//  FundSale
//
//  Created by zsf on 16/9/27.
//  Copyright © 2016年 zsf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SafetyArray)
+ (id)arrayWithObjectForSafety:(id)anobject;

- (id)objectAtIndexForSafety:(NSUInteger)index;

/**
 *  将指定的数组创建反向数组
 */
+ (NSArray *)reversedArray:(NSArray *)array;
@end


@interface NSMutableArray (SafetyMutalbeArray)

- (void)insertObjectForSafety:(id)anObject atIndex:(NSUInteger)index;
@end
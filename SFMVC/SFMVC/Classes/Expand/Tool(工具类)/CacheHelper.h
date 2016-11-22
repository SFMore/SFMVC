//
//  CacheHelper.h
//  JJJR
//
//  Created by yinhongtao on 6/19/15.
//  Copyright (c) 2015 yinhongtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheHelper : NSObject

/**
 *  加入缓存 value/key
 */
+(void)cacheKeyValues:(NSDictionary*)value forKey:(NSString*)key;

/**
 *  取出key对应的缓存
 */
+(NSDictionary*)getValuesForKey:(NSString*)key;

/**
 *  字符串缓存
 */
+(void)cacheString:(NSString*)value forKey:(NSString*)key;

/**
 *  获取缓存中的字符串
 */
+(NSString*)getStringForKey:(NSString*)key;

/**
 *  动态列表缓存
 */
+(void)cacheMuTableArray:(NSMutableArray*)value forKey:(NSString*)key;

/**
 *  获取缓存中的动态列表
 */
+(NSMutableArray*)getMuTableArrayForKey:(NSString*)key;

/**
 *  日期缓存
 */
+(void)cacheDate:(NSDate*)value forKey:(NSString*)key;

+ (void)cacheBool:(BOOL)value forKey:(NSString*)key;

+ (BOOL)getBoolForKey:(NSString *)key;

/**
 *  获取缓存中的日期
 */
+(NSDate*)getDateForKey:(NSString*)key;

/**
 *  清空key对应的缓存
 */
+(void)removeCacheForKey:(NSString*)key;

@end

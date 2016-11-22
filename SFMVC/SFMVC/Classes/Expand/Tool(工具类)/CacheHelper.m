//
//  CacheHelper.m
//  JJJR
//
//  Created by yinhongtao on 6/19/15.
//  Copyright (c) 2015 yinhongtao. All rights reserved.
//

#import "CacheHelper.h"

@implementation CacheHelper

+(void)cacheKeyValues:(NSDictionary*)value forKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSDictionary*)getValuesForKey:(NSString*)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}


+(void)cacheString:(NSString*)value forKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+(NSString*)getStringForKey:(NSString*)key
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
}

+ (void)cacheBool:(BOOL)value forKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getBoolForKey:(NSString *)key
{
   return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}


+(void)cacheMuTableArray:(NSMutableArray*)value forKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSMutableArray*)getMuTableArrayForKey:(NSString*)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
}

+(void)cacheDate:(NSDate*)value forKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSDate*)getDateForKey:(NSString*)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
}

+(void)removeCacheForKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

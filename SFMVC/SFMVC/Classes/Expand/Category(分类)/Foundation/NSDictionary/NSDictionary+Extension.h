//
//  NSDictionary+Extension.h
//  SFMVC
//
//  Created by zsf on 16/11/4.
//  Copyright © 2016年 zsf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)
/**
 *  @brief  将url参数转换成NSDictionary
 *
 *  @param query url参数
 *
 *  @return NSDictionary
 */
+ (NSDictionary *)dictionaryWithURLQuery:(NSString *)query;
/**
 *  @brief  将NSDictionary转换成url 参数字符串
 *
 *  @return url 参数字符串
 */
- (NSString *)urlQueryString;
/**
 *  @brief NSDictionary转换成JSON字符串
 *
 *  @return  JSON字符串
 */
-(NSString *)dictionaryToJSONString;


@end


@interface NSMutableDictionary (SafetyMutableDictionary)
- (void)setSafeObject:(id)anObject forKey:(id<NSCopying>)aKey;
@end
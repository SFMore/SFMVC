//
//  StringUtil.h
//  JJJR
//
//  Created by yinhongtao on 4/30/15.
//  Copyright (c) 2015 yinhongtao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PHONENUMBER_LIMIT 11
#define NICKNAME_LIMIT 16
#define VERIFYCODE_LIMIT 6
#define PASSWORD_LIMIT 16
#define PASSWORD_NEW_LIMIT 8
#define IDENTITY_LIMIT 18
#define NUMBERS_ONLY @"1234567890"
#define NUMBERSDOT_ONLY @"1234567890."
#define ALPHA_ONLY @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define ALPHANUM_ONLY @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

@interface StringUtil : NSObject
+ (BOOL)validateMoney:(NSString *)number Range:(NSRange)range String:(NSString *)string;

//+ (BOOL)validateMoney:(NSString *)number;

+ (BOOL)validateNumbers:(NSString *)number;

+ (BOOL)validatePSW:(NSString *)string;

+ (BOOL)isNullOrEmpty:(NSString *)str;

+ (BOOL) validateBankNumber:(NSString *) bankNumber;

+ (BOOL)validateChinese:(NSString *)string;

+ (BOOL)validateEmail:(NSString *)email;

+ (BOOL)validateMobilePhone:(NSString *)mobile;

+ (BOOL)validateIdentity:(NSString *)identityCard;
+ (BOOL)validateIsAdult:(NSString *)identityCard;
+ (NSString *)trimSpacesOfString:(NSString *)str;

+ (NSString* )starsReplacedOfString:(NSString *)str withinRange:(NSRange)range;

+ (BOOL)validateNickName:(NSString *)string;

+ (BOOL)valiInviteCode:(NSString *)string;

+ (BOOL)valiLoginPSW:(NSString *)string;
+ (BOOL)valiTransPSW:(NSString *)string;
//验证输入的密码为数字、大小写字母和标点符号
+(BOOL)validatePassword:(NSString *)password;

/*!
 *  检测用户输入密码是否以字母开头，长度在6-18之间，只能包含字符、数字和下划线。
 *
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)valiPasswordQualified:(NSString *)passwordStr;

/*!
 *  验证身份证号（15位或18位数字）【最全的身份证校验，带校验位】
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)valiIdCardNumberQualified:(NSString *)idCardNumberStr;

/*!
 *  验证输入的是否是URL地址
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)valiUrl:(NSString *)urlStr;
@end

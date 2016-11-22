//
//  StringUtil.m
//  JJJR
//
//  Created by yinhongtao on 4/30/15.
//  Copyright (c) 2015 yinhongtao. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil


+ (BOOL)isNullOrEmpty:(NSString *)str {
    return ([str isEqualToString:@""] || str == nil);
}

//校验两位小数金额输入
+ (BOOL)validateMoney:(NSString *)number Range:(NSRange)range String:(NSString *)string
{
    NSInteger strLength = number.length - range.length + string.length;
    NSCharacterSet *cs;
    NSUInteger nDotLoc = [number rangeOfString:@"."].location;
//    unichar single = [string characterAtIndex:0];//当前输入的字符
//    if([number length] == 1){
//        if([number isEqualToString:@"0"]){
//            if (single == '.') {
//                //                    如果第一位是0,第二位必须是.
//                [number stringByReplacingCharactersInRange:range withString:@""];
//                return YES;
//            }
//            else{
//                return NO;
//            }
//            
//        }
//    }
    if (NSNotFound == nDotLoc && 0 != range.location) {
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERSDOT_ONLY] invertedSet];
        if([string isEqualToString:@"."]){
            return YES;
        }
        if(!(strLength <= 13)){
            return NO;
        }
    }
    else
    {
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        if(!(strLength <= 16)){
            return NO;
        }
    }
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest)
    {
        return NO;
    }
    if (NSNotFound != nDotLoc && range.location > nDotLoc + 2)
    {
        return NO;
    }
    return YES;
    
//    BOOL isHaveDian = YES;
//    if ([number rangeOfString:@"."].location == NSNotFound) {
//        isHaveDian = NO;
//    }
//    if ([string length] > 0) {
//        
//        unichar single = [string characterAtIndex:0];//当前输入的字符
//        if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
//            
//            //首字母不能为0和小数点
//            if([number length] == 0){
//                if(single == '.') {
//                    //                    第一个数字不能为小数点
//                    [number stringByReplacingCharactersInRange:range withString:@""];
//                    return NO;
//                }
//            }
//            
//            if([number length] == 1){
//                if([number isEqualToString:@"0"]){
//                    if (single == '.') {
//                        //                    如果第一位是0,第二位必须是.
//                        [number stringByReplacingCharactersInRange:range withString:@""];
//                        return YES;
//                    }
//                    else{
//                        return NO;
//                    }
//                    
//                }
//            }
//
//            //输入的字符是否是小数点
//            if (single == '.') {
//                if(!isHaveDian)//text中还没有小数点
//                {
//                    isHaveDian = YES;
//                    return YES;
//                }else{
//                    //                    已经输入过小数点了
//                    [number stringByReplacingCharactersInRange:range withString:@""];
//                    return NO;
//                }
//            }else{
//                if (isHaveDian) {//存在小数点
//                    
//                    //判断小数点的位数
//                    NSRange ran = [number rangeOfString:@"."];
//                    if (range.location - ran.location <= 2) {
//                        return YES;
//                    }else{
//                        //                        最多输入两位小数
//                        return NO;
//                    }
//                }else{
//                    return YES;
//                }
//            }
//        }else{//输入的数据格式不正确
//            [number stringByReplacingCharactersInRange:range withString:@""];
//            return NO;
//        }
//    }
//    else
//    {
//        return YES;
//    }


    
}

//校验全数字字符
+ (BOOL)validateNumbers:(NSString *)number
{
    
    NSString *num=@"^[0-9]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",num];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}

//邮箱
+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:[self trimSpacesOfString:email]];
}

//银行卡号校验
+ (BOOL) validateBankNumber:(NSString *) bankNumber{
    NSString *bankNum=@"^([0-9]{16}|[0-9]{17}|[0-9]{18}|[0-9]{19})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:bankNumber];
    return isMatch;
}

//手机号码验证
+ (BOOL)validateMobilePhone:(NSString *)telNumber {
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[01678]|8[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:telNumber];
}

//验证输入的密码为数字、大小写字母和标点符号
+(BOOL)validatePassword:(NSString *)password
{
    NSString *passwordRegex = @"[^%&',;=?$\x22]|[a-zA-Z0-9]*";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [identityCardPredicate evaluateWithObject:[self trimSpacesOfString:password]];
}
//身份证号
+ (BOOL)validateIdentity:(NSString *)identityCard {
    
    if (identityCard.length <= 0)
    {
        return false;
    }

    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
    return [identityCardPredicate evaluateWithObject:[self trimSpacesOfString:identityCard]];
}


+ (BOOL)validateIsAdult:(NSString *)identityCard
{
    NSString *birthdayStr = [identityCard substringWithRange:NSMakeRange(6, 8)];
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"yyyyMMdd"];
    [fm setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSDate *date = [fm dateFromString:birthdayStr];
    NSDateComponents *cmps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear
    |NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date toDate:[NSDate date] options:0];
    return cmps.year >= 18;
}

//验证是否全中文
+ (BOOL)validateChinese:(NSString *)string
{
    NSString *phoneRegex = @"^[\\u4E00-\\u9FA5]+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:[self trimSpacesOfString:string]];
}

//验证昵称
+(BOOL)validateNickName:(NSString *)string
{
    NSString *phoneRegex = @"^[\u4e00-\u9fa5a-zA-Z0-9_-]+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:[self trimSpacesOfString:string]];
}


+ (BOOL)validatePSW:(NSString *)string {

    if (string.length <= 0) return false;

    return ![[string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] isEqualToString:string]
            && ![[string stringByTrimmingCharactersInSet:[NSCharacterSet letterCharacterSet]] isEqualToString:string];
}

//打上星号
+ (NSString* )starsReplacedOfString:(NSString *)str withinRange:(NSRange)range;
{
    if (str == nil || [str length]< range.location + range.length)
    {
        return str;
    }
    

    NSMutableString* mStr = [[NSMutableString alloc]initWithString:str];
   
    [mStr replaceCharactersInRange:range withString:[[NSString string] stringByPaddingToLength:range.length withString: @"*" startingAtIndex:0]];
    
    return mStr;
}


//去掉空格
+ (NSString *)trimSpacesOfString:(NSString *)str
{
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+ (BOOL)valiInviteCode:(NSString *)string {
    NSString *regex = @"^[a-zA-Z]\\d{4}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:[self trimSpacesOfString:string]];
}

//验证登录密码
+ (BOOL)valiLoginPSW:(NSString *)string {
    NSString *regex = @"^[A-Za-z0-9]{6,8}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:[self trimSpacesOfString:string]];
}

//验证交易密码
+ (BOOL)valiTransPSW:(NSString *)string
{
    NSString *regex = @"^[A-Za-z0-9]{8,16}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:[self trimSpacesOfString:string]];
}

/*!
 *  检测用户输入密码是否以字母开头，长度在6-18之间，只能包含字符、数字和下划线。
 *
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)valiPasswordQualified:(NSString *)passwordStr
{
    
    NSString *passWordRegex = @"^[a-zA-Z]\\w.{5,17}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passwordStr];
}


/*!
 *  验证身份证号（15位或18位数字）【最全的身份证校验，带校验位】
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)valiIdCardNumberQualified:(NSString *)idCardNumberStr
{
    
    idCardNumberStr = [idCardNumberStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length = 0;
    if (!idCardNumberStr)
    {
        return NO;
    }
    else
    {
        length = idCardNumberStr.length;
        if (length != 15 && length !=18)
        {
            return NO;
        }
    }
    /*! 省份代码 */
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    
    NSString *valueStart2 = [idCardNumberStr substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray)
    {
        if ([areaCode isEqualToString:valueStart2])
        {
            areaFlag =YES;
            break;
        }
    }
    if (!areaFlag)
    {
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    NSInteger year = 0;
    switch (length)
    {
        case 15:
            year = [idCardNumberStr substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0))
            {
                /*! 测试出生日期的合法性 */
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
            }
            else
            {
                /*! 测试出生日期的合法性 */
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
            }
            numberofMatch = [regularExpression numberOfMatchesInString:idCardNumberStr
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, idCardNumberStr.length)];
            
            if(numberofMatch > 0)
            {
                return YES;
            }
            else
            {
                return NO;
            }
            break;
        case 18:
            
            year = [idCardNumberStr substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0))
            {
                /*! 测试出生日期的合法性 */
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
            }
            else
            {
                /*! 测试出生日期的合法性 */
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
            }
            numberofMatch = [regularExpression numberOfMatchesInString:idCardNumberStr
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, idCardNumberStr.length)];
            
            if(numberofMatch > 0)
            {
                NSInteger S = ([idCardNumberStr substringWithRange:NSMakeRange(0,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([idCardNumberStr substringWithRange:NSMakeRange(1,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([idCardNumberStr substringWithRange:NSMakeRange(2,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([idCardNumberStr substringWithRange:NSMakeRange(3,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([idCardNumberStr substringWithRange:NSMakeRange(4,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([idCardNumberStr substringWithRange:NSMakeRange(5,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([idCardNumberStr substringWithRange:NSMakeRange(6,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(16,1)].intValue) *2 + [idCardNumberStr substringWithRange:NSMakeRange(7,1)].intValue *1 + [idCardNumberStr substringWithRange:NSMakeRange(8,1)].intValue *6 + [idCardNumberStr substringWithRange:NSMakeRange(9,1)].intValue *3;
                NSInteger Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                /*! 判断校验位 */
                M = [JYM substringWithRange:NSMakeRange(Y,1)];
                if ([M isEqualToString:[idCardNumberStr substringWithRange:NSMakeRange(17,1)]])
                {
                    /*! 检测ID的校验位 */
                    return YES;
                }
                else
                {
                    return NO;
                }
                
            }
            else
            {
                return NO;
            }
            break;
        default:
            return NO;
            break;
    }
}

/*!
 *  验证输入的是否是URL地址
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)valiUrl:(NSString *)urlStr
{
   
    NSString *pattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:urlStr options:0 range:NSMakeRange(0, urlStr.length)];
    return results.count > 0;
}

@end

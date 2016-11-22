//
//  Macros.h
//  SFMVC
//
//  Created by zsf on 16/9/29.
//  Copyright © 2016年 zsf. All rights reserved.
//

//中文字体
#define CHINESE_FONT_NAME  @"Heiti SC"
#define CHINESE_SYSTEM(x) [UIFont fontWithName:CHINESE_FONT_NAME size:x]

//不同屏幕尺寸字体适配（320，568是因为效果图为IPHONE5 如果不是则根据实际情况修改）
#define kScreenWidthRatio  (SCREEN_WIDTH / 320.0)
#define kScreenHeightRatio (SCREEN_HEIGHT / 568.0)
#define kAdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
#define kAdaptedHeight(x) ceilf((x) * kScreenHeightRatio)
#define kFontSize(R)     CHINESE_SYSTEM(kAdaptedWidth(R))

//获取View的属性
#define kGetViewWidth(view)  (view).frame.size.width
#define kGetViewHeight(view) (view).frame.size.height
#define kGetViewX(view)      (view).frame.origin.x
#define kGetViewY(view)      (view).frame.origin.y

// MainScreen Height&Width
#define kScreen_Width   [UIScreen mainScreen].bounds.size.width
#define kScreen_Height [UIScreen mainScreen].bounds.size.height

// MainScreen bounds
#define Main_Screen_Bounds [[UIScreen mainScreen] bounds]

//色值
#define kRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define kRGB(r,g,b) RGBA(r,g,b,1.0f)

#define kHEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

//字体
#define kFont(x) ([UIFont systemFontOfSize:x])
#define kBoldFont(x) ([UIFont boldSystemFontOfSize:x])


//设置 view 圆角和边框
#define kViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define kViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//导航栏高度
#define kTopBarHeight 64
#define kBottomBarHeight 49


//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || [str isEqualToString: @"(null)"] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//App版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// 判断是否为 iPhone 5SE
#define iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f
// 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f
// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f


//获取图片资源
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

/**项目打包上线都不会打印日志，因此可放心。*/
#ifdef DEBUG
#define kAppLog(format,...)  NSLog((@"[函数名:%s]\n" "[行号:%d]\n" format),__FUNCTION__,__LINE__,##__VA_ARGS__)
#else
#define kAppLog(...)
#endif


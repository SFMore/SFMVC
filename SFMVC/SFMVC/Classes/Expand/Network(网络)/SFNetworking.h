//
//  SFNetworking.h
//  SFMVC
//
//  Created by zsf on 16/10/8.
//  Copyright © 2016年 zsf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  手机网络状态
 */
typedef enum : NSInteger {
    StatusUnknown           = -1, //未知网络
    StatusNotReachable      = 0,    //没有网络
    StatusReachableViaWWAN  = 1,    //手机自带网络
    StatusReachableViaWiFi  = 2     //wifi
} NetworkStatu;

/**
 *  请求方式 GET OR POST
 */
typedef enum HttpMethod {
    GET,
    POST
} httpMethod;

/** 成功回调*/
typedef void( ^ SFResponseSuccess)(id response);

/** 失败回调*/
typedef void( ^ SFResponseFail)(NSError *error);

/** 缓存的Block */
typedef void(^SFResponseCache)(id responseCache);

/**
 *  网络请求回调
 *
 *  @param result    返回数据 nil 为空
 *  @param error     错误描述
 */
typedef void(^ResultBlock)(id result, NSError *error);

typedef void( ^ SFUploadProgress)(int64_t bytesProgress,
                                   int64_t totalBytesProgress);

typedef void( ^ SFDownloadProgress)(int64_t bytesProgress,
                                     int64_t totalBytesProgress);


typedef NSURLSessionTask SFURLSessionTask;

@interface SFNetworking : NSObject

@property (nonatomic,assign)NetworkStatu networkStats;

/**
 *  单例
 */
+ (SFNetworking *)sharedSFNetworking;


/**
 *  开启网络监测
 */
+ (void)startMonitoring;

/**
 *  获取网络状态
 */
+ (NetworkStatu)checkNetStatus;

/**
 *  是否有网络连接
 */

+ (BOOL) isHaveNetwork;

/**
 *  post 或者 get 请求方法,block回调
 *  @param httpMethod       网络请求类型
 *  @param url              请求连接，根路径
 *  @param params           参数字典
 *  @param showView         HUD 展示view
 *  @param responseCache    返回缓存数据
 *  @param success          请求成功返回数据
 *  @param fail             请求失败
 *  @param showHUD          是否显示HUD
 */


+(SFURLSessionTask *)getOrPostWithType:(httpMethod)httpMethod WithUrl:(NSString *)url params:(NSDictionary *)params cache:(SFResponseCache)responseCache success:(SFResponseSuccess)success fail:(SFResponseFail)fail showHUD:(BOOL)showHUD toShowView:(UIView *)showView;


/**
 *  post 请求方法,block回调
 *  @param urlString        请求连接
 *  @param parameters       参数字典
 *  @param requestBlock     回调
 */
+ (void)postWithUrl:(NSString *)urlString parameters:(id)parameters result:(ResultBlock)requestBlock;


/**
 *  post 请求方法,无缓存
 *  @param urlString        请求连接
 *  @param parameters       参数字典
 *  @param requestBlock     请求回调
 *  @param isShowHud        是否加HUD
 *  @param showView         HUD加载的View
 */
+ (void)postWithUrl:(NSString *)urlString parameters:(id)parameters result:(ResultBlock)requestBlock hud:(BOOL)isShowHud toShowView:(UIView *)showView;


/**
 *  post 请求方法,带缓存
 *  @param urlString        请求连接
 *  @param parameters       参数字典
 *  @param requestBlock     请求回调
 *  @param cacheBlock       缓存回调
 *  @param isShowHud        是否加HUD
 *  @param showView         HUD加载的View
 */
+ (void)postWithUrl:(NSString *)urlString parameters:(id)parameters resultBlock:(ResultBlock)requestBlock cacheBlock:(ResultBlock)cacheBlock hud:(BOOL)isShowHud toShowView:(UIView *)showView;




/**
 *  get 请求方法,block回调
 *  @param urlString        请求连接
 *  @param parameters       参数字典
 *  @param requestBlock     回调
 */
+ (void)getWithUrl:(NSString *)urlString parameters:(id)parameters result:(ResultBlock)requestBlock;


/**
 *  get 请求方法,无缓存
 *  @param urlString        请求连接
 *  @param parameters       参数字典
 *  @param requestBlock     请求回调
 *  @param isShowHud        是否加HUD
 *  @param showView         HUD加载的View
 */
+ (void)getWithUrl:(NSString *)urlString parameters:(id)parameters result:(ResultBlock)requestBlock hud:(BOOL)isShowHud toShowView:(UIView *)showVie;

/**
 *  get 请求方法,带缓存
 *  @param urlString        请求连接
 *  @param parameters       参数字典
 *  @param requestBlock     请求回调
 *  @param cacheBlock       缓存回调
 *  @param isShowHud        是否加HUD
 *  @param showView         HUD加载的View
 */
+ (void)getWithUrl:(NSString *)urlString parameters:(id)parameters resultBlock:(ResultBlock)requestBlock cacheBlock:(ResultBlock)cacheBlock hud:(BOOL)isShowHud toShowView:(UIView *)showView;



/**
 *  上传图片方法 支持多张上传和单张上传
 *  @param image      上传的图片数组
 *  @param url        请求连接，根路径
 *  @param filename   图片的名称(如果不传则以当前时间命名)
 *  @param names      上传图片时参数数组 <后台 处理文件的[字段]>
 *  @param params     参数字典
 *  @param loadingImageArr  loading图片数组
 *  @param showView  HUD 展示view
 *  @param progress   上传进度
 *  @param success    请求成功返回数据
 *  @param fail       请求失败返回数据
 *  @param showHUD    是否显示HUD
 */

+ (SFURLSessionTask *)uploadWithImages:(NSArray *)imageArr url:(NSString *)url filename:(NSString *)filename names:(NSArray *)nameArr params:(NSDictionary *)params loadingImageArr:(NSMutableArray *)loadingImageArr toShowView:(UIView *)showView progress:(SFUploadProgress)progress success:(SFResponseSuccess)success fail:(SFResponseFail)fail showHUD:(BOOL)showHUD;

/**
 *  下载文件方法
 *  @param url           下载地址
 *  @param saveToPath    文件保存的路径,如果不传则保存到Documents目录下，以文件本来的名字命名
 *  loadingImageArr      loading图片数组
 *  @param showView      HUD 展示view
 *  @param progressBlock 下载进度回调
 *  @param success       下载完成
 *  @param fail          失败
 *  @param showHUD       是否显示HUD
 *  @return              返回请求任务对象，便于操作
 */
+ (SFURLSessionTask *)downloadWithUrl:(NSString *)url saveToPath:(NSString *)saveToPath loadingImageArr:(NSMutableArray *)loadingImageArr progress:(SFDownloadProgress )progressBlock toShowView:(UIView *)showView success:(SFResponseSuccess )success failure:(SFResponseFail )fail showHUD:(BOOL)showHUD;


@end

//
//  SFNetworking.m
//  SFMVC
//
//  Created by zsf on 16/10/8.
//  Copyright © 2016年 zsf. All rights reserved.
//

#import "SFNetworking.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+ADD.h"
#import "Reachability.h"
#import "SFNetworkCache.h"

#ifdef DEBUG
#   define SFLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define SFLog(...)
#endif

static NSString *const notNetTitle = @"当前无网络";
static NSMutableArray *tasks;
@implementation SFNetworking
+ (SFNetworking *)sharedSFNetworking
{
    static SFNetworking *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[SFNetworking alloc] init];
    });
    return handler;
}

+ (NSMutableArray *)tasks
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tasks = [NSMutableArray array];
    });
    return tasks;
}

+ (AFHTTPSessionManager *)sharedAFManager
{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        manager.requestSerializer.timeoutInterval= 30;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                                  @"text/html",
                                                                                  @"text/json",
                                                                                  @"text/plain",
                                                                                  @"text/javascript",
                                                                                  @"text/xml",
                                                                                  @"image/*"]];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    });
    return manager;
}



#pragma mark - 带缓存、hud、网络判断的
+ (SFURLSessionTask *)baseRequestType:(httpMethod)type url:(NSString *)url params:(NSDictionary *)params cache:(SFResponseCache)responseCache success:(SFResponseSuccess)success fail:(SFResponseFail)fail showHUD:(BOOL)showHUD toShowView:(UIView *)showView
{
    
    if (url == nil) {
        return nil;
    }
 
    
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    SFURLSessionTask *sessionTask=nil;
    
    if (type== GET) {
        
        //读取缓存
        responseCache ? responseCache([SFNetworkCache httpCacheForURL:urlStr parameters:params]) : nil;
        
//        if (![self isHaveNetwork]) {
//            [MBProgressHUD showAutoMessage:notNetTitle ToView:[UIApplication sharedApplication].getCurrentViewConttoller.view];
//            return nil;
//        }
        
        
        if (showHUD == YES && [self isHaveNetwork]) {
            [MBProgressHUD showLoadToView:showView];
        }
    
        sessionTask = [[self sharedAFManager] GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (success) {
                
                success(responseObject);
            }
            
            //对数据进行异步缓存
            responseCache ? [SFNetworkCache setHttpCache:responseObject URL:urlStr parameters:params] : nil;
            
            [[self tasks] removeObject:sessionTask];
            
            if (showHUD==YES) {
                
                [MBProgressHUD hideHUDForView:showView];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (fail) {
                fail(error);
            }
            kAppLog(@"%@",error);
            [[self tasks] removeObject:sessionTask];
            
            if (showHUD==YES) {
                
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                    
                   // sleep(1.0);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [MBProgressHUD hideHUDForView:showView];
                    });
                });
            }
            
        }];
        
    }else{
        
        //读取缓存
        responseCache ? responseCache([SFNetworkCache httpCacheForURL:urlStr parameters:params]) : nil;
        
        if (![self isHaveNetwork]) {//无网络
             [MBProgressHUD showAutoMessage:notNetTitle ToView:[UIApplication sharedApplication].getCurrentViewConttoller.view];
            return nil;
        }
        
        if (showHUD == YES && [self isHaveNetwork]) {
            [MBProgressHUD showLoadToView:showView];
        }
        
        
        sessionTask = [[self sharedAFManager] POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (success) {
                success(responseObject);
            }
            
            //对数据进行异步缓存
            responseCache ? [SFNetworkCache setHttpCache:responseObject URL:urlStr parameters:params] : nil;
            
            [[self tasks] removeObject:sessionTask];
            
            if (showHUD==YES) {
                
                [MBProgressHUD hideHUDForView:showView];
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (fail) {
                fail(error);
            }
            
            [[self tasks] removeObject:sessionTask];
            
            if (showHUD==YES) {
                
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                    
                   // sleep(1.0);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [MBProgressHUD hideHUDForView:showView];
                    });
                });
                
            }
            
        }];
        
    }
    
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }

    
    
    return sessionTask;
}

+(SFURLSessionTask *)getOrPostWithType:(httpMethod)httpMethod WithUrl:(NSString *)url params:(NSDictionary *)params cache:(SFResponseCache)responseCache success:(SFResponseSuccess)success fail:(SFResponseFail)fail showHUD:(BOOL)showHUD toShowView:(UIView *)showView{
    
    return [self baseRequestType:httpMethod url:url params:params cache:responseCache success:success fail:fail showHUD:showHUD toShowView:showView];
    
}




#pragma mark - 带缓存、无网络状态判断 POST请求
+ (void)postWithUrl:(NSString *)urlString parameters:(id)parameters resultBlock:(ResultBlock)requestBlock cacheBlock:(ResultBlock)cacheBlock hud:(BOOL)isShowHud toShowView:(UIView *)showView
{
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:urlString]?urlString:[self strUTF8Encoding:urlString];
    
    if (isShowHud) {
        [MBProgressHUD showLoadToView:showView];
    }
    
    id response = [SFNetworkCache httpCacheForURL:urlStr parameters:parameters];
    if (cacheBlock) {
        response ? cacheBlock(response,nil):cacheBlock(nil,nil);
    }
    
    [[self sharedAFManager] POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            [SFNetworkCache setHttpCache:responseObject URL:urlStr parameters:parameters];
        }else{
            requestBlock(nil,nil);
            kAppLog(@"返回空对象");
            return ;
        }
        
        
        if (requestBlock) {
            requestBlock(responseObject,nil);
        }
        
        if (isShowHud) {
            [MBProgressHUD hideHUDForView:showView];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestBlock) {
            requestBlock(nil,error);
        }
        
        if (isShowHud) {
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                     [MBProgressHUD hideHUDForView:showView];
                });
            });
        }
        
        kAppLog(@"请求错误==> %@",error);
    }];
    
}



#pragma mark - 无缓存POST请求
+ (void)postWithUrl:(NSString *)urlString parameters:(id)parameters result:(ResultBlock)requestBlock hud:(BOOL)isShowHud toShowView:(UIView *)showView
{
    if (isShowHud) {
         [MBProgressHUD showLoadToView:showView];
    }
    [[self sharedAFManager] POST:urlString parameters:parameters progress:nil
                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                             if (requestBlock) {
                                 requestBlock(responseObject,nil);
                             }
                             
                             
                             if (isShowHud) {
                                 [MBProgressHUD hideHUDForView:showView];
                             }
                             
                         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                             if (requestBlock) {
                                 requestBlock(nil,error);
                             }
                             
                             if (isShowHud) {
                                 dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                                     
                                     //sleep(1.0);
                                     
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         
                                         [MBProgressHUD hideHUDForView:showView];
                                     });
                                 });
                                 
                             }
                         }];
}



#pragma mark - 最基本的POST请求
+ (void)postWithUrl:(NSString *)urlString parameters:(id)parameters result:(ResultBlock)requestBlock
{
    
    [[self sharedAFManager] POST:urlString parameters:parameters progress:nil
                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                             if (requestBlock) {
                                 requestBlock(responseObject,nil);
                             }
                         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                             if (requestBlock) {
                                 requestBlock(nil,error);
                             }
                         }];
}





#pragma mark - 带缓存、无网络状态判断 GET请求
+ (void)getWithUrl:(NSString *)urlString parameters:(id)parameters resultBlock:(ResultBlock)requestBlock cacheBlock:(ResultBlock)cacheBlock hud:(BOOL)isShowHud toShowView:(UIView *)showView
{
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:urlString]?urlString:[self strUTF8Encoding:urlString];
    
    if (isShowHud) {
        [MBProgressHUD showLoadToView:showView];
    }
    
    //读取缓存
    id response = [SFNetworkCache httpCacheForURL:urlStr parameters:parameters];
    if (cacheBlock) {
        response ? cacheBlock(response,nil):cacheBlock(nil,nil);
    }
    
    [[self sharedAFManager] GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            [SFNetworkCache setHttpCache:responseObject URL:urlStr parameters:parameters];
        }else{
            requestBlock(nil,nil);
            kAppLog(@"返回空对象");
            return ;
        }
        
        
        if (requestBlock) {
            requestBlock(responseObject,nil);
        }
        
        if (isShowHud) {
            [MBProgressHUD hideHUDForView:showView];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestBlock) {
            requestBlock(nil,error);
        }
        
        if (isShowHud) {
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:showView];
                });
            });
        }
        
        kAppLog(@"请求错误==> %@",error);
    }];
    
}


#pragma mark - 无缓存GET请求
+ (void)getWithUrl:(NSString *)urlString parameters:(id)parameters result:(ResultBlock)requestBlock hud:(BOOL)isShowHud toShowView:(UIView *)showView
{
    if (isShowHud) {
        [MBProgressHUD showLoadToView:showView];
    }
    [[self sharedAFManager] GET:urlString parameters:parameters progress:nil
                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                             if (requestBlock) {
                                 requestBlock(responseObject,nil);
                             }
                             
                             
                             if (isShowHud) {
                                 [MBProgressHUD hideHUDForView:showView];
                             }
                             
                         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                             if (requestBlock) {
                                 requestBlock(nil,error);
                             }
                             
                             if (isShowHud) {
                                 dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                                     
                                     //sleep(1.0);
                                     
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         
                                         [MBProgressHUD hideHUDForView:showView];
                                     });
                                 });
                                 
                             }
                         }];
}



+ (void)getWithUrl:(NSString *)urlString parameters:(id)parameters result:(ResultBlock)requestBlock
{
    [[self sharedAFManager] GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (requestBlock) {
            requestBlock(responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestBlock) {
            requestBlock(nil,error);
        }
    }];
}


#pragma mark -上传
+ (SFURLSessionTask *)uploadWithImages:(NSArray *)imageArr url:(NSString *)url filename:(NSString *)filename names:(NSArray *)nameArr params:(NSDictionary *)params loadingImageArr:(NSMutableArray *)loadingImageArr toShowView:(UIView *)showView progress:(SFUploadProgress)progress success:(SFResponseSuccess)success fail:(SFResponseFail)fail showHUD:(BOOL)showHUD {
    
    
    if (url==nil) {
        return nil;
    }
    
    if (showHUD==YES) {
        
        [MBProgressHUD showHUDWithImageArr:loadingImageArr andShowView:showView];
    }
    
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    
    
    SFURLSessionTask *sessionTask = [[self sharedAFManager] POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < imageArr.count; i ++) {
            
            UIImage *image = (UIImage *)imageArr[i];
            
            NSData *imageData = UIImageJPEGRepresentation(image,1.0);
            
            NSString *imageFileName = filename;
            if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                imageFileName = [NSString stringWithFormat:@"%@.png", str];
            }
            
            NSString *nameString = (NSString *)nameArr[i];
            
            [formData appendPartWithFileData:imageData name:nameString fileName:imageFileName mimeType:@"image/jpg"];
            
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        SFLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        
        if (progress) {
            
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
            
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
        [[self tasks] removeObject:sessionTask];
        
        if (showHUD==YES) {
            
            [MBProgressHUD dissmissShowView:showView];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (fail) {
            fail(error);
        }
        
        [[self tasks] removeObject:sessionTask];
        
        if (showHUD==YES) {
            
            [MBProgressHUD dissmissShowView:showView];
        }
        
    }];
    
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
    
}


#pragma mark -下载
+ (SFURLSessionTask *)downloadWithUrl:(NSString *)url saveToPath:(NSString *)saveToPath loadingImageArr:(NSMutableArray *)loadingImageArr progress:(SFDownloadProgress )progressBlock toShowView:(UIView *)showView success:(SFResponseSuccess )success failure:(SFResponseFail )fail showHUD:(BOOL)showHUD{
    
    if (url==nil) {
        return nil;
    }
    
    if (showHUD==YES) {
        
        [MBProgressHUD showHUDWithImageArr:loadingImageArr andShowView:showView];
        
    }
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    SFURLSessionTask *sessionTask = nil;
    
    sessionTask = [[self sharedAFManager] downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        
        SFLog(@"下载进度--%.1f",1.0 * downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progressBlock) {
                
                progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (!saveToPath) {
            
            NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            
            SFLog(@"默认路径--%@",downloadURL);
            
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
            
        }else{
            
            return [NSURL fileURLWithPath:saveToPath];
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [[self tasks] removeObject:sessionTask];
        
        if (error == nil) {
            
            if (success) {
                success([filePath path]);//返回完整路径
            }
            
        } else {
            
            if (fail) {
                
                fail(error);
                
            }
        }
        
        if (showHUD==YES) {
            
            [MBProgressHUD dissmissShowView:showView];
        }
        
    }];
    
    //开始下载
    [sessionTask resume];
    //
    if (sessionTask) {
        
        [[self tasks] addObject:sessionTask];
        
    }
    
    return sessionTask;
    
}

#pragma makr - 开始监听程序在运行中的网络连接变化
+ (void)startMonitoring
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                
                [SFNetworking sharedSFNetworking].networkStats=StatusUnknown;
                kAppLog(@"未知网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                
                [SFNetworking sharedSFNetworking].networkStats=StatusNotReachable;
                [MBProgressHUD showAutoMessage:@"当前网络连接失败，请查看设置"];
                kAppLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                
                [SFNetworking sharedSFNetworking].networkStats=StatusReachableViaWWAN;
                kAppLog(@"手机自带网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                
                [SFNetworking sharedSFNetworking].networkStats=StatusReachableViaWiFi;
                kAppLog(@"WIFI");
                break;
        }
    }];
    
    [mgr startMonitoring];
}

+ (NetworkStatu)checkNetStatus {
    
    [self startMonitoring];
    
    if ([SFNetworking sharedSFNetworking].networkStats == StatusReachableViaWiFi) {
        
        return StatusReachableViaWiFi;
        
    } else if ([SFNetworking sharedSFNetworking].networkStats == StatusNotReachable) {
        
        return StatusNotReachable;
        
    } else if ([SFNetworking sharedSFNetworking].networkStats == StatusReachableViaWWAN) {
        
        return StatusReachableViaWWAN;
        
    } else {
        
        return StatusUnknown;
        
    }
    
}


+ (BOOL)isHaveNetwork {
    
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    if ([conn currentReachabilityStatus] == NotReachable) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}




+ (NSString *)strUTF8Encoding:(NSString *)str{
    
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}




- (void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
   
}
@end

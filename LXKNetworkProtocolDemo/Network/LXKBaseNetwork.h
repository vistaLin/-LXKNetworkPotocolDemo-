//
//  LXKBaseNetwork.h
//  JiaJiaBusiness
//
//  Created by Lennon on 2017/6/20.
//  Copyright © 2017年 Lennon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef NS_ENUM(NSUInteger, LXKBaseNetworkHttpRequestType) {
    LXKBaseNetworkHttpRequestTypeGet, // GET请求
    LXKBaseNetworkHttpRequestTypePost, // POST请求
};


/**
 网络请求成功的block
 
 @param response 请求成功返回的数据
 */
typedef void(^LXKResponseSuccess)(id response);


/**
 网络请求失败的block

 @param error 返回NSError
 */
typedef void(^LXKResponseFail)(NSError *error);


/**
 网络上传进度的block

 @param bytesProgress 已经上传了的进度
 @param totalBytesProgress  总共的字节数
 */
typedef void(^LXKUploadProgress)(int64_t bytesProgress,
                                 int64_t totalBytesProgress);


/**
 网络下载进度block

 @param bytesProgress 下载的进度
 @param totalBytesProgress 总共的字节数
 */
typedef void(^LXKDownloadProgress)(int64_t bytesProgress,
                                   int64_t totalBytesProgress);

@interface LXKBaseNetwork : AFHTTPSessionManager

//单例
+ (LXKBaseNetwork *)sharedManager;

/**
 网络请求方法,block回调

 @param requestType 请求的类型 get/post
 @param urlString 请求的url地址
 @param paramaters 请求的参数
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progressBlock 进度的回调
 */
+ (void)LXKBaseNetworkRequestType:(LXKBaseNetworkHttpRequestType)requestType
                        URLString:(NSString *)urlString
                       parameters:(NSDictionary *)paramaters
                     successBlock:(LXKResponseSuccess)successBlock
                     failureBlock:(LXKResponseFail)failureBlock
                         progress:(LXKDownloadProgress)progressBlock;


/**
 多图的请求方式 为JPG格式 并且压缩到0.4

 @param requestType 请求的类型
 @param urlString 请求的URL地址
 @param paramaters 请求的参数
 @param imageArray 请求的图片数组
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progressBlock 上传的进度
 */
+ (void)LXKBaseNetworkPostImagesRequestType:(LXKBaseNetworkHttpRequestType)requestType
                                  URLString:(NSString *)urlString
                                 parameters:(NSDictionary *)paramaters
                                imagesArray:(NSArray <UIImage *> *)imageArray
                               successBlock:(LXKResponseSuccess)successBlock
                               failureBlock:(LXKResponseFail)failureBlock
                                   progress:(LXKDownloadProgress)progressBlock;

@end

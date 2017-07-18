//
//  LXKBaseNetwork.m
//  JiaJiaBusiness
//
//  Created by Lennon on 2017/6/20.
//  Copyright © 2017年 Lennon. All rights reserved.
//

#import "LXKBaseNetwork.h"

@implementation LXKBaseNetwork

//单例
+ (LXKBaseNetwork *)sharedManager {
    
    
    static LXKBaseNetwork *handle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [LXKBaseNetwork manager];
        // 设置可接受的类型
        handle.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html",nil];
        handle.requestSerializer.timeoutInterval = 30.f;
        handle.responseSerializer = [AFJSONResponseSerializer serializer];
        // 会去掉返回的空值
        [AFJSONResponseSerializer serializer].removesKeysWithNullValues = YES;
    });
    
    return handle;
}


+ (void)LXKBaseNetworkRequestType:(LXKBaseNetworkHttpRequestType)requestType URLString:(NSString *)urlString parameters:(NSDictionary *)paramaters successBlock:(LXKResponseSuccess)successBlock failureBlock:(LXKResponseFail)failureBlock progress:(LXKDownloadProgress)progressBlock {
    if (!urlString || urlString.length == 0) {
        NSLog(@"请求的URL 为空");
        return;
    }
    if ([NSURL URLWithString:urlString] == nil) {
        NSLog(@"URLString无效,无法生成URL,可能是URL有中文,请尝试Encode URL");
        return;
    }
    NSLog(@"parameters ====== %@",paramaters);
    LXKBaseNetwork *manager = [LXKBaseNetwork sharedManager];
    switch (requestType) {
        case LXKBaseNetworkHttpRequestTypeGet: {
            [manager GET:urlString parameters:paramaters progress:^(NSProgress * _Nonnull downloadProgress) {
                if (progressBlock) {
                    progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
            }];
        }
            break;
        case LXKBaseNetworkHttpRequestTypePost: {
            [manager POST:urlString parameters:paramaters progress:^(NSProgress * _Nonnull uploadProgress) {
                if (progressBlock) {
                    progressBlock(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                successBlock(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureBlock(error);
            }];
        }
            
        default:
            break;
    }
}

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
                                   progress:(LXKDownloadProgress)progressBlock {
    if (!urlString || urlString.length == 0) {
        NSLog(@"请求的URL 为空");
        return;
    }
    if ([NSURL URLWithString:urlString] == nil) {
        NSLog(@"URLString无效,无法生成URL,可能是URL有中文,请尝试Encode URL");
        return;
    }
    NSLog(@"URL ====== %@",urlString);
    NSLog(@"parameters ====== %@",paramaters);
    LXKBaseNetwork *manager = [LXKBaseNetwork sharedManager];
    [manager POST:urlString parameters:paramaters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // 通过UUID生成一个全局唯一的文件名
        NSString *filename = [NSString stringWithFormat:@"%@.png", [NSUUID UUID].UUIDString];
        for (NSUInteger i = 0, count = imageArray.count; i < count; i++) {
            
            UIImage *image = imageArray[i];
            // 将UIImage对象转成NSData对象(二进制数据)
            // 强制转为PNG 但是没有了压缩
            //NSData *data = UIImagePNGRepresentation(image);
            NSData *data =  UIImageJPEGRepresentation(image, 0.4);
            // 第一个参数: 上传的二进制数据
            // 第二个参数: 上传文件对应的参数名(通过查API手册获得, 这个的问问后台的)
            // 第三个参数: 上传文件的文件名(这个名字通常没用, 因为服务器通常会用自己的命名规则给上传的文件起名字来避免名字冲突)
            // 第四个参数: MIME类型(告知服务器上传的文件的类型) 使用jpg的有损压缩 png是无损压缩
            [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"photo[%lu]",(unsigned long)i] fileName:filename mimeType:@"image/jpg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {
            progressBlock(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];

}

@end

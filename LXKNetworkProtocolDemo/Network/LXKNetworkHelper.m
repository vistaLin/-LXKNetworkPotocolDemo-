//
//  LXKNetwokHelper.m
//  JiaJiaBusiness
//
//  Created by Lennon on 2017/6/20.
//  Copyright © 2017年 Lennon. All rights reserved.
//

#import "LXKNetworkHelper.h"
#import "LXKBaseNetwork.h"
#import "LXKNetworkModel.h"

// 测试服务器地址前缀
#define API_PREFIX  @"里面是服务器的前缀"

@implementation LXKNetworkHelper

- (void)LXKNetwokHelperRequestType:(LXKNetworkHelperRequestType)requestType parameterDictionary:(NSDictionary *)parameterDictionary {
    LXKNetworkModel *tempModel = [LXKNetworkHelper networkModelFromRequestType:requestType];
    // 封装的提示框 我获取的是当前的view,在网络加载的时候也可以返回并且取消了协议
//    MBProgressHUD *hud;
//    if (_isShowLoading) {
//        if (_showHUDTitle && _showHUDTitle.length > 0) {
//            hud = [MBProgressHUD showHUDAddedTo:nil title:_showHUDTitle];
//        } else {
//            hud = [MBProgressHUD showHUD];
//        }
//    }
    NSLog(@"urlString === %@",tempModel.urlString);
    [LXKBaseNetwork LXKBaseNetworkRequestType:tempModel.requestType URLString:tempModel.urlString parameters:parameterDictionary successBlock:^(id response) {
        NSLog(@"responseObject === %@",response);
        [self successResponseObject:response requestType:requestType];
//        [hud hidden];
        
    } failureBlock:^(NSError *error) {
        NSLog(@"网络错误");
        [self failerResponseError:error requestType:requestType];
//        [hud hidden];
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        NSLog(@"progress = %lld",bytesProgress);
        NSLog(@"totalBytesProgress = %lld",totalBytesProgress);
    }];
}

/**
 上传多图的方式 同时我们是支持单图上传
 
 @param requestType 请求的类型
 @param parameterDictionary 请求的参数字典
 @param imageArray 不可变的图片数组
 */
- (void)LXKNetwokHelperPostImagesRequestType:(LXKNetworkHelperRequestType)requestType
                         parameterDictionary:(NSDictionary *)parameterDictionary
                                  imageArray:(NSArray <UIImage *> *)imageArray {
    
    LXKNetworkModel *tempModel = [LXKNetworkHelper networkModelFromRequestType:requestType];
//    MBProgressHUD *hud;
//    if (_isShowLoading) {
//        if (_showHUDTitle && _showHUDTitle.length > 0) {
//            hud = [MBProgressHUD showHUDAddedTo:nil title:_showHUDTitle];
//        } else {
//            hud = [MBProgressHUD showHUDAddedTo:nil title:@"图片上传中"];
//        }
//    }
    NSLog(@"urlString === %@",tempModel.urlString);
    [LXKBaseNetwork LXKBaseNetworkPostImagesRequestType:tempModel.requestType URLString:tempModel.urlString parameters:parameterDictionary imagesArray:imageArray successBlock:^(id response) {
        NSLog(@"responseObject === %@",response);
        [self successResponseObject:response requestType:requestType];
//        [hud hideTitle:@"图片上传成功"];
        
    } failureBlock:^(NSError *error) {
        NSLog(@"网络错误");
        [self failerResponseError:error requestType:requestType];
//        [hud hideTitle:@"图片上传失败"];
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        NSLog(@"progress = %lld",bytesProgress);
        NSLog(@"totalBytesProgress = %lld",totalBytesProgress);
    }];
}

#pragma mark - Private

// 请求成功
- (void)successResponseObject:(id)response requestType:(LXKNetworkHelperRequestType)requestType{
    int status = [response[@"status"] intValue];
    if ([_networkDelegate conformsToProtocol:@protocol(LXKNetworkProtocol)]) {
        if (status == 1) {
            [_networkDelegate LXKNetworkProtocolCompleteResponsObject:response requestType:requestType];
        } else {
            [_networkDelegate LXKNetworkProtocoleStateIsAbnormalCompleteResponseObject:response requestType:requestType];
        }
        
    }
}

// 请求失败的
- (void)failerResponseError:(NSError *)error requestType:(LXKNetworkHelperRequestType)requestType {
    if ([_networkDelegate conformsToProtocol:@protocol(LXKNetworkProtocol)]) {
        [_networkDelegate LXKNetworkProtocoleFailerCompleteError:error requestType:requestType];
    }
}

+ (LXKNetworkModel *)networkModelFromRequestType:(LXKNetworkHelperRequestType)requestTyep {
    LXKNetworkModel *model = [[LXKNetworkModel alloc] init];
    // 默认都是POST
    model.requestType = LXKBaseNetworkHttpRequestTypePost;
    NSString *urlStirng;
    switch (requestTyep) {
        case LXKNetworkHelperRequestTypeGetToken: {
            urlStirng = @"Token/get";
            model.requestType = LXKBaseNetworkHttpRequestTypeGet;
        }
            break;
        case LXKNetworkHelperRequestTypeLogin: {
            urlStirng = @"Business/login";
        }
            break;
        default:
            break;
    }
    model.urlString = [NSString stringWithFormat:@"%@%@",API_PREFIX, urlStirng];
    return model;
}

+ (void)cancelAllRequest {
    [[LXKBaseNetwork sharedManager].operationQueue cancelAllOperations ];
}

@end

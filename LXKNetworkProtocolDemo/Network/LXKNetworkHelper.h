//
//  LXKNetwokHelper.h
//  JiaJiaBusiness
//
//  Created by Lennon on 2017/6/20.
//  Copyright © 2017年 Lennon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXKNetworkProtocol.h"


@interface LXKNetworkHelper : NSObject

@property (nonatomic, weak) id <LXKNetworkProtocol> networkDelegate;

/**
 是否展示加载
 */
@property (nonatomic, assign) BOOL isShowLoading;

/**
 加载的时候的提示
 */
@property (nonatomic, copy) NSString *showHUDTitle;


/**
 网络请求get/post

 @param requestType 请求的方式
 @param parameterDictionary 请求的数据
 */
- (void)LXKNetwokHelperRequestType:(LXKNetworkHelperRequestType)requestType
               parameterDictionary:(NSDictionary *)parameterDictionary;



/**
 上传多图的方式 同时我们是支持单图上传

 @param requestType 请求的类型
 @param parameterDictionary 请求的参数字典
 @param imageArray 不可变的图片数组
 */
- (void)LXKNetwokHelperPostImagesRequestType:(LXKNetworkHelperRequestType)requestType
               parameterDictionary:(NSDictionary *)parameterDictionary
                        imageArray:(NSArray <UIImage *> *)imageArray;

/**取消所有的网络*/
+ (void)cancelAllRequest;


@end

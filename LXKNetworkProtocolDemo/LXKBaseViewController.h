//
//  ViewController.h
//  LXKNetworkProtocolDemo
//
//  Created by Lennon on 2017/7/18.
//  Copyright © 2017年 Lennon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LXKNetworkHelper.h"

typedef NS_ENUM(NSUInteger, LXKBaseViewControllerLoadingType) {
    LXKBaseViewControllerLoadingTypeDefault, // 默认加载中
    LXKBaseViewControllerLoadingTypeHidden, //隐藏
};

@interface LXKBaseViewController : UIViewController <LXKNetworkProtocol>

/**
 是否展示加载中 默认展示
 */
@property (nonatomic, assign) LXKBaseViewControllerLoadingType loadingType;

/**
 get或者post请求或上传数据
 
 @param requestType 请求的接口类型
 @param parameterDictionary 参数数据模型
 */
- (void)requestType:(LXKNetworkHelperRequestType)requestType parameterDictionary:(NSDictionary *)parameterDictionary;


/**
 上传多图 同时也支持单图
 
 @param requestType 请求的接口类型
 @param parameterDictionary 请求的参数数据模型
 @param imageArray 上传的图片数据
 */
- (void)postImagesRequestType:(LXKNetworkHelperRequestType)requestType
          parameterDictionary:(NSDictionary *)parameterDictionary
                   imageArray:(NSArray <UIImage *> *)imageArray;

/**
 上传多图和单图 参数接口都是死的 所以可以直接添加数组就可以了
 
 @param imageArray 图片数组
 */
- (void)postImageArray:(NSArray <UIImage *> *)imageArray;

/**
 错误码的提示 主要是给要状态码不唯一的时候的调用
 
 @param errorCode 错误码
 */
+ (void)showEerror:(NSInteger )errorCode;

@end



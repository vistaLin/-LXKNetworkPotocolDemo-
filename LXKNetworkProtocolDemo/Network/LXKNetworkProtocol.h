//
//  LXKNetworkProtocol.h
//  JiaJiaBusiness
//
//  Created by Lennon on 2017/6/20.
//  Copyright © 2017年 Lennon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LXKNetworkHelperRequestType) {
    LXKNetworkHelperRequestTypeGetToken = 1, // 获取token
    LXKNetworkHelperRequestTypeLogin,   // 登录
};

/**
 网络请求的协议
 */
@protocol LXKNetworkProtocol <NSObject>

@required


/**
 请求完成成功的协议 并且状态为1情况

 @param responseObject 请求成功的数据
 @param requestType 请求的类型
 */
- (void)LXKNetworkProtocolCompleteResponsObject:(id)responseObject
                                    requestType:(LXKNetworkHelperRequestType)requestType;


@optional

/**
 请求成功但是状态异常的协议

 @param responseObject 状态不唯一的数据
 @param requestType 请求的类型
 */
- (void)LXKNetworkProtocoleStateIsAbnormalCompleteResponseObject:(id)responseObject
                                                     requestType:(LXKNetworkHelperRequestType)requestType;

/**
 请求失败
 
 @param error 请求失败
 @param requestType 请求的类型
 */
- (void)LXKNetworkProtocoleFailerCompleteError:(NSError *)error
                                                     requestType:(LXKNetworkHelperRequestType)requestType;

@end

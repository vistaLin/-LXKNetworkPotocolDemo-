//
//  LXKNetworkModel.h
//  JiaJiaBusiness
//
//  Created by Lennon on 2017/6/20.
//  Copyright © 2017年 Lennon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXKBaseNetwork.h"

@interface LXKNetworkModel : NSObject


/**
 URL请求地址
 */
@property (nonatomic, copy) NSString *urlString;

/**
 请求的类型 也用于请求的标志 知道是哪一个请求
 */
@property (nonatomic, assign) LXKBaseNetworkHttpRequestType requestType;

@end

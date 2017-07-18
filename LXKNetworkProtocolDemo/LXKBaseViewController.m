//
//  ViewController.m
//  LXKNetworkProtocolDemo
//
//  Created by Lennon on 2017/7/18.
//  Copyright © 2017年 Lennon. All rights reserved.
//

#import "LXKBaseViewController.h"

@interface LXKBaseViewController ()

@property (nonatomic, strong) LXKNetworkHelper *networkHelper;

@end

@implementation LXKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (LXKNetworkHelper *)networkHelper {
    if (!_networkHelper) {
        _networkHelper = [[LXKNetworkHelper alloc] init];
        _networkHelper.isShowLoading = YES;
        _networkHelper.networkDelegate = self;
    }
    return _networkHelper;
}


- (void)setLoadingType:(LXKBaseViewControllerLoadingType)loadingType {
    _loadingType = loadingType;
    if (_loadingType == LXKBaseViewControllerLoadingTypeHidden) {
        self.networkHelper.isShowLoading = NO;
    } else {
        self.networkHelper.isShowLoading = YES;
    }
}

- (void)requestType:(LXKNetworkHelperRequestType)requestType parameterDictionary:(NSDictionary *)parameterDictionary {
    
    [self.networkHelper LXKNetwokHelperRequestType:requestType parameterDictionary:parameterDictionary];
}

/**
 上传多图 同时也支持单图
 
 @param requestType 请求的接口类型
 @param parameterDictionary 请求的参数数据模型
 @param imageArray 上传的图片数据
 */
- (void)postImagesRequestType:(LXKNetworkHelperRequestType)requestType
          parameterDictionary:(NSDictionary *)parameterDictionary
                   imageArray:(NSArray <UIImage *> *)imageArray {
    [self.networkHelper LXKNetwokHelperPostImagesRequestType:requestType parameterDictionary:parameterDictionary imageArray:imageArray];
}


// 上传多图
- (void)postImageArray:(NSArray<UIImage *> *)imageArray {
//    [self postImagesRequestType:LXKNetworkHelperRequestTypeUpPhoto parameterDictionary:@{@"tokne" : TOKEN} imageArray:imageArray];
}

#pragma mark - LXKNetworkProtocol

- (void)LXKNetworkProtocolCompleteResponsObject:(id)responseObject requestType:(LXKNetworkHelperRequestType)requestType {
    
}

- (void)LXKNetworkProtocoleStateIsAbnormalCompleteResponseObject:(id)responseObject requestType:(LXKNetworkHelperRequestType)requestType {
    [LXKBaseViewController showEerror:[responseObject[@"status"] integerValue]];
}

- (void)LXKNetworkProtocoleFailerCompleteError:(NSError *)error requestType:(LXKNetworkHelperRequestType)requestType {
    //MB_Show_Message(@"网络状态差");
}

#pragma mark - 错误的提示
+ (void)showEerror:(NSInteger )errorCode {
    switch (errorCode) {
        case 1000: {
            NSLog(@"未传入TOKEN");
        }
            break;
        case 1001: {
            NSLog(@"TOKEN过期或者不合法");
        }
            break;
        case 1002: {
            NSLog(@"获取token参数未传入");
        }
            break;
        case 1003: {
         //   MB_Show_Message(@"未知错误");
        }
            break;
        case 2001: {
        //    MB_Show_Message(@"第三方登录类型未知");
        }
            break;
            
        case 2002: {
         //   MB_Show_Message(@"您还未注册");
        }
            break;
        default:
            break;
    }
    NSLog(@"非状态1下的 errorCode = %ld",errorCode);
}



@end

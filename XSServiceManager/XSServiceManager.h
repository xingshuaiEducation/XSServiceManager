//
//  XSServiceManager.h
//  testDemo
//
//  Created by suxx on 2017/6/23.
//  Copyright © 2017年 suxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Response;
@class Request;

@interface XSServiceManager : NSObject

/**
 监听网络状态的变化
 */
+(void)listenNetworkStatue;

/**
 网络post请求

 @param path 请求URL
 @param params 请求参数
 @param completion 完成回调 response(succeed=YES:成功 message:请求描述信息 data:返回的字典数据)
 */
+(void)post:(NSString*)path params:(NSDictionary<NSString*,id>*)params completion:(void(^)(Response* response))completion;

/**
 网络get请求
 
 @param path 请求URL
 @param params 请求参数
 @param completion 完成回调 response(succeed=YES:成功 message:请求描述信息 data:返回的字典数据)
 */
+(void)get:(NSString*)path params:(NSDictionary<NSString*,id>*)params completion:(void(^)(Response* response))completion;

/**
 网络get请求(参数里面带有字典)
 
 @param path 请求URL
 @param params 请求参数
 @param completion 完成回调 response(succeed=YES:成功 message:请求描述信息 data:返回的字典数据)
 */
+(void)get:(NSString*)path paramsDic:(NSDictionary<NSString*,id>*)params completion:(void(^)(Response* response))completion;


@end

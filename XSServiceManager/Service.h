//
//  Service.h
//  testDemo
//
//  Created by suxx on 2017/6/23.
//  Copyright © 2017年 suxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSServiceModel.h"
#import <AFNetworking.h>

@class Request;

@class Response;

@interface Service : NSObject

/**
 网络请求

 @param method 请求类型 POST/GET
 @param params 请求参数
 @param respS 响应头
 @param reqS 请求头
 @param completion 完成回调
 */
+(void)requestMethod:(NSString *)method path:(NSString*)path params:(NSDictionary<NSString*,id>*)params responseSerializer:(AFJSONResponseSerializer *)respS requestSerializer:(AFHTTPRequestSerializer *)reqS completion:(void(^)(NSDictionary *responseDic))completion;

/**
 网络get请求(参数带有字典)

 @param path 请求路径
 @param params 请求参数
 @param respS 响应头
 @param reqS 请求头
 @param completion 完成回调
 */
+(void)get:(NSString*)path paramsDic:(NSDictionary<NSString*,id>*)params responseSerializer:(AFJSONResponseSerializer *)respS requestSerializer:(AFHTTPRequestSerializer *)reqS completion:(void(^)(NSDictionary *responseDic))completion;

@end

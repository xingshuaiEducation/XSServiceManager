//
//  Service.m
//  testDemo
//
//  Created by suxx on 2017/6/23.
//  Copyright © 2017年 suxx. All rights reserved.
//

#import "Service.h"

@implementation Service

#pragma mark - Delegate

#pragma mark - Event Handle

#pragma mark - Private Method


#pragma mark - Public Method
+(void)requestMethod:(NSString *)method path:(NSString*)path params:(NSDictionary<NSString*,id>*)params responseSerializer:(AFJSONResponseSerializer *)respS requestSerializer:(AFHTTPRequestSerializer *)reqS completion:(void(^)(NSDictionary *responseDic))completion{
    Request *request = [[Request alloc] init];
    request.path = path;
    request.method = method;
    request.params = params;
    request.completion = completion;
    [self request:request responseSerializer:respS requestSerializer:reqS];
}

+(void)get:(NSString*)path paramsDic:(NSDictionary<NSString*,id>*)params responseSerializer:(AFJSONResponseSerializer *)respS requestSerializer:(AFHTTPRequestSerializer *)reqS completion:(void(^)(NSDictionary *responseDic))completion{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *urlStr = [NSString stringWithFormat:@"%@?requestJson=%@", path, jsonString];
    NSLog(@"requestUrl:%@", urlStr);
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    Request *request = [[Request alloc] init];
    request.path = urlStr;
    request.method = @"GET";
    request.params = nil;
    request.completion = completion;
    [self request:request responseSerializer:respS requestSerializer:reqS];
}

+(void)request:(Request *)request responseSerializer:(AFJSONResponseSerializer *)respSerializer requestSerializer:(AFHTTPRequestSerializer *)requestSerializer{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //是否支持HTTPS
    manager.securityPolicy.allowInvalidCertificates = YES;

    //设置请求头
    if (requestSerializer) {
        manager.requestSerializer = requestSerializer;
    }
    
    
    //设置响应头
    if (respSerializer) {
        manager.responseSerializer = respSerializer;
    }else{
        AFJSONResponseSerializer *resSer = [AFJSONResponseSerializer serializer];
        resSer.readingOptions = NSJSONReadingMutableContainers;
        resSer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", @"text/json", @"text/javascript", nil];
        manager.responseSerializer = resSer;
    }
    
    //请求成功
    void(^success)(NSURLSessionDataTask *,id) = ^(NSURLSessionDataTask *task, id responseObject){
        
        NSLog(@"\n收到响应：%zd\n%@\n%@",((NSHTTPURLResponse*)task.response).statusCode,request.path,responseObject);
        request.completion(responseObject);
        NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
        NSString *cookieString = response.allHeaderFields[@"Set-Cookie"];
        [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"Cookie"];

    };
    //请求失败
    void(^failure)(NSURLSessionDataTask *, NSError *) = ^(NSURLSessionDataTask *task, NSError *error){
        NSLog(@"\n收到失败的响应：%@\n结果：%zd",error.localizedDescription,((NSHTTPURLResponse*)task.response).statusCode);
        request.completion(nil);
        NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
        NSString *cookieString = response.allHeaderFields[@"Set-Cookie"];
        [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"Cookie"];
    };
    NSLog(@"\n开始请求：\nURL:\t%@\nMethod:\t%@\nParams:\t%@",request.path,request.method,request.params);
    
    manager.requestSerializer.timeoutInterval = 30.0f;
    
        //根据POST,GET动态调用manager下对应的方法
        NSString *method = [request.method uppercaseString];
        if ([method isEqualToString:@"POST"]) {
            [manager POST:request.path parameters:request.params progress:nil success:success failure:failure];
        }else if([method isEqualToString:@"PUT"]){
            [manager PUT:request.path parameters:request.params success:success failure:failure];
        }else if([method isEqualToString:@"DELETE"]){
            [manager DELETE:request.path parameters:request.params success:success failure:failure];
        }else if([method isEqualToString:@"GET"]){
            [manager GET:request.path parameters:request.params progress:nil success:success failure:failure];
        }
        
}

#pragma mark - Getter 和 Setter

@end

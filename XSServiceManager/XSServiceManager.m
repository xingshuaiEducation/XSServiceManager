//
//  XSServiceManager.m
//  testDemo
//
//  Created by suxx on 2017/6/23.
//  Copyright © 2017年 suxx. All rights reserved.
//

#import "XSServiceManager.h"
#import "Service.h"
#import <AFNetworking.h>
#import "XSServiceModel.h"

@implementation XSServiceManager

#pragma mark - Delegate

#pragma mark - Event Handle

#pragma mark - Private Method
//返回的数据的解析处理
+(void)parseResponsejson:(NSDictionary*)json completion:(void(^)(Response* response))completion{
    Response *res = [[Response alloc] init];
    if (json){
        res.result = json;
        res.data = json[@"data"];
        res.message = json[@"message"];
        if (!res.message) {
            res.message = @"出错了，并且没有错误信息";
        }
        if (json[@"error"]) {
            res.resultCode = [json[@"error"] integerValue];
            res.succeed = res.resultCode == 0;
        }else if(json[@"code"]){
            res.resultCode = [json[@"code"] integerValue];
            res.succeed = res.resultCode == 0;
        }else{
            res.resultCode = 9999;
            res.succeed = NO;
        }
    }else{
        res.result = nil;
        res.data = nil;
        res.resultCode = 9999;
        res.message = @"没有返回正确的数据";
        res.succeed = NO;
    }
    
    completion(res);
}

//设置响应头
+(AFJSONResponseSerializer *)setResponseSerializer{
    AFJSONResponseSerializer *resSer = [AFJSONResponseSerializer serializer];
    resSer.readingOptions = NSJSONReadingMutableContainers;
    resSer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", @"text/json", @"text/javascript", nil];
    
    return resSer;
}

//设置请求头
+(AFHTTPRequestSerializer *)setRequestSerializer{
    AFHTTPRequestSerializer *reqSer = [AFHTTPRequestSerializer serializer];
    
    reqSer.HTTPShouldHandleCookies = YES;
    NSString *cookie = [[NSUserDefaults standardUserDefaults] objectForKey:@"Cookie"];
    if (cookie) {
        [reqSer setValue:cookie forHTTPHeaderField:@"Cookie"];
        [reqSer setValue:[self getHttpUserAgent] forHTTPHeaderField:@"User-Agent"];
    }
    
    return reqSer;
}

+(NSString *)getHttpUserAgent
{
    NSString *appVertion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *devType = [[UIDevice currentDevice] model];
    NSString *sysVertion = [[UIDevice currentDevice] systemVersion];
    NSString *sysName = [[UIDevice currentDevice] systemName];
    NSString *model = [self doDevicePlatform]; //具体手机型号
    NSString *str = [NSString stringWithFormat:@"XSTeach/%@ (%@; %@ %@; %@) XSTeachENT/%@",@"1.0" ,devType,sysName,sysVertion,model, appVertion];
    return str;
}

//获得设备型号
+ (NSString*) doDevicePlatform
{
    size_t size;
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) {
        
        platform = @"iPhone";
        
    } else if ([platform isEqualToString:@"iPhone1,2"]) {
        
        platform = @"iPhone 3G";
        
    } else if ([platform isEqualToString:@"iPhone2,1"]) {
        
        platform = @"iPhone 3GS";
        
    } else if ([platform isEqualToString:@"iPhone3,1"]||[platform isEqualToString:@"iPhone3,2"]||[platform isEqualToString:@"iPhone3,3"]) {
        
        platform = @"iPhone 4";
        
    } else if ([platform isEqualToString:@"iPhone4,1"]) {
        
        platform = @"iPhone 4S";
        
    } else if ([platform isEqualToString:@"iPhone5,1"]||[platform isEqualToString:@"iPhone5,2"]) {
        
        platform = @"iPhone 5";
        
    }else if ([platform isEqualToString:@"iPhone5,3"]||[platform isEqualToString:@"iPhone5,4"]) {
        
        platform = @"iPhone 5C";
        
    }else if ([platform isEqualToString:@"iPhone6,2"]||[platform isEqualToString:@"iPhone6,1"]) {
        
        platform = @"iPhone 5S";
        
    } else if ([platform isEqualToString:@"iPhone8,4"]) {
        
        platform = @"iPhone SE";
        
    } else if ([platform isEqualToString:@"iPhone7,2"]) {
        return @"iPhone 6";
    }
    else if ([platform isEqualToString:@"iPhone7,1"])
    {
        return @"iPhone 6 Plus";
    }
    else if ([platform isEqualToString:@"iPhone8,1"])
    {
        return @"iPhone 6S";
    }
    else if ([platform isEqualToString:@"iPhone8,2"])
    {
        return @"iPhone 6S Plus";
    }
    else if ([platform isEqualToString:@"iPod4,1"]) {
        
        platform = @"iPod touch 4";
        
    }else if ([platform isEqualToString:@"iPod5,1"]) {
        
        platform = @"iPod touch 5";
        
    }else if ([platform isEqualToString:@"iPod3,1"]) {
        
        platform = @"iPod touch 3";
        
    }else if ([platform isEqualToString:@"iPod2,1"]) {
        
        platform = @"iPod touch 2";
        
    }else if ([platform isEqualToString:@"iPod1,1"]) {
        
        platform = @"iPod touch";
        
    } else if ([platform isEqualToString:@"iPad3,2"]||[platform isEqualToString:@"iPad3,1"]||[platform isEqualToString:@"iPad3,3"]) {
        
        platform = @"iPad 3";
        
    } else if ([platform isEqualToString:@"iPad2,2"]||[platform isEqualToString:@"iPad2,1"]||[platform isEqualToString:@"iPad2,3"]||[platform isEqualToString:@"iPad2,4"]) {
        
        platform = @"iPad 2";
        
    }else if ([platform isEqualToString:@"iPad1,1"]) {
        
        platform = @"iPad 1";
        
    }else if ([platform isEqualToString:@"iPad2,5"]||[platform isEqualToString:@"iPad2,6"]||[platform isEqualToString:@"iPad2,7"]||[platform isEqualToString:@"iPad4,5"]||[platform isEqualToString:@"iPad4,6"]||[platform isEqualToString:@"iPad4,4"]) {
        
        platform = @"iPad mini";
        
    } else if ([platform isEqualToString:@"iPad3,4"]||[platform isEqualToString:@"iPad3,5"]||[platform isEqualToString:@"iPad3,6"]) {
        
        platform = @"iPad 4";
        
    } else if ([platform isEqualToString:@"iPad4,1"]||[platform isEqualToString:@"iPad4,2"]||[platform isEqualToString:@"iPad4,3"]) {
        
        platform = @"iPad Air";
        
    }
    
    return platform;
}


#pragma mark - Public Method
+(void)listenNetworkStatue{
    AFNetworkReachabilityManager*manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //代码
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setInteger:status forKey:@"networkStatue"];
        [userDefaults synchronize];
    } ];
    
}
+(void)post:(NSString*)path params:(NSDictionary<NSString*,id>*)params completion:(void(^)(Response* response))completion{
    __weak typeof(self) weakSelf = self;
    
    [Service requestMethod:@"POST" path:path params:params responseSerializer:[self setResponseSerializer] requestSerializer:[self setRequestSerializer] completion:^(NSDictionary *responseDic) {
        [weakSelf parseResponsejson:responseDic completion:^(Response *response) {
            completion(response);
        } ];
    }];
}

+(void)get:(NSString*)path params:(NSDictionary<NSString*,id>*)params completion:(void(^)(Response* response))completion{
    __weak typeof(self) weakSelf = self;
    
    [Service requestMethod:@"GET" path:path params:params responseSerializer:[self setResponseSerializer] requestSerializer:[self setRequestSerializer] completion:^(NSDictionary *responseDic) {
        [weakSelf parseResponsejson:responseDic completion:^(Response *response) {
            completion(response);
        } ];
    }];
}

+(void)get:(NSString*)path paramsDic:(NSDictionary<NSString*,id>*)params completion:(void(^)(Response* response))completion{
    
}

#pragma mark - Getter 和 Setter

@end

//
//  XSServiceModel.h
//  testDemo
//
//  Created by suxx on 2017/6/23.
//  Copyright © 2017年 suxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Request;

@interface XSServiceModel : NSObject

@end


/***********************************/
@interface Response : NSObject

@property (strong,nonatomic) Request *request;
@property (assign,nonatomic) NSInteger resultCode;
@property (strong,nonatomic) NSString *message;
@property (assign,nonatomic) BOOL succeed;
@property (strong,nonatomic) id data;
@property (strong,nonatomic) NSDictionary<NSString*,id> *result;

@end

/**************************************/
@interface Request : NSObject

@property (strong,nonatomic) NSString *path;
@property (strong,nonatomic) NSString *method;
@property (strong,nonatomic) NSDictionary<NSString*,id> *params;
@property (strong,nonatomic) void(^completion)(NSDictionary*);

@end

//
//  UNHttpClient.h
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UNHttpRequest;
NS_ENUM(NSInteger, ErrorIndex)
{
    ERR_SERVER_NOPARAMETER =2001,//:参数有误
    ERR_SERVER_SQL = 2002,//: 数据库连接查询错误
    ERR_SIGN_PARAM_NONE = 2500,//没有认证参数
    ERR_SIGN_PAAM_SIGNTIMEOUT = 2501,//服务器认证失败
    
    ERR_CLIENT_CALLBACK = 3001,//：返回数据为nil
    ERR_CLIENT_JSONPARSE = 3002,//： json解析结果为nil
    ERR_CLIENT_HTTPERROR = 3003,//：http响应失败
    ERR_NOTREACHABLE = 3004,//：没有网络
    ERR_LOGINFAIL = 3005,//： 登录失败，返回验证码
    ERR_TOKENLOSE = 3006,//： token失效
    ERR_END
};

typedef void (^UNRequestCompletionBlock)(id response, NSError *errorMsg);

@interface UNHttpRequestHandler : NSObject

@property (nonatomic, strong)UNHttpRequest *request;

- (void)cancel;
- (instancetype)initWithRequest:(UNHttpRequest *)request;

@end


@interface UNHttpClient : NSObject

@property (nonatomic, strong)NSString* baseUrl;

+ (UNHttpClient*)sharedInstance;
+ (void) releaseSharedInstance;

- (void)setRequestHeader:(NSString*)val forKey:(NSString*)key;
- (UNHttpRequestHandler *)sendRequest:(UNHttpRequest*)request complete:(UNRequestCompletionBlock) block;
- (instancetype)initWithBaseUrl:(NSString*)baseUrl;

@end

















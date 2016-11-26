//
//  UNHttpClient.m
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UNHttpClient.h"
@import AFNetworking;
#import "UNHttpRequest.h"

static NSString * const cBASE_URL = @"https://api.app.net/";
#define HTTP_POST_TIMEOUT 30

@interface UNHttpRequestHandler()
@property (nonatomic, assign)BOOL isCanceled;
@end

@implementation UNHttpRequestHandler

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isCanceled = NO;
    }
    return self;
}

- (instancetype)initWithRequest:(UNHttpRequest *)request {
    self = [self init];
    if (self) {
        _request = request;
    }
    return self;
}

- (void)cancel {
    self.isCanceled = YES;
}

@end

@implementation UNHttpClient {
    AFHTTPSessionManager *_client;
}

static UNHttpClient *sClient;
static dispatch_once_t onceToken;
+(UNHttpClient*)sharedInstance {
    dispatch_once(&onceToken, ^{
        sClient = [[UNHttpClient alloc] init];
    });
    return sClient;
}

+ (void)releaseSharedInstance {
    sClient = nil;
    onceToken = 0;
}

-(void)setRequestHeader:(NSString*)val forKey:(NSString*)key {
    //TODO:需要测试 使用测试服务器时需要使用
    [_client setValue:val forKey:key];
}
- (instancetype)init {
    return [self initWithBaseUrl:cBASE_URL];
}
-(instancetype)initWithBaseUrl:(NSString *)baseUrl {
    self = [super init];
    if (self) {
        [self setBaseUrl:cBASE_URL];
    }
    return self;
}
- (void)setBaseUrl:(NSString *)baseUrl {
    _baseUrl = baseUrl;
    _client = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    _client.requestSerializer.timeoutInterval = HTTP_POST_TIMEOUT;
}

- (UNHttpRequestHandler *)sendRequest:(UNHttpRequest*)request complete:(UNRequestCompletionBlock) block
{
    NSDictionary *params = [request params];
    if (params && request.requestPath) {
        __block UNHttpRequestHandler *requestHandler = [[UNHttpRequestHandler alloc] initWithRequest:request];
        void(^successBlock)(NSURLSessionDataTask * _Nonnull, id  _Nullable) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable response) {
            if (requestHandler.isCanceled) {
                return;
            }
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                if ([response isKindOfClass:[NSData class]]) {
                    requestHandler.request.jsonData = response;
                    id jsonRsp = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:nil];
                    if ([requestHandler.request analysisData:jsonRsp]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            block(requestHandler.request.response, requestHandler.request.errorMes);
                            requestHandler = nil;
                        });
                        return;
                    }
                }
                requestHandler.request.response = response;
                if (!requestHandler.request.errorMes) {
                    requestHandler.request.errorMes = [[NSError alloc] initWithDomain:@"数据解析失败" code:ERR_CLIENT_JSONPARSE userInfo:response];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(nil, requestHandler.request.errorMes);
                    requestHandler = nil;
                });
            });
            
        };
        void (^failureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (requestHandler.isCanceled) {
                return;
            }
            NSLog(@"###error = %@", error);
            requestHandler.request.response = error;
            requestHandler.request.errorMes = error;
            block(nil, requestHandler.request.errorMes);
            requestHandler = nil;
        };
        NSString *requestPath = request.customUrl;
        if (requestPath.length < 7) {
            requestPath = request.requestPath;
        }
        //        NSString *method = @"POST";
        //        switch (request.requestType) {
        //            case MovieSDKHttpRequestType_Get:
        //                method = @"GET";
        //                break;
        //            case MovieSDKHttpRequestType_Post:
        //            default:
        //                break;
        //        }
        [_client POST:requestPath parameters:params progress:nil success:successBlock failure:failureBlock];
        return requestHandler;
    }
    //也应该通过block返回
    return nil;
}

@end
         
         
         
         




         
         
         

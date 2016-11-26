//
//  UNHttpRequest.h
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UNHttpClient.h"

typedef NS_ENUM(NSInteger, UNHttpRequestType) {
    UNHttpRequestType_Post = 0,
    UNHttpRequestType_Get,
};

@interface UNHttpRequest : NSObject

@property (nonatomic, assign)UNHttpRequestType requestType;
@property (nonatomic, readonly)NSString *requestPath;
@property (nonatomic, strong)NSString *customUrl; //使用时动态修改请求的接口地址

- (NSMutableDictionary*)params;
- (BOOL)analysisData:(id)responseObject;

@property (nonatomic, strong)id response;
@property (nonatomic, strong)NSError *errorMes;
@property (nonatomic, strong)NSData *jsonData;
- (void)writeToFile:(NSString*)path;
- (BOOL)readFromFile:(NSString*)path;

@end

//
//  UNHttpRequest.m
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UNHttpRequest.h"
#import "UIDevice+DTHelper.h"


@implementation UNHttpRequest

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSDictionary*)commonParams {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
//    MovieSDKLoginUserManager *loginManager = [MovieSDKLoginUserManager sharedManager];
//    [dict setObject:loginManager.userInfo.id_ forKey:@"uid"];
//    [dict setObject:loginManager.meInfo.token forKey:@"token"];
    NSString *appVer = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (appVer.length > 0) {
        [dict setObject:appVer forKey:@"v"];
    }
    [dict setObject:@"iOS" forKey:@"os_n"];
    if ([UIDevice currentDevice].systemVersion) {
        [dict setObject:[UIDevice currentDevice].systemVersion forKey:@"os_v"];
    }
    NSString *deviceModelName = [UIDevice dt_getDeviceModelName];
    if (deviceModelName.length > 0) {
        [dict setObject:deviceModelName forKey:@"d_n"];
    }
    NSString *ip = [UIDevice dt_deviceIPAdress];
    if (ip.length > 0) {
        [dict setObject:ip forKey:@"ip"];
    }
    return dict;
}

- (NSMutableDictionary*)params {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict addEntriesFromDictionary:[self commonParams]];
    return dict;
}

- (NSString*)requestPath {
    NSAssert(NO, @"子类必须实现这个函数以返回请求地址");
    return @"action/path";
}

- (BOOL)analysisData:(id)responseObject {
    if ([responseObject isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = responseObject;
        if ([dict objectForKey:@"status"] && ![[[dict objectForKey:@"status"] stringValue] isEqualToString:@"1"])
        {
            self.errorMes = [[NSError alloc] initWithDomain:[dict objectForKey:@"message"] code:[[[dict objectForKey:@"status"] stringValue] intValue] userInfo:responseObject];
        } else {
            self.response = [dict objectForKey:@"data"];
            return (_response != nil);
        }
    }
    return NO;
}
- (void)writeToFile:(NSString*)path {
    [self.jsonData writeToFile:path atomically:YES];
}
- (BOOL)readFromFile:(NSString*)path {
    self.jsonData = [NSData dataWithContentsOfFile:path];
    if (self.jsonData) {
        id response = [NSJSONSerialization JSONObjectWithData:self.jsonData options:NSJSONReadingAllowFragments error:nil];
        return [self analysisData:response];
    }
    return NO;
}

@end

//
//  UNWebView.m
//  uneed
//
//  Created by wudijimao on 16/11/24.
//  Copyright (c) 2016年 wudijimao. All rights reserved.
//

#import "UNWebView.h"


@implementation UNWebView
- (void)openUrl:(NSString*) url {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    [self loadRequest:request];
}
@end

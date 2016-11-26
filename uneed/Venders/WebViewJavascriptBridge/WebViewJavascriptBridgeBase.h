//
//  WebViewJavascriptBridgeBase.h
//
//  Created by @LokiMeyburg on 10/15/14.
//  Copyright (c) 2014 @LokiMeyburg. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCustomProtocolScheme @"wvjbscheme"
#define kQueueHasMessage      @"__WVJB_QUEUE_MESSAGE__"

typedef NS_ENUM(NSInteger, WVJBStatusCode) {
    WVJBStatusCode_OK = 0,
    WVJBStatusCode_MISSING_PARAMS = 1,
    WVJBStatusCode_ILLEGAL_ACCESS = 2,
    WVJBStatusCode_INTERNAL_ERROR = 3,
    WVJBStatusCode_NO_RESULT = 4,
    WVJBStatusCode_USER_CANCELLED = 5,
    WVJBStatusCode_SERVICE_FORBIDDEN = 6,
};

@interface WVJBResponse : NSObject
@property (nonatomic, strong)id data;
@property (nonatomic, assign)BOOL success;
@property (nonatomic, assign)WVJBStatusCode code;
- (NSDictionary*)getDict;
@end

typedef void (^WVJBResponseCallback)(WVJBResponse *responseData);
typedef void (^WVJBHandler)(id data, WVJBResponseCallback responseCallback);
typedef NSDictionary WVJBMessage;

@protocol WebViewJavascriptBridgeBaseDelegate <NSObject>
- (NSString*) _evaluateJavascript:(NSString*)javascriptCommand;
@end

@interface WebViewJavascriptBridgeBase : NSObject


@property (assign) id <WebViewJavascriptBridgeBaseDelegate> delegate;
@property (strong, nonatomic) NSMutableArray* startupMessageQueue;
@property (strong, nonatomic) NSMutableDictionary* responseCallbacks;
@property (strong, nonatomic) NSMutableDictionary* messageHandlers;
@property (strong, nonatomic) WVJBHandler messageHandler;
@property NSUInteger numRequestsLoading;

+ (void)enableLogging;
- (id)initWithHandler:(WVJBHandler)messageHandler resourceBundle:(NSBundle*)bundle;
- (void)reset;
- (void)sendData:(id)data responseCallback:(WVJBResponseCallback)responseCallback handlerName:(NSString*)handlerName;
- (void)flushMessageQueue:(NSString *)messageQueueString;
- (void)injectJavascriptFile:(BOOL)shouldInject;
- (BOOL)isCorrectProcotocolScheme:(NSURL*)url;
- (BOOL)isCorrectHost:(NSURL*)urll;
- (void)logUnkownMessage:(NSURL*)url;
- (void)dispatchStartUpMessageQueue;
- (NSString *)webViewJavascriptCheckCommand;
- (NSString *)webViewJavascriptFetchQueyCommand;

@end
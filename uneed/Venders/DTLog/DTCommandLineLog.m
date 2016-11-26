//
//  DTCommandLineLog.m
//  WeiboMovie
//
//  Created by ximiao on 15/8/3.
//  Copyright (c) 2015年 liuyue. All rights reserved.
//

#import "DTCommandLineLog.h"
#import "CommandLineColor.h"
#import <sys/uio.h>
#import <asl.h>

//@import Dispatch;

@implementation DTCommandLineLog {
    aslclient _client;
}
-(id)init {
    if ((self = [super init])) {
        // A default asl client is provided for the main thread,
        // but background threads need to create their own client.
        _client = asl_open(NULL, "com.apple.console", 0);
        _colorDictForOutput = [[NSMutableDictionary alloc] init];
        //Fatal
        [_colorDictForOutput setObject:[[CommandLineColor alloc] initWithForegroundColor:[UIColor whiteColor] backgroundColor:[UIColor redColor]] forKey:[NSNumber numberWithInteger:LogLevel_Fatal]];
        //Error
        [_colorDictForOutput setObject:[[CommandLineColor alloc] initWithForegroundColor:[UIColor redColor] backgroundColor:nil] forKey:[NSNumber numberWithInteger:LogLevel_Error]];
        //Warning
        [_colorDictForOutput setObject:[[CommandLineColor alloc] initWithForegroundColor:[UIColor colorWithRed:0.961f green:0.690f blue:0.043f alpha:1.00f] backgroundColor:nil] forKey:[NSNumber numberWithInteger:LogLevel_Warning]];
        //Info
        [_colorDictForOutput setObject:[[CommandLineColor alloc] initWithForegroundColor:[UIColor greenColor] backgroundColor:nil] forKey:[NSNumber numberWithInteger:LogLevel_Info]];
        //Debug
        [_colorDictForOutput setObject:[[CommandLineColor alloc] initWithForegroundColor:[UIColor whiteColor] backgroundColor:nil] forKey:[NSNumber numberWithInteger:LogLevel_Debug]];
        //Trace
        [_colorDictForOutput setObject:[[CommandLineColor alloc] initWithForegroundColor:[UIColor colorWithRed:0.467f green:0.467f blue:0.467f alpha:1.00f] backgroundColor:nil] forKey:[NSNumber numberWithInteger:LogLevel_Trace]];
    }
    
    return self;
}
-(void)log:(LogLevel)level Text:(NSString *)text {
    //dispatch_async(dispatch_get_main_queue(), ^{
    //printf("%s", [text cStringUsingEncoding:NSUTF8StringEncoding]);
    //const char *str = [text cStringUsingEncoding:NSUTF8StringEncoding];
    //write(STDERR_FILENO, str, strlen(str));
    //fprintf(stderr, "%s", [text cStringUsingEncoding:NSUTF8StringEncoding]);
    //});
    
    //[self logByNSlog:@"%@", text];
    [self logByLinuxWrite:text Level:level];
    [self logByConsolApp:text];
}
-(void)logByLinuxWrite:(NSString*)str Level:(LogLevel)level {
    CommandLineColor *color = [self.colorDictForOutput objectForKey:[NSNumber numberWithInteger:level]];
    if (color) {
        [color whriteToStdErrorWithColor:str];
    } else {
        struct iovec v;
        const char *cStr = [str cStringUsingEncoding:NSUTF8StringEncoding];
        v.iov_base = (void*)cStr;
        v.iov_len = strlen(cStr);
        writev(STDERR_FILENO, &v, 1);
    }
}
-(void)logByNSlog:(NSString*)formart, ... {
    va_list list;
    va_start(list, formart);
    NSLogv(formart, list);
    va_end(list);
}
const char* const kDDASLKeyDDLog = "DDLog";
const char* const kDDASLDDLogValue = "1";
-(void)logByConsolApp:(NSString*)logMessage {
    if (logMessage) {
        const char *msg = [logMessage cStringUsingEncoding:NSUTF8StringEncoding];
        size_t aslLogLevel;
        //        switch () {
        //                // Note: By default ASL will filter anything above level 5 (Notice).
        //                // So our mappings shouldn't go above that level.
        //            case DDLogFlagError     : aslLogLevel = ASL_LEVEL_CRIT;     break;
        //            case DDLogFlagWarning   : aslLogLevel = ASL_LEVEL_ERR;      break;
        //            case DDLogFlagInfo      : aslLogLevel = ASL_LEVEL_WARNING;  break; // Regular NSLog's level
        //            case DDLogFlagDebug     :
        //            case DDLogFlagVerbose   :
        //            default                 : aslLogLevel = ASL_LEVEL_NOTICE;   break;
        //        }
        aslLogLevel = ASL_LEVEL_NOTICE;
        static char const *const level_strings[] = { "0", "1", "2", "3", "4", "5", "6", "7" };
        
        // NSLog uses the current euid to set the ASL_KEY_READ_UID.
        uid_t const readUID = geteuid();
        
        char readUIDString[16];
#ifndef NS_BLOCK_ASSERTIONS
        int l = snprintf(readUIDString, sizeof(readUIDString), "%d", readUID);
#else
        snprintf(readUIDString, sizeof(readUIDString), "%d", readUID);
#endif
        
        NSAssert(l < sizeof(readUIDString),
                 @"Formatted euid is too long.");
        NSAssert(aslLogLevel < (sizeof(level_strings) / sizeof(level_strings[0])),
                 @"Unhandled ASL log level.");
        
        aslmsg m = asl_new(ASL_TYPE_MSG);
        if (m != NULL) {
            if (asl_set(m, ASL_KEY_LEVEL, level_strings[aslLogLevel]) == 0 &&
                asl_set(m, ASL_KEY_MSG, msg) == 0 &&
                asl_set(m, ASL_KEY_READ_UID, readUIDString) == 0 &&
                asl_set(m, kDDASLKeyDDLog, kDDASLDDLogValue) == 0) {
                asl_send(_client, m);
            }
            asl_free(m);
        }
        //TODO handle asl_* failures non-silently?
    }
}
@end

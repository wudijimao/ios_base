//
//  DTFileLog.m
//  WeiboMovie
//
//  Created by ximiao on 15/8/3.
//  Copyright (c) 2015年 liuyue. All rights reserved.
//

#import "DTFileLog.h"
#include <pthread.h>



@implementation DTFileLog {
    dispatch_semaphore_t _semaphore;
}
-(id)init {
    self = [super init];
    _array = [[NSMutableArray alloc] init];
#if TARGET_OS_IPHONE
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
#else
    NSString *path = [[NSBundle mainBundle] bundlePath];
#endif
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd_HH-mm-ss"];
    path = [path stringByAppendingPathComponent:@"Logs"];
    NSString *logFilePath = [NSString stringWithFormat:@"%@/WeiboMovie_%@.log", path, [formatter stringFromDate:[NSDate date]]];
    _file = [NSFileHandle fileHandleForUpdatingAtPath:logFilePath];
    if (!_file) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
        if ([[NSFileManager defaultManager] createFileAtPath:logFilePath contents:nil attributes:nil]) {
            _file = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
        }
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callToStop) name:@"applicationWillTerminate" object:nil];
    _semaphore = dispatch_semaphore_create(0);
    _lock = [[NSLock alloc] init];
    _thread = [[NSThread alloc] initWithTarget:self selector:@selector(writeToFileThread) object:nil];
    [_thread start];
    return self;
}
//写文件的线程
-(void)writeToFileThread {
    _keepRun = YES;
    NSArray *logs;
    while (_keepRun) {
        dispatch_semaphore_wait(_semaphore, dispatch_time(DISPATCH_TIME_NOW, 3*NSEC_PER_SEC));
        if (self.array.count >= WriteToFileCount) {
            [self.lock lock];
            logs = [self.array copy];
            [self.array removeAllObjects];
            [self.lock unlock];
            [self writeToFile:logs];
        }
    }
    [self.lock lock];
    [self writeToFile:self.array];
    [self.lock unlock];
}
//批量写文件
-(void)writeToFile:(NSArray*)array {
    NSMutableString *allStr = [[NSMutableString alloc] init];
    for (NSString*str in self.array) {
        [allStr appendString:str];
    }
    [_file writeData:[allStr dataUsingEncoding:NSUTF8StringEncoding]];
}
-(void)callToStop {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _keepRun = NO;
    dispatch_semaphore_signal(_semaphore);
}
-(void)dealloc {
    [_file closeFile];
}
-(void)log:(LogLevel)level Text:(NSString *)text {
    //if (_keepRun) {
    [self.lock lock];
    [self.array addObject:text];
    [self.lock unlock];
    //}
    //[_file writeData:[text dataUsingEncoding:NSUTF8StringEncoding]];
}
@end


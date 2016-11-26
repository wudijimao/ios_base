//
//  DTFileLog.h
//  WeiboMovie
//
//  Created by ximiao on 15/8/3.
//  Copyright (c) 2015年 liuyue. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WriteToFileCount 50 //每50条log写一次文件

@interface DTFileLog : NSObject<DTLogProtocol>
@property(nonatomic, strong)NSMutableArray *array;
@property(nonatomic, strong)NSFileHandle *file;
@property(nonatomic, strong)NSThread *thread;
@property(nonatomic)BOOL keepRun;
@property(nonatomic, strong)NSLock *lock;
-(void)log:(LogLevel)level Text:(NSString *)text;
@end
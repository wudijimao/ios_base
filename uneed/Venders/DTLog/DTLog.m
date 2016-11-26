//
//  DTLog.m
//  VisualSymbolicateCrash
//
//  Created by ximiao on 15/6/21.
//  Copyright (c) 2015年 ximiao. All rights reserved.
//

#import "DTLog.h"
#import "DTCommandLineLog.h"
#import "DTFileLog.h"

@interface DTLog()
@property (nonatomic, strong)NSMutableArray *logEntrtys;
@end

@implementation DTLog {
    NSDictionary *_levelStrDic;
    NSLock *_lock;
}
+(DTLog*)sharedInstance {
    static DTLog *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DTLog alloc] initWithType:LogType_CommandLineAndFile];
    });
    return instance;
}

-(id)initWithType:(LogType)type {
    self = [super init];
    _type = type;
    _lock = [[NSLock alloc] init];
    _outPutLevel = OUTPUTLEVEL;
    _logEntrtys = [[NSMutableArray alloc] init];
    _levelStrDic = [NSDictionary dictionaryWithObjectsAndKeys:
                    @"OFF", [NSNumber numberWithInteger:LogLevel_Off],
                    @"FATAL", [NSNumber numberWithInteger:LogLevel_Fatal],
                    @"ERROR", [NSNumber numberWithInteger:LogLevel_Error],
                    @"WARNING", [NSNumber numberWithInteger:LogLevel_Warning],
                    @"INFO", [NSNumber numberWithInteger:LogLevel_Info],
                    @"DEBUG", [NSNumber numberWithInteger:LogLevel_Debug],
                    @"TRACE", [NSNumber numberWithInteger:LogLevel_Trace],
                    @"ALL", [NSNumber numberWithInteger:LogLevel_All],
                    nil];
    switch (type) {
        case LogType_CommandLine:
            [self addLogEntrty:[[DTCommandLineLog alloc] init]];
            break;
        case LogType_CommandLineAndFile:
            [self addLogEntrty:[[DTCommandLineLog alloc] init]];
            [self addLogEntrty:[[DTFileLog alloc] init]];
            break;
        case LogType_File:
            [self addLogEntrty:[[DTFileLog alloc] init]];
            break;
        case LogType_None:
            break;
        default:
            NSAssert(NO, @"不支持的logType");
            break;
    }
    [self log:LogLevel_Fatal Text:@"TestLog___LogLevel_Fatal"];
    [self log:LogLevel_Error Text:@"TestLog___LogLevel_Error"];
    [self log:LogLevel_Warning Text:@"TestLog___LogLevel_Warning"];
    [self log:LogLevel_Info Text:@"TestLog___LogLevel_Info"];
    [self log:LogLevel_Debug Text:@"TestLog___LogLevel_Debug"];
    [self log:LogLevel_Trace Text:@"TestLog___LogLevel_Trace"];
    return self;
}
-(void)addLogEntrty:(id<DTLogProtocol>)object {
    [_logEntrtys addObject:object];
}
-(NSString*)getRealOutput:(LogLevel)level Text:(NSString*)text {
    NSString *strLevel = [_levelStrDic objectForKey:[NSNumber numberWithInteger:level]];
    NSString *str = [NSString stringWithFormat:@"%@|%@\r\n",
                     strLevel,
                     text];
    return str;
}
-(void)log:(LogLevel)level Text:(NSString *)text {
    if (level <= self.outPutLevel) {
        NSString *outPut = [self getRealOutput:level Text:text];
        for (id<DTLogProtocol> _logEntrty in self.logEntrtys) {
            [_logEntrty log:level Text:outPut];
        }
    }
}
-(void)log:(LogLevel)level Text:(NSString *)text File:(NSString*)file Line:(NSInteger)line Function:(NSString*)fun Thread:(NSThread*)thread Time:(NSDate*)time {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateStyle:kCFDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSString *str = [NSString stringWithFormat:@"%@|%@|File:%@:%ld|Function:%@|%@",
                     [dateFormatter stringFromDate:time],
                     thread,
                     file,
                     (long)line,
                     fun,
                     text];
    [self log:level Text:str];
}
@end





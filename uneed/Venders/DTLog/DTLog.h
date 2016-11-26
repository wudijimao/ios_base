//
//  DTLog.h
//  VisualSymbolicateCrash
//
//  Created by ximiao on 15/6/21.
//  Copyright (c) 2015年 ximiao. All rights reserved.
//

//***************************XcodeColor插件安装方法**********************************
//方法1：拷贝项目中doc/tools/Xcode6插件/XcodeColors.xcplugin 到~/Library/Application Support/Developer/Shared/Xcode/Plug-ins/
//方法2：https://github.com/robbiehanson/XcodeColors.git  下载这个项目并使用Xcode打开编译即可
//*********************************************************************************

#import <Foundation/Foundation.h>

#define LOGFILE_MAXSIZE 10  //MB

//#define LOG_OPEN

#ifdef LOG_OPEN
#define DTlogDefine(arg0, arg1, ...) \
[[DTLog sharedInstance] log:arg0 \
Text:[NSString stringWithFormat:arg1, ##__VA_ARGS__] \
File:[[NSString stringWithUTF8String:__FILE__] lastPathComponent] \
Line:__LINE__ \
Function:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
Thread:[NSThread currentThread] \
Time:[NSDate date]]
#else
#define DTlogDefine(arg0, arg1, ...)
#endif

#define DTLog_Fatal(arg1, ...) DTlogDefine(LogLevel_Fatal, arg1, ##__VA_ARGS__)
#define DTLog_Error(arg1, ...) DTlogDefine(LogLevel_Error, arg1, ##__VA_ARGS__)
#define DTLog_Warning(arg1, ...) DTlogDefine(LogLevel_Warning, arg1, ##__VA_ARGS__)
#define DTLog_Info(arg1, ...) DTlogDefine(LogLevel_Info, arg1, ##__VA_ARGS__)
#define DTLog_Debug(arg1, ...) DTlogDefine(LogLevel_Debug, arg1, ##__VA_ARGS__)
#define DTLog_Trace(arg1, ...) DTlogDefine(LogLevel_Trace, arg1, ##__VA_ARGS__)//DTlogDefine(LogLevel_Trace, arg1, ##__VA_ARGS__)
#define NSLog DTLog_Debug


#define OUTPUTLEVEL LogLevel_All

//例如设置为Debug时， 包括debug到Fatal的log全部显示、只有Trace的log不显示
//log默认等级为Debug
typedef NS_ENUM(NSInteger, LogLevel) {
    LogLevel_Off = -4,
    LogLevel_Fatal = -3,
    LogLevel_Error = -2,
    LogLevel_Warning = -1,
    LogLevel_Info = 0,
    LogLevel_Debug = 1,
    LogLevel_Trace = 2,
    LogLevel_All = 3
};

typedef NS_ENUM(NSInteger, LogType) {
    LogType_None = 0,
    LogType_CommandLine,
    LogType_File,
    LogType_CommandLineAndFile,
};

@protocol DTLogProtocol <NSObject>
-(void)log:(LogLevel)level Text:(NSString *)text;
@end

@interface DTLog : NSObject
@property (nonatomic, readonly)LogType type;
@property (nonatomic)BOOL needCommandLineOutPut;
@property (nonatomic)LogLevel outPutLevel;
-(void)addLogEntrty:(id<DTLogProtocol>)object;
+(DTLog*)sharedInstance;
-(id)initWithType:(LogType)type;
-(void)log:(LogLevel)level Text:(NSString *)text;
-(void)log:(LogLevel)level Text:(NSString *)text File:(NSString*)file Line:(NSInteger)line Function:(NSString*)fun Thread:(NSThread*)thread Time:(NSDate*)time;
@end





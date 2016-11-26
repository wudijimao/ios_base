//
//  DTCommandLineLog.h
//  WeiboMovie
//
//  Created by ximiao on 15/8/3.
//  Copyright (c) 2015年 liuyue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTLog.h"

@interface DTCommandLineLog : NSObject<DTLogProtocol>
@property (nonatomic, strong)NSMutableDictionary *colorDictForOutput;
-(void)log:(LogLevel)level Text:(NSString *)text;
@end

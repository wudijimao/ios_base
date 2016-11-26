//
//  CommandLineColor.h
//  WeiboMovie
//
//  Created by ximiao on 15/7/21.
//  Copyright (c) 2015年 liuyue. All rights reserved.
//
//  需要安装此插件:https://github.com/robbiehanson/XcodeColors
#import <Foundation/Foundation.h>

@interface CommandLineColor : NSObject{
@public
    uint8_t fg_r;
    uint8_t fg_g;
    uint8_t fg_b;
    
    uint8_t bg_r;
    uint8_t bg_g;
    uint8_t bg_b;
    
    NSUInteger fgCodeIndex;
    NSString *fgCodeRaw;
    
    NSUInteger bgCodeIndex;
    NSString *bgCodeRaw;
    
    char fgCode[24];
    size_t fgCodeLen;
    
    char bgCode[24];
    size_t bgCodeLen;
    
    char resetCode[8];
    size_t resetCodeLen;
}

- (instancetype)initWithForegroundColor:(UIColor *)fgColor backgroundColor:(UIColor *)bgColor;
- (BOOL)whriteToStdErrorWithColor:(NSString*)text;
@end

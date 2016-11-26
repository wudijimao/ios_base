//
//  CommandLineColor.m
//  WeiboMovie
//
//  Created by ximiao on 15/7/21.
//  Copyright (c) 2015年 liuyue. All rights reserved.
//

#import "CommandLineColor.h"
#import <sys/uio.h>

#define XCODE_COLORS_ESCAPE_SEQ "\033["

#define XCODE_COLORS_RESET_FG   XCODE_COLORS_ESCAPE_SEQ "fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG   XCODE_COLORS_ESCAPE_SEQ "bg;" // Clear any background color
#define XCODE_COLORS_RESET      XCODE_COLORS_ESCAPE_SEQ ";"  // Clear any foreground or background color


@implementation CommandLineColor
- (void)getRed:(CGFloat *)rPtr green:(CGFloat *)gPtr blue:(CGFloat *)bPtr fromColor:(UIColor *)color {
#if TARGET_OS_IPHONE
    
    // iOS
    
    BOOL done = NO;
    
    if ([color respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        done = [color getRed:rPtr green:gPtr blue:bPtr alpha:NULL];
    }
    
    if (!done) {
        // The method getRed:green:blue:alpha: was only available starting iOS 5.
        // So in iOS 4 and earlier, we have to jump through hoops.
        
        CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
        
        unsigned char pixel[4];
        CGContextRef context = CGBitmapContextCreate(&pixel, 1, 1, 8, 4, rgbColorSpace, (CGBitmapInfo)(kCGBitmapAlphaInfoMask & kCGImageAlphaNoneSkipLast));
        
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
        
        if (rPtr) {
            *rPtr = pixel[0] / 255.0f;
        }
        
        if (gPtr) {
            *gPtr = pixel[1] / 255.0f;
        }
        
        if (bPtr) {
            *bPtr = pixel[2] / 255.0f;
        }
        
        CGContextRelease(context);
        CGColorSpaceRelease(rgbColorSpace);
    }
    
#elif __has_include(<AppKit/NSColor.h>)
    
    // OS X with AppKit
    
    NSColor *safeColor = [color colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
    
    [safeColor getRed:rPtr green:gPtr blue:bPtr alpha:NULL];
    
#else /* if TARGET_OS_IPHONE */
    
    // OS X without AppKit
    
    [color getRed:rPtr green:gPtr blue:bPtr alpha:NULL];
    
#endif /* if TARGET_OS_IPHONE */
}

- (instancetype)initWithForegroundColor:(UIColor *)fgColor backgroundColor:(UIColor *)bgColor {
    if ((self = [super init])) {
        CGFloat r, g, b;
        
        if (fgColor) {
            [self getRed:&r green:&g blue:&b fromColor:fgColor];
            
            fg_r = (uint8_t)(r * 255.0f);
            fg_g = (uint8_t)(g * 255.0f);
            fg_b = (uint8_t)(b * 255.0f);
        }
        
        if (bgColor) {
            [self getRed:&r green:&g blue:&b fromColor:bgColor];
            
            bg_r = (uint8_t)(r * 255.0f);
            bg_g = (uint8_t)(g * 255.0f);
            bg_b = (uint8_t)(b * 255.0f);
        }
        
        if(fgColor) {
            // Convert foreground color to color code sequence
            const char *escapeSeq = XCODE_COLORS_ESCAPE_SEQ;
            
            int result = snprintf(fgCode, 24, "%sfg%u,%u,%u;", escapeSeq, fg_r, fg_g, fg_b);
            fgCodeLen = (NSUInteger)MAX(MIN(result, (24 - 1)), 0);
        } else {
            // No foreground color or no color support
            fgCode[0] = '\0';
            fgCodeLen = 0;
        }
        if (bgColor) {
            // Convert background color to color code sequence
            const char *escapeSeq = XCODE_COLORS_ESCAPE_SEQ;
            
            int result = snprintf(bgCode, 24, "%sbg%u,%u,%u;", escapeSeq, bg_r, bg_g, bg_b);
            bgCodeLen = (NSUInteger)MAX(MIN(result, (24 - 1)), 0);
        } else {
            // No background color or no color support
            bgCode[0] = '\0';
            bgCodeLen = 0;
        }
        resetCodeLen = (NSUInteger)MAX(snprintf(resetCode, 8, XCODE_COLORS_RESET), 0);
    }
    
    return self;
}
- (BOOL)whriteToStdErrorWithColor:(NSString*)text{
    int iovec_len = 4;
    struct iovec v[iovec_len];

        v[0].iov_base = fgCode;
        v[0].iov_len = fgCodeLen;
        
        v[1].iov_base = bgCode;
        v[1].iov_len = bgCodeLen;
        
        v[iovec_len - 1].iov_base = resetCode;
        v[iovec_len - 1].iov_len = resetCodeLen;

    
    v[2].iov_base = (char*)[text cStringUsingEncoding:NSUTF8StringEncoding];
    v[2].iov_len = strlen(v[2].iov_base);
    writev(STDERR_FILENO, v, iovec_len);
    return YES;
}

//- (NSString *)description {
//    return [NSString stringWithFormat:
//            @"<DDTTYLoggerColorProfile: %p mask:%i ctxt:%ld fg:%u,%u,%u bg:%u,%u,%u fgCode:%@ bgCode:%@>",
//            self, (int)mask, (long)context, fg_r, fg_g, fg_b, bg_r, bg_g, bg_b, fgCodeRaw, bgCodeRaw];
//}

@end

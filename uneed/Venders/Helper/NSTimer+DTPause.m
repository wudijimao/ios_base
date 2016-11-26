//
//  NSTimer+WBMPause.m
//  WBMovie
//
//  Created by ximiao on 16/1/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "NSTimer+DTPause.h"

@implementation NSTimer(DTPause)


-(void)dt_pauseTimer{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]]; //如果给我一个期限，我希望是4001-01-01 00:00:00 +0000
}

-(void)dt_resumeTimer{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

@end

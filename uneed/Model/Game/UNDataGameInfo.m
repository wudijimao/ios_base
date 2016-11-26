//
//  UNDataGameInfo.m
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UNDataGameInfo.h"

@implementation UNDataGameInfo

- (BOOL)parser:(NSMutableDictionary *)dict
{
    if ([super parser:dict]) {
        _name = [dict dt_getStringWithKey:@"name"];
        _icon = [dict dt_getStringWithKey:@"icon"];
        _online_mode_name = [dict dt_getStringWithKey:@"online_mode_name"];
        _url = [dict dt_getStringWithKey:@"url"];
        return true;
    }
    return false;
}

@end

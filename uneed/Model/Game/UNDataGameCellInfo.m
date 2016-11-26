//
//  UNDataGameCellInfo.m
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UNDataGameCellInfo.h"

@implementation UNDataGameCellInfo

- (BOOL)parser:(NSMutableDictionary *)dict
{
    if ([super parser:dict]) {
        _gameInfo = [UNDataGameInfo objectWithJsonDict:[dict dt_getDictWithKey:@"game_info"]];
    }
    return false;
}

@end

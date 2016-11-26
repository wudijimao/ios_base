//
//  UNDataGameListInfo.m
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UNDataGameListInfo.h"

@implementation UNDataGameListInfo

- (BOOL)parser:(NSMutableDictionary *)dict
{
    if ([super parser:dict]) {
        _gameList = [[UNDataListInfo<UNDataGameCellInfo*> alloc] initWithJsonDict:[dict objectForKey:@"gamelist"] objClass:[UNDataGameCellInfo class]];
        return true;
    }
    return false;
}

@end

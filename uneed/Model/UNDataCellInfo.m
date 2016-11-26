//
//  UNDataCellInfo.m
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UNDataCellInfo.h"

@implementation UNDataCellInfo

- (BOOL)parser:(NSMutableDictionary *)dict
{
    if ([super parser:dict]) {
        NSNumber *num = [dict dt_getNumberWithKey:@"cell_type"];
        if (num) {
            _cellType = [num integerValue];
             return true;
        }
    }
    return false;
}

@end

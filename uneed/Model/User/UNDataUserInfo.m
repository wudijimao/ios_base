//
//  UNDataUserInfo.m
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UNDataUserInfo.h"

@implementation UNDataUserInfo
- (BOOL)parser:(NSMutableDictionary *)dict
{
    if ([super parser:dict]) {
        _avatar = [dict dt_getStringWithKey:@"avatar"];
        _avatar_large = [dict dt_getStringWithKey:@"avatar_large"];
        if (!_avatar_large) {
            _avatar_large = _avatar;
        }
        _id_ = [dict dt_getStringWithKey:@"id"];
        _name = [dict dt_getStringWithKey:@"name"];
        return YES;
    }
    return NO;
}
@end

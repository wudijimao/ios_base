//
//  UNGetGameListRequest.m
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UNGetGameListRequest.h"

@implementation UNGetGameListRequest

- (NSString*)requestPath {
    return @"action/game_list";
}

- (NSMutableDictionary*)params {
    NSMutableDictionary *dict = [super params];
    [dict setObject:@"test" forKey:@"aa"];
    return dict;
}

- (BOOL)analysisData:(id)responseObject
{
    if ([super analysisData:responseObject]) {
        self.response = [[UNDataGameListInfo alloc] initWithJsonDict:self.response];
        if (self.response) {
            return YES;
        }
    }
    return NO;
}
@end

//
//  UNDataGameInfo.h
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UNDataBaseObject.h"

@interface UNDataGameInfo : UNDataBaseObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *online_mode_name;
@property (nonatomic, strong) NSString *url;

@end

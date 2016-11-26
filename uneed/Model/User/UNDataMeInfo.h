//
//  UNDataMeInfo.h
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UNDataBaseObject.h"
#import "UNDataUserInfo.h"

@interface UNDataMeInfo : UNDataBaseObject

@property (nonatomic, strong)UNDataUserInfo* userInfo;
@property (nonatomic, assign)NSInteger wantPlayCount;
@property (nonatomic, assign)NSInteger hasPlayCount;

@end

//
//  UNDataGameListInfo.h
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UNDataBaseObject.h"
#import "UNDataListInfo.h"
#import "UNDataGameCellInfo.h"

@interface UNDataGameListInfo : UNDataBaseObject
@property (nonnull, strong)UNDataListInfo<UNDataGameCellInfo*>* gameList;
@end

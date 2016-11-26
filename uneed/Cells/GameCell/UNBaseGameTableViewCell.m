//
//  UNBaseGameTableViewCell.m
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UNBaseGameTableViewCell.h"

@implementation UNBaseGameTableViewCell

- (void)update:(nullable UNDataBaseObject *)data cellInfo:(nullable UNTableViewCellExtraInfo *)info {
    
}

//计算cell高度
+ (CGFloat)preferredHeightForData:(nullable UNDataBaseObject*)data cellInfo:(nullable UNTableViewCellExtraInfo *)info width:(CGFloat)width {
    return 150.0f;
}


@end

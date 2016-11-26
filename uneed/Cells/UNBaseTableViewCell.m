//
//  UNBaseTableViewCell.m
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UNBaseTableViewCell.h"


@implementation UNBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)update:(nullable UNDataBaseObject *)data cellInfo:(nullable UNTableViewCellExtraInfo *)info {
    
}

//计算cell高度
+ (CGFloat)preferredHeightForData:(nullable UNDataBaseObject*)data cellInfo:(nullable UNTableViewCellExtraInfo *)info width:(CGFloat)width {
    return 0.f;
}

//自定义reuseIdentifier，默认为类名
+ (nonnull NSString *)customReuseIdentifier {
    return NSStringFromClass(self);
}

@end

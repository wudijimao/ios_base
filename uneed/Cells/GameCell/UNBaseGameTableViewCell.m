//
//  UNBaseGameTableViewCell.m
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UNBaseGameTableViewCell.h"

@implementation UNBaseGameTableViewCell {
    UIImageView *_iconView;
    UIButton *_btn1;
    UIButton *_btn2;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 130, 130)];
        _btn1 = [[UIButton alloc] initWithFrame:CGRectMake(150, 30, 120, 90)];
        [_btn1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _btn2 = [[UIButton alloc] initWithFrame:CGRectMake(270, 30, 120, 90)];
        [_btn2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self.contentView  addSubview:_iconView];
        [self.contentView addSubview:_btn1];
        [self.contentView addSubview:_btn2];
        [_btn1 addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [_btn2 addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)click {
    [self.delegate tableViewCell:self action:UNTableViewCellActionType_OpenH5Game userInfo:_info.gameInfo.url];
}

- (void)update:(nullable UNDataBaseObject *)data cellInfo:(nullable UNTableViewCellExtraInfo *)info {
    if (data && [data isKindOfClass:[UNDataGameCellInfo class]]) {
        self.info = (UNDataGameCellInfo*)data;
        [_iconView sd_setImageWithURL:[NSURL URLWithString:self.info.gameInfo.icon]];
        [_btn1 setTitle:self.info.gameInfo.name forState:UIControlStateNormal];
        [_btn2 setTitle:self.info.gameInfo.online_mode_name forState:UIControlStateNormal];
    }
}

//计算cell高度
+ (CGFloat)preferredHeightForData:(nullable UNDataBaseObject*)data cellInfo:(nullable UNTableViewCellExtraInfo *)info width:(CGFloat)width {
    return 150.0f;
}


@end

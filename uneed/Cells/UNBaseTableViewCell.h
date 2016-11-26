//
//  UNBaseTableViewCell.h
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, UNTableViewCellActionType) {
    UNTableViewCellActionType_OpenScheme,
    UNTableViewCellActionType_OpenWebUrl,
    UNTableViewCellActionType_OpenUrl,
    UNTableViewCellActionType_OpenH5Game,
};

@class UNBaseTableViewCell;
@protocol UNTableViewCellDelegate <NSObject>

@optional
- (BOOL)tableViewCell:(nonnull UNBaseTableViewCell*)cell action:(UNTableViewCellActionType)actionType userInfo:(nullable id)userInfo;

@end


//除流内容信息外的配置项基类
@interface UNTableViewCellExtraInfo : NSObject
//是否显示分割线
@property (assign, nonatomic) BOOL isSplitLineHidden;
//是否显示下阴影
@property (assign, nonatomic) BOOL isLowerShadowHidden;
//是否选中
@property (assign, nonatomic) BOOL isSelected;
@end

@class UNDataBaseObject;

@interface UNBaseTableViewCell : UITableViewCell

@property (weak, nonatomic, nullable) id<UNTableViewCellDelegate> delegate;
@property (weak, nonatomic, nullable) UITableView *contentTableView;


- (void)update:(nullable UNDataBaseObject *)data cellInfo:(nullable UNTableViewCellExtraInfo *)info;

//计算cell高度
+ (CGFloat)preferredHeightForData:(nullable UNDataBaseObject*)data cellInfo:(nullable UNTableViewCellExtraInfo *)info width:(CGFloat)width;

//自定义reuseIdentifier，默认为类名
+ (nonnull NSString *)customReuseIdentifier;

@end

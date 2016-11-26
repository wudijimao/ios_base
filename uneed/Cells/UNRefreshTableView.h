//
//  UNTableView.h
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UNTableViewRefreshType) {
    MovieSDKTableViewRefreshType_Empty = 16,
    MovieSDKTableViewRefreshType_Error = 8,
    MovieSDKTableViewRefreshType_None = 4,
    MovieSDKTableViewRefreshType_Middle = 0,
    MovieSDKTableViewRefreshType_Top = 1,
    MovieSDKTableViewRefreshType_Bottom = 2,
    MovieSDKTableViewRefreshType_ALL = 3,
};

typedef NS_ENUM(NSInteger, UNTableViewRefreshFinishType) {
    MovieSDKTableViewRefreshFinishType_Error = 0,
    MovieSDKTableViewRefreshFinishType_Success = 1,
    MovieSDKTableViewRefreshFinishType_Empty = 2,
};

@interface UNRefreshTableView : UITableView

@end

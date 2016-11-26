//
//  UNTableViewController.h
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UNRefreshTableView.h"
#import "UNDataBaseObject.h"
#import "UNBaseTableViewCell.h"

@interface UNTableViewController : UITableViewController

#pragma mark - over write these functions
- (void)tableView:(UNRefreshTableView * _Nonnull)tableView didStartRefreshData:(UNTableViewRefreshType)type;
- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView;
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (nonnull __kindof UNDataBaseObject*)unTableView:(nonnull UITableView *)tableView dataForRowAtIndexPath:(nonnull NSIndexPath*)indexPath;
//return nil to use deafaultClass defined in factory
- (nullable Class)unTableView:(nonnull UITableView *)tableView classForRowAtIndexPath:(nonnull NSIndexPath*)indexPath data:(nonnull UNDataBaseObject*)data;
- (nullable __kindof UNTableViewCellExtraInfo*)unTableView:(nonnull UITableView *)tableView extraInfoForRowAtIndexPath:(nonnull NSIndexPath*)indexPath data:(nonnull UNDataBaseObject*)data;

@end

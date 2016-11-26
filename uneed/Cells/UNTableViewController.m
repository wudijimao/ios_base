//
//  UNTableViewController.m
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UNTableViewController.h"
#import "UNBaseTableViewCell.h"
#import "H5ViewController.h"

@interface UNTableViewController ()

@end

@implementation UNTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UNRefreshTableView *)tableView didStartRefreshData:(UNTableViewRefreshType)type {
    //[tableView stopRefresh:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UNDataBaseObject *data = [self unTableView:tableView dataForRowAtIndexPath:indexPath];
    Class c = [self unTableView:tableView classForRowAtIndexPath:indexPath data:data];
    UNTableViewCellExtraInfo *info = [self unTableView:tableView extraInfoForRowAtIndexPath:indexPath data:data];
    return [UNTableViewController preferredHeightForData:data cellInfo:info width:tableView.frame.size.width class:c];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UNDataBaseObject *data = [self unTableView:tableView dataForRowAtIndexPath:indexPath];
    Class c = [self unTableView:tableView classForRowAtIndexPath:indexPath data:data];
    return [UNTableViewController cellForTableView:tableView class:c delegate:self];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[UNBaseTableViewCell class]]) {
        UNDataBaseObject *data = [self unTableView:tableView dataForRowAtIndexPath:indexPath];
        UNTableViewCellExtraInfo *info = [self unTableView:tableView extraInfoForRowAtIndexPath:indexPath data:data];
        [((UNBaseTableViewCell*)cell) update:data cellInfo:info];
    }
}

- (__kindof UNDataBaseObject*)unTableView:(UITableView *)tableView dataForRowAtIndexPath:(NSIndexPath*)indexPath {
    return nil;
}
- (nullable Class)unTableView:(UITableView *)unTableView classForRowAtIndexPath:(NSIndexPath*)indexPath data:(UNDataBaseObject*)data {
    return nil;
}
- (__kindof UNTableViewCellExtraInfo*)unTableView:(UITableView *)tableView extraInfoForRowAtIndexPath:(NSIndexPath*)indexPath data:(UNDataBaseObject*)data {
    return nil;
}

- (BOOL)tableViewCell:(UNBaseTableViewCell *)cell action:(UNTableViewCellActionType)actionType userInfo:(nullable id)userInfo
{
    switch (actionType) {
        case UNTableViewCellActionType_OpenScheme:
        {
            if ([userInfo isKindOfClass:[NSString class]]) {
                //[self openScheme:userInfo];
                return YES;
            }
        }
            break;
        case UNTableViewCellActionType_OpenUrl: {
            if ([userInfo isKindOfClass:[NSString class]]) {
                //[UNOpenSecondPageHelper openUrl:userInfo inViewController:self];
                return YES;
            }
        }
            break;
        case UNTableViewCellActionType_OpenH5Game: {
            if ([userInfo isKindOfClass:[NSString class]]) {
                H5ViewController *vc = [[H5ViewController alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
            }
        }
        default:
            break;
    }
    return NO;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


+ (nonnull __kindof UITableViewCell *)cellForTableView:(nonnull UITableView *)tableView class:(nonnull Class)cellClass delegate:(nullable id<UNTableViewCellDelegate>)delegate
{
    if (![cellClass isSubclassOfClass:[UNBaseTableViewCell class]])
        NSAssert(NO, @"Method: %@ input class is not supported", NSStringFromSelector(_cmd));
    
    NSString *reuseIdentifier = [cellClass customReuseIdentifier];
    UNBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.contentTableView = tableView;
    }
    cell.delegate = delegate;
    return cell;
}

+ (CGFloat)preferredHeightForData:(nullable UNDataBaseObject*)data cellInfo:(nullable UNTableViewCellExtraInfo *)info width:(CGFloat)width class:(nullable Class)cellClass;
{
    if (!cellClass)
        cellClass = [self defaultClassForData:data];
    if (![cellClass isSubclassOfClass:[UNBaseTableViewCell class]])
        NSAssert(NO, @"Method: %@ input class is not supported", NSStringFromSelector(_cmd));
    return [cellClass preferredHeightForData:data cellInfo:info width:width];
}

+ (nonnull Class)defaultClassForData:(nonnull UNDataBaseObject*)data
{
    //最好使用 isMemberOfClass 判断Class
    if ([data isMemberOfClass:[UNDataBaseObject class]])
        return [UNBaseTableViewCell class];
    NSAssert(NO, @"Method: %@ input data class is not supported", NSStringFromSelector(_cmd));
    return nil;
}

@end

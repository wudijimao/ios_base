//
//  UNGameListViewController.m
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UNGameListViewController.h"
#import "H5ViewController.h"
#import "UNTabBarItem.h"
#import "UNGetGameListRequest.h"
#import "UNBaseGameTableViewCell.h"
#import "uneed-Swift.h"

@interface UNGameListViewController ()

@end

@implementation UNGameListViewController {
    UNDataGameListInfo* _info;
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)requestList {
    [[UNHttpClient sharedInstance] sendRequest:[UNGetGameListRequest new] complete:^(id response, NSError *errorMsg) {
        if (response && [response isKindOfClass:[UNDataGameListInfo class]]) {
            _info = response;
            [self.tableView reloadData];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem = [[UNTabBarItem alloc] initWithTitle:@"游戏" image:[UIImage imageNamed:@"icon_play"] selectedImage:[UIImage imageNamed:@"icon_play"]];
    // Do any additional setup after loading the view.
    [self requestList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)tableView:(UNRefreshTableView * _Nonnull)tableView didStartRefreshData:(UNTableViewRefreshType)type {
    
}
- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    if (_info != nil) {
        return 1;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = _info.gameList.list.count;
    return count;
}

- (nonnull __kindof UNDataBaseObject*)unTableView:(nonnull UITableView *)tableView dataForRowAtIndexPath:(nonnull NSIndexPath*)indexPath {
    return [_info.gameList.list objectAtIndex:indexPath.row];
}
//return nil to use deafaultClass defined in factory
- (nullable Class)unTableView:(nonnull UITableView *)tableView classForRowAtIndexPath:(nonnull NSIndexPath*)indexPath data:(nonnull UNDataBaseObject*)data {
    return [UNBaseGameCell class];
}


@end




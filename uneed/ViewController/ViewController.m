//
//  ViewController.m
//  uneed
//
//  Created by wudijimao on 16/11/24.
//  Copyright (c) 2016年 wudijimao. All rights reserved.
//

#import "ViewController.h"
#import "UNGameListViewController.h"
#import "MeViewController.h"

@interface ViewController ()
@end

@implementation ViewController {
     NSArray<UIViewController *>* _viewControllers;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setViewControllers:[self myViewControllers]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSArray<UIViewController *> *)myViewControllers
{
    if (!_viewControllers) {
        UNGameListViewController *gameList = [[UNGameListViewController alloc] init];
        MeViewController *me = [[MeViewController alloc] init];
        _viewControllers = @[gameList, me];
    }
    return _viewControllers;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end












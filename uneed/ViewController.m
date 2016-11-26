//
//  ViewController.m
//  uneed
//
//  Created by wudijimao on 16/11/24.
//  Copyright (c) 2016年 wudijimao. All rights reserved.
//

#import "ViewController.h"
#import "H5ViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 40, 100, 30)];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"H5" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 160, 100, 100)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.chinanews.com/cr/2013/0608/2964672802.jpg"]];
    [self.view addSubview:imageView];
}

- (void)onClick:(UIButton*)btn {
    UIViewController *controller = [[H5ViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

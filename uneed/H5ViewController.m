//
//  H5ViewController.m
//  uneed
//
//  Created by wudijimao on 16/11/24.
//  Copyright (c) 2016年 wudijimao. All rights reserved.
//

#import "H5ViewController.h"
#import "UNWebView.h"

@interface H5ViewController ()

@end

@implementation H5ViewController {
    UNWebView *_webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _webView = [[UNWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    NSURLCache *urlCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:60 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:urlCache];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

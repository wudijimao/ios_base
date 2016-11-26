//
//  MeViewController.m
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "MeViewController.h"
#import "H5ViewController.h"
#import "UNTabBarItem.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UNTabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"icon_me"] selectedImage:[UIImage imageNamed:@"icon_me"]];
    }
    return self;
}

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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

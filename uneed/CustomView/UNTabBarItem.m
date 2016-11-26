//
//  UNTabBarItem.m
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UNTabBarItem.h"

@implementation UNTabBarItem

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    self = [super initWithTitle:title image:image selectedImage:selectedImage];
    if (self) {
        self.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return self;
}

@end

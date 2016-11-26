//
//  NSString+DTURL.h
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DTURL)

- (NSString *)dt_URLEncodedString;
- (NSString*)dt_URLDecodedString;

@end


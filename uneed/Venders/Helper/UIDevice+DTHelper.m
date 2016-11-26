//
//  UIDevice+DTHelper.m
//  uneed
//
//  Created by ximiao1 on 16/11/26.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

#import "UIDevice+DTHelper.h"
#include <sys/sysctl.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation UIDevice (DTHelper)

+ (NSString *)dt_getDeviceModelName
{
    static NSString *platform;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
        free(machine);
    });
    return platform;
    
}


static NSString * ipAdress = nil;
+ (NSString *)wbm_deviceIPAdress
{
    if(ipAdress == nil)
    {
        struct ifaddrs *interfaces = NULL;
        struct ifaddrs *temp_addr = NULL;
        int success = 0;
        
        success = getifaddrs(&interfaces);
        
        if (success == 0) { // 0 表示获取成功
            
            temp_addr = interfaces;
            while (temp_addr != NULL) {
                if( temp_addr->ifa_addr->sa_family == AF_INET) {
                    // Check if interface is en0 which is the wifi connection on the iPhone
                    if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                        // Get NSString from C String
                        ipAdress = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    }
                }
                ////IPv6
                else if (temp_addr->ifa_addr->sa_family == AF_INET6)
                {
                    char ipv6[INET6_ADDRSTRLEN];
                    inet_ntop(AF_INET6, (void *)&(((struct sockaddr_in6 *)(temp_addr->ifa_addr))->sin6_addr), ipv6, INET6_ADDRSTRLEN);
                    NSString * name = [NSString stringWithUTF8String:temp_addr->ifa_name];
                    if (([name.lowercaseString hasPrefix:@"en"] || [name.lowercaseString hasPrefix:@"pdp"]) && [ipAdress.lowercaseString hasPrefix:@"fe80"] == NO)
                    {
                        ipAdress = [NSString stringWithUTF8String:ipv6];
                        freeifaddrs(interfaces);
                        return ipAdress;
                    }
                }
                
                temp_addr = temp_addr->ifa_next;
            }
        }
        
        freeifaddrs(interfaces);
        
    }
    return ipAdress;
}

@end

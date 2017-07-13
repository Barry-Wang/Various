//
//  Va_Sl.m
//  Va_Sl
//
//  Created by WangWei on 11/7/17.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import "Va_Sl.h"
#import "NSString+count.h"

@implementation Va_Sl

+(void)print {
   
    NSLog(@"这是一个测试的动态库!");
    NSString *a = @"这是一个测试的动态库!";
    [a printSomeThing];
}

@end

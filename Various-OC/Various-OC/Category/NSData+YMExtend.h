//
//  NSData+YMExtend.h
//  Various-OC
//
//  Created by WangWei on 13/7/17.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SHACATEGORY) {
  
    TWO_TWO_FOUR =  0,
    TWO_FIVE_SIX = 1,
    THREE_EIGHT_FOUR = 2,
    FIVE_ONE_TWO = 3,
    
};


@interface NSData (YMExtend)

- (NSString *)md5String;

@end

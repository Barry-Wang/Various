//
//  NSObject+YMAddForKVO.h
//  Various-OC
//
//  Created by WangWei on 12/7/17.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ObserverBlock)(__weak id object, id oldValue, id newValue);


@interface NSObject (YMAddForKVO)

- (void)addObserverForKeyPath:(NSString *)keyPath block:(ObserverBlock)block;

@end

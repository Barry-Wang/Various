//
//  NSMutableDictionary+Safe.m
//  Various-OC
//
//  Created by YmWw on 2017/8/21.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (Safe)

+(void)load {
  
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [NSMutableDictionary exchangeSelector:@selector(setObject:forKey:) newSelector:@selector(setAllObject:forKey:)];
        
    });
    
    
}

+ (void)exchangeSelector:(SEL)originSelector newSelector:(SEL)newSelector {
    
    NSAssert(originSelector, @"The origin selector can not be nil");
    NSAssert(newSelector, @"The replace selector can not be nil");
    
    Class arrayCls = NSClassFromString(@"__NSDictionaryM");

    
    
    Method originMethod = class_getInstanceMethod(arrayCls, originSelector);
    Method newMethod = class_getInstanceMethod(arrayCls, newSelector);
    BOOL didAddMethod = class_addMethod(arrayCls, originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (didAddMethod) {
        
        class_replaceMethod(arrayCls, newSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        
    } else {
        
        method_exchangeImplementations(originMethod, newMethod);
    }
}

- (void)setAllObject:(id)anyObject forKey:(id<NSCopying>)aKey{
    
    if(!anyObject || [anyObject isEqual:[NSNull null]]) {
        
        NSLog(@"you are inserting a nil object, we had ignored it, plase attention!");
        
    } else {
      
        [self setAllObject:anyObject forKey:aKey];
    }
}

- (void)setObject:(id)obj forKey:(id)aKey default:(id)defaultValue {
   
    if (!obj || [obj isEqual:[NSNull null]]) {
        
        [self setAllObject:defaultValue forKey:aKey];
    } else {
       
        [self setAllObject:obj forKey:aKey];
    }
}

- (id)ObjectForKey:(id)key default:(id)defaultValue{
   
    if (self[key] == nil ||[self[key] isEqual:[NSNull null]]) {
        
        return defaultValue;
    }
      
        return defaultValue;

}

@end

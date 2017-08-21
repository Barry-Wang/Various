//
//  NSDictionary+safe.m
//  Various-OC
//
//  Created by YmWw on 2017/8/21.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import "NSDictionary+safe.h"
#import <objc/runtime.h>

@implementation NSDictionary (safe)

+(void)load {
  
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [NSDictionary exchangeSelector:@selector(dictionaryWithObjects:forKeys:count:) newSelector:@selector(initWithAllObjects:forKeys:count:)];
        
    });
}

- (void)setObject:(id)object forKey:(NSString *)key {
   
    
}

+ (void)exchangeSelector:(SEL)originSelector newSelector:(SEL)newSelector {
   
    NSAssert(originSelector, @"The origin selector can not be nil");
    NSAssert(newSelector, @"The replace selector can not be nil");
    
    Class class = object_getClass((id)self);

    
    Method originMethod = class_getClassMethod(class, originSelector);
    Method newMethod = class_getClassMethod(class, newSelector);
    BOOL didAddMethod = class_addMethod(class, originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (didAddMethod) {
       
        class_replaceMethod(class, newSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        
    } else {
      
        method_exchangeImplementations(originMethod, newMethod);
    }
}

+ (instancetype)initWithAllObjects:(id const[])objects forKeys:(id<NSCopying>const [])keys count:(NSUInteger)cnt {
   
    int totalCount = 0;
    
    for (int i = 0; i < cnt; i++) {
        
        if (objects[i] && ![objects[i] isEqual:[NSNull null]] && keys[i] && ![objects[i] isEqual:[NSNull null] ] ) {
            
            totalCount += 1;
        }
        
    }
    
    id reObjects[totalCount];
    id reKeys[totalCount];
    int resultIndex = 0;
    
    for (int i = 0; i < cnt; i++) {
        
        if (objects[i] && ![objects[i] isEqual:[NSNull null]] && keys[i] && ![objects[i] isEqual:[NSNull null] ] ) {
            
            reObjects[resultIndex] = objects[i];
            reKeys[resultIndex] = keys[i];
            resultIndex++;
        }
        
    }
    
    
    return [self initWithAllObjects:reObjects forKeys:reKeys count:resultIndex];
}


@end

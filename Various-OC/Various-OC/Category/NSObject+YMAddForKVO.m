//
//  NSObject+YMAddForKVO.m
//  Various-OC
//
//  Created by WangWei on 12/7/17.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import "NSObject+YMAddForKVO.h"
#import <objc/runtime.h>
#import <objc/objc.h>

static const char *block_key;


@interface _YMObserverTarget : NSObject

@property (nonatomic, copy) ObserverBlock block;

@end

@implementation _YMObserverTarget

-(instancetype) initWithBlock:(ObserverBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
   
    if (!self.block) {
      
        return;
    }
    
    BOOL isPrior = [[change objectForKey:@"NSKeyValueChangeNotificationIsPriorKey"] boolValue];
    if (isPrior) {
        
        return;
    }
    
    NSKeyValueChange changeKind = [[change objectForKey:NSKeyValueChangeKindKey] integerValue];
    if (changeKind != NSKeyValueChangeSetting) {
        
        return;
    }
    
    id old = [change objectForKey:NSKeyValueChangeOldKey];
    id new = [change objectForKey:NSKeyValueChangeNewKey];
    
    self.block(object, old, new);
    
}

@end




@implementation NSObject (YMAddForKVO)

- (void)addObserverForKeyPath:(NSString *)keyPath block:(ObserverBlock)block {
    
    if(!keyPath || !block) {
      
        return;
    }
    _YMObserverTarget *target = [[_YMObserverTarget alloc] initWithBlock:block];
    NSMutableDictionary *targetsDict = [self _ymAllObserverObject];
    NSMutableArray *targets = targetsDict[keyPath];
    if(!targets) {
        //同一对象在多个不同的文件监视同一属性时，数组中存放不同的target
        targets = [[NSMutableArray alloc] initWithCapacity:0];
        targetsDict[keyPath] = target;
    }
    [targets addObject:target];
    
    [self addObserver:target forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld  context:NULL];
    
}

- (void)removeObserverForKeyPath:(NSString *)keyPath {
   
    if (!keyPath) {
        
        return;
    }
    
    NSMutableDictionary *targetsDict = [self _ymAllObserverObject];
    NSMutableArray *array = targetsDict[keyPath];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self removeObserver:obj forKeyPath:keyPath];
    }];
    
    [targetsDict removeObjectForKey:keyPath];
    
}


- (void)removeAllObserver {
   
    NSMutableDictionary *targetsDict = [self _ymAllObserverObject];
    [targetsDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSArray* array, BOOL * _Nonnull stop) {
        
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self removeObserver:obj forKeyPath:key];
        }];
        
    }];

    
}






- (NSMutableDictionary *) _ymAllObserverObject {
    
    NSMutableDictionary *targets = objc_getAssociatedObject(self, block_key);
    if (!targets) {
        
        targets = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return targets;
}



@end

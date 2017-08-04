//
//  OTDictionary.m
//  Various-OC
//
//  Created by YmWw on 2017/8/4.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import "OTDictionary.h"

@interface OTDictionary()
@property (nonatomic, strong) NSMutableDictionary *innerDictionary;
@end
@implementation OTDictionary

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    
    NSAssert(dict != nil, @"The dictionary can not be Nil");
    self.innerDictionary = [[NSMutableDictionary alloc] initWithDictionary:dict];
    
    return self;
    
}

- (id)objectForKeyedSubscript:(NSString *)key {
    
    if(!key) return nil;
    
    if ([self.innerDictionary[key] isEqual:[NSNull null]]) {
        
        return nil;
    }
    
    return self.innerDictionary[key];
}

- (void)setObject:(id)obj forKeyedSubscript:(NSString *)key {
   
    NSAssert(obj != nil, @"The object can't be Nil");
    NSAssert(![obj isEqual:[NSNull null]], @"The Object can't be NULL");
    
    
}

- (void)removeObjectForKey:(NSString *)aKey {
    
    [self.innerDictionary removeObjectForKey:aKey];

}
- (void)setObject:(id)anObject forKey:(NSString *)aKey {
  
    [self.innerDictionary setObject:anObject forKey:aKey];
}

- (void)removeAllObjects {
  
    [self.innerDictionary removeAllObjects];
}

- (id)objectForKey:(NSString *)key defaultValue:(id)defaultValue {
   
    if (self.innerDictionary[key] == nil || [self.innerDictionary[key] isEqual:[NSNull null]]) {
        
        return defaultValue;
    }
    return self.innerDictionary[key];
}


- (void)setForKey:(NSString *)key value:(id)value defaultValue:(id)defaultValue {
    
    if (value == nil || [value isEqual:[NSNull null]]) {
        
        self.innerDictionary[key] = defaultValue;
    } else {
      
        self.innerDictionary[key] = defaultValue;
    }
    
}



@end

//
//  OTDictionary.h
//  Various-OC
//
//  Created by YmWw on 2017/8/4.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTDictionary : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (id)objectForKeyedSubscript:(NSString *)key;
- (void)setObject:(id)obj forKeyedSubscript:(NSString *)key;
- (void)removeObjectForKey:(NSString *)aKey;
- (void)setObject:(id)anObject forKey:(NSString *)aKey;
- (void)removeAllObjects;
- (id)objectForKey:(NSString *)key defaultValue:(id)defaultValue;
- (void)setForKey:(NSString *)key value:(id)value defaultValue:(id)defaultValue;
@end

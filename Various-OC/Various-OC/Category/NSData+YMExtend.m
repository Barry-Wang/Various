//
//  NSData+YMExtend.m
//  Various-OC
//
//  Created by WangWei on 13/7/17.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import "NSData+YMExtend.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSData (YMExtend)

- (NSString *)md5String {
   
    unsigned char result [CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, CC_MD5_DIGEST_LENGTH, result);
    
    NSMutableString *resultString = [[NSMutableString alloc] initWithCapacity:0];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        
        [resultString appendFormat:@"%02x", result[i]];
    }
    
    return resultString;
}

- (NSData *)md5Data {
   
    unsigned char result [CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, CC_MD5_DIGEST_LENGTH, result);
    return [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)shaString:(SHACATEGORY)category {
    
    switch (category) {
            
        case TWO_TWO_FOUR: {
            
            unsigned char result[CC_SHA224_DIGEST_LENGTH];
            CC_SHA224(self.bytes, CC_SHA224_DIGEST_LENGTH, result);
            NSMutableString *resultString = [[NSMutableString alloc] initWithCapacity:0];
            for (int i = 0; i < CC_SHA224_DIGEST_LENGTH; i++) {
                
                [resultString appendFormat:@"%02x", result[i]];
                
            }
            return resultString;
        } break;
            
        case TWO_FIVE_SIX: {
            
            unsigned char result[CC_SHA256_DIGEST_LENGTH];
            CC_SHA256(self.bytes, CC_SHA256_DIGEST_LENGTH, result);
            NSMutableString *resultString = [[NSMutableString alloc] initWithCapacity:0];
            for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
                
                [resultString appendFormat:@"%02x", result[i]];
                
            }
            return resultString;        }break;
            
        case THREE_EIGHT_FOUR:{
            
            unsigned char result[CC_SHA384_DIGEST_LENGTH];
            CC_SHA384(self.bytes, CC_SHA384_DIGEST_LENGTH, result);
            NSMutableString *resultString = [[NSMutableString alloc] initWithCapacity:0];
            for (int i = 0; i < CC_SHA384_DIGEST_LENGTH; i++) {
                
                [resultString appendFormat:@"%02x", result[i]];
                
            }
            return resultString;        }break;
            
            
        case FIVE_ONE_TWO: {
            
            unsigned char result[CC_SHA512_DIGEST_LENGTH];
            CC_SHA512(self.bytes, CC_SHA512_DIGEST_LENGTH, result);
            NSMutableString *resultString = [[NSMutableString alloc] initWithCapacity:0];
            for (int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
                
                [resultString appendFormat:@"%02x", result[i]];
                
            }
            return resultString;        }
        default:
            return nil;
    }
}


- (NSData *)shaData:(SHACATEGORY)category {
    
    
    switch (category) {
            
        case TWO_TWO_FOUR: {
            
            unsigned char result[CC_SHA224_DIGEST_LENGTH];
            CC_SHA224(self.bytes, CC_SHA224_DIGEST_LENGTH, result);
            return [NSData dataWithBytes:result length:CC_SHA224_DIGEST_LENGTH];
        } break;
            
        case TWO_FIVE_SIX: {
           
            unsigned char result[CC_SHA256_DIGEST_LENGTH];
            CC_SHA256(self.bytes, CC_SHA256_DIGEST_LENGTH, result);
            return [NSData dataWithBytes:result length:CC_SHA256_DIGEST_LENGTH];
        }break;
            
        case THREE_EIGHT_FOUR:{
            
            unsigned char result[CC_SHA384_DIGEST_LENGTH];
            CC_SHA384(self.bytes, CC_SHA384_DIGEST_LENGTH, result);
            return [NSData dataWithBytes:result length:CC_SHA384_DIGEST_LENGTH];
        }break;
            
        
        case FIVE_ONE_TWO: {
           
            unsigned char result[CC_SHA512_DIGEST_LENGTH];
            CC_SHA512(self.bytes, CC_SHA512_DIGEST_LENGTH, result);
            return [NSData dataWithBytes:result length:CC_SHA512_DIGEST_LENGTH];
        }
        default:
            return nil;
    }
}

- (NSData *)shaData {
  
    return [self shaData:TWO_TWO_FOUR];
}



@end

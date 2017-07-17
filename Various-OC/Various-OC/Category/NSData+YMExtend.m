//
//  NSData+YMExtend.m
//  Various-OC
//
//  Created by WangWei on 13/7/17.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import "NSData+YMExtend.h"


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

- (NSString *)crc32String {
   
   uLong result =  crc32(0, self.bytes, (uint)self.length);
    return [NSString stringWithFormat:@"%08x", (UInt32)result];
    
}

- (uLong)crc32 {
   
    return   crc32(0, self.bytes, (uint)self.length);
}

- (NSData *)aes256EncryptWithKey:(NSData *)key iv:(NSData *)iv {
    
    return [self ase256CryptOperation:kCCEncrypt key:key iv:iv];
    
}

-(NSData *)deCryptWithKey:(NSData *)key iv:(NSData *)iv {
   
    return [self ase256CryptOperation:kCCDecrypt key:key iv:iv];
}

- (NSData *)ase256CryptOperation:(CCOperation)operation key:(NSData *)key iv:(NSData *)iv {
    
   
    if (key.length == 0 || key.length % 16 != 0) {
        
        return nil;
    }
    
    if (iv.length != 0 && iv.length != 16) {
        
        return  nil;
    }
    
    size_t bufferSize = self.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t criptSize = 0;
    
    
  CCCryptorStatus cryptStatus =   CCCrypt(operation, kCCAlgorithmAES128, kCCOptionPKCS7Padding, key.bytes, key.length, iv.bytes, self.bytes,self.length, buffer, bufferSize, &criptSize);
    
    if (cryptStatus == kCCSuccess) {
        
        return  [NSData dataWithBytes:buffer length:criptSize];
    } else {
      
        return nil;
    }
}

-(NSString *)utf8String {
  
    if (self.length == 0) {
        
        return @"";
    }
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

-(NSString *)hexString {
   
    NSMutableString *result = [[NSMutableString alloc] initWithCapacity:self.length * 2];
    const unsigned char *byte = self.bytes;
    for (int i = 0; i < self.length ; i++) {
        
        [result appendFormat:@"%02x", byte[i]];
    }
    
    return  result.copy;
}













@end

//
//  NSData+YMExtend.h
//  Various-OC
//
//  Created by WangWei on 13/7/17.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import <zlib.h>

typedef NS_ENUM(NSInteger, SHACATEGORY) {
  
    TWO_TWO_FOUR =  0,
    TWO_FIVE_SIX = 1,
    THREE_EIGHT_FOUR = 2,
    FIVE_ONE_TWO = 3,
    
};


@interface NSData (YMExtend)

- (NSString *)md5String;
- (NSData *)shaData;
- (NSString *)shaString:(SHACATEGORY)category;
- (NSData *)shaData:(SHACATEGORY)category;

/*   must import lib.tbd
 */
- (uLong)crc32;
- (NSData *)aes256EncryptWithKey:(NSData *)key iv:(NSData *)iv;
- (NSData *)deCryptWithKey:(NSData *)key iv:(NSData *)iv;

-(NSString *)utf8String;
-(NSString *)hexString;
@end

//
//  YYMac.h
//  Various-OC
//
//  Created by WangWei on 15/6/17.
//  Copyright © 2017年 WangWei. All rights reserved.
//


#import <Foundation/Foundation.h>

#ifndef YYMac_h
#define YYMac_h



#ifdef cplusplus

#define YM_C_EXTERN_BEGIN  extern "C" {
#define YM_C_EXTERN_END     }

#else 

#define YM_C_EXTERN_BEGIN
#define YM_C_EXTERN_END

#endif




YM_C_EXTERN_BEGIN

#define  YM_Middle(_x_, _small_, _large_)   ((_x_) > (_large_)) ? _large_ : ((_x_) < (_small_)) ? (_small_) : (_x_)


#define YM_Swap(_a_, _b_) { __typeof__(_a_) _t_ = _a_; (_a_) = (_b_); (_b_) = (_t_); }

#define YMAssertNil(condition, description, ...) NSAssert(!(condition), (description), ##__VA_ARGS__)

#define YMCAssertNil(condition, description, ...) NSCAssert(!(codintion), (description), ##__VA_ARGS__)

#define YMAssertNotNil(condition, description, ...) NSAssert((condition), (description), ##__VA_ARGS__)
#define YMCAssertNotNil(condition, description, ...) NSCAssert((codintion), (description), ##__VA_ARGS__)

#define YMAssertMainThread() NSAssert([NSThread isMainThread], @"This method must be called in Main Thread!")

#define YMCAssertMainThread() NSCAssert([NSThread isMainThread], @"This method must be called in Main Thread!")


#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif


YM_C_EXTERN_END


#endif /* YYMac_h */

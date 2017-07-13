//
//  NSString+count.h
//  Va_Sl
//
//  Created by WangWei on 11/7/17.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef YYSYNTH_DUMMY_CLASS
#define YYSYNTH_DUMMY_CLASS(_name_) \
@interface YYSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation YYSYNTH_DUMMY_CLASS_ ## _name_ @end
#endif



@interface NSString (count)
- (void)printSomeThing;
@end

//
//  ViewController.m
//  Various-OC
//
//  Created by WangWei on 15/6/17.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import "ViewController.h"
#import "YYMac.h"
#import "Va_Sl.h"
#import "NSObject+YMAddForKVO.h"
#import "NSData+YMExtend.h"
#import "YMTopTab.h"
#import "OTDictionary.h"
#import "NSDictionary+safe.h"


@interface ViewController ()<printProtocaolDelegate, YMTopTabDelegate, UIScrollViewDelegate>
@property (nonatomic, assign) NSTimeInterval currentTime;
@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) YMTopTab *topTab;
@property (nonatomic, strong) NSMutableArray *numberStack;
@property (nonatomic, strong) NSMutableArray *operationStack;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    NSString *name;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"name"] = @2;
}


- (BOOL)ispority:(NSString *)top second:(NSString *)second {
   
  //等级顺序 + - * /
    
    
    if ([top isEqualToString:@"*"]) {
        
        if ([second isEqualToString:@"/"]) {
            
            return NO;
            
        } else {
            
            return YES;
            
        }
    } else if ([top isEqualToString:@"/"]) {
        
        if ([second isEqualToString:@"/"]) {
            
            return NO;
        } else {
            
            return  YES;
        }
    } else if ([top isEqualToString:@"-"]) {
        
        if ([second isEqualToString:@"+"]) {
           
            return  YES;
            
        } else {
            
            return  NO;
        }
    }
    return NO;
    
    return NO;
}

- (float)operation:(NSString*)op firstNumber:(NSString *)firstNumber secondNumber:(NSString *)secondNumber {
    
    if ([op isEqualToString:@"+"]) {
        
        return [firstNumber floatValue] + [secondNumber floatValue];
    } else if ([op isEqualToString:@"-"]) {
      
        return [firstNumber floatValue] - [secondNumber floatValue];
    } else if ([op isEqualToString:@"*"]) {
        
        return [firstNumber floatValue] * [secondNumber floatValue];
        
    }  else if ([op isEqualToString:@"/"]) {
        
        return [firstNumber floatValue] / [secondNumber floatValue];
    }
    
    return 0;
}

- (float)calculate:(NSString *)expression {
    
    
    NSMutableArray *arry = [[NSMutableArray alloc] initWithArray:[expression componentsSeparatedByString:@" "]];
    if (![self isPureFloat:[arry lastObject]]) {
     
        [arry removeLastObject];
    }
    for (NSString *str in arry) {
        
        if ([self isPureFloat:str]) {
            
            [self.numberStack insertObject:@([str floatValue]) atIndex:0];
            
        } else {
            
            if (self.operationStack.count == 0) {
                
                [self.operationStack insertObject:str atIndex:0];
                
            } else {
                
                while (self.operationStack.count > 0 && ![self ispority:str second:[self.operationStack objectAtIndex:0]]) {
                    
                    float result = [self operation:self.operationStack[0] firstNumber:self.numberStack[1] secondNumber:self.numberStack[0]];
                    [self.numberStack removeObjectAtIndex:0];
                    [self.numberStack removeObjectAtIndex:0];
                    [self.numberStack insertObject:@(result) atIndex:0];
                    [self.operationStack removeObjectAtIndex:0];
                }
                
                [self.operationStack insertObject:str atIndex:0];

                
            }
            
            
            
        }
        
    }

    
    CGFloat result = [self.operationStack.firstObject floatValue];
    while (self.operationStack.count > 0) {
        
        NSString *operate = self.operationStack[0];
        
        result = [self operation:operate firstNumber:self.numberStack[1] secondNumber:self.numberStack[0]];
        [self.numberStack removeObjectAtIndex:0];
        [self.numberStack removeObjectAtIndex:0];
        [self.numberStack insertObject:@(result) atIndex:0];
        
        [self.operationStack removeObjectAtIndex:0];
    }
    return result;
}

- (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
//判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

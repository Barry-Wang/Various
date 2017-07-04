//
//  NSObject+YMExtend.m
//  Various-OC
//
//  Created by WangWei on 30/6/17.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import "NSObject+YMExtend.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>



@implementation NSObject (YMExtend)


#define INIT_INVOCATION(_last_arg_, _return_) \
NSMethodSignature *signature = [self methodSignatureForSelector:sel];\
if (!signature) {\
[self doesNotRecognizeSelector:sel];\
return _return_;\
}\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];\
if (!invocation) {\
[self doesNotRecognizeSelector:sel];\
return _return_;\
}\
[invocation setTarget:self];\
[invocation setSelector:sel];\
va_list args;\
va_start(args, _last_arg_);\
[self setInvocation:invocation signature:signature args:args];\
va_end(args);


- (id)performSelectorWithArgs:(SEL)sel, ...{
    
    INIT_INVOCATION(sel, nil);
    [invocation invoke];
    return [NSObject getReturnFromInv:invocation withSig:signature];
}

- (void)performSelectorWithArgs:(SEL)sel afterDelay:(NSTimeInterval)delay, ... {
   
    INIT_INVOCATION(delay,);
    [invocation retainArguments];
    [invocation performSelector:@selector(invocation) withObject:nil afterDelay:delay];
    
}

- (id)performSelectorWithArgsInMainThred:(SEL)sel waitUntilDone:(BOOL)waitUntilDone, ... {
    
    INIT_INVOCATION(waitUntilDone, nil);
    if (!waitUntilDone) {
        
        [invocation retainArguments];
    }
    
    // waitUntilDone  YES, 阻塞该线程返回结果.  NO 不阻塞线程返回 nil.
    
    [invocation performSelectorOnMainThread:@selector(invocation) withObject:nil waitUntilDone:waitUntilDone];
    
    return waitUntilDone ? [NSObject getReturnFromInv:invocation withSig:signature] : nil;
    
}

- (id)performSelectorInThreadWithArgs:(SEL)sel thread:(NSThread *)thread waitUntilDone:(BOOL)waitUntilDone, ...{
    
    INIT_INVOCATION(waitUntilDone, nil);
    
    if (!waitUntilDone) {
        
        [invocation retainArguments];
    }
    
    [invocation performSelector:@selector(invocation) onThread:thread withObject:nil waitUntilDone:waitUntilDone];
    
    return waitUntilDone ? [NSObject getReturnFromInv:invocation withSig:signature] : nil;
    
}

- (void)performSelectorWithArgsInBackground:(SEL)sel, ...{
    
    INIT_INVOCATION(sel,);
    [invocation retainArguments];
    [invocation performSelectorInBackground:@selector(invocation) withObject:nil ];
}




#undef INIT_INV

+ (id)getReturnFromInv:(NSInvocation *)inv withSig:(NSMethodSignature *)sig {
    
    NSUInteger length = [sig methodReturnLength];
    if (length == 0) return nil;
    
    char *type = (char *)[sig methodReturnType];
    while (*type == 'r' || // const
           *type == 'n' || // in
           *type == 'N' || // inout
           *type == 'o' || // out
           *type == 'O' || // bycopy
           *type == 'R' || // byref
           *type == 'V') { // oneway
        type++; // cutoff useless prefix
    }
    
#define return_with_number(_type_) \
do { \
_type_ ret; \
[inv getReturnValue:&ret]; \
return @(ret); \
} while (0)
    
    switch (*type) {
        case 'v': return nil; // void
        case 'B': return_with_number(bool);
        case 'c': return_with_number(char);
        case 'C': return_with_number(unsigned char);
        case 's': return_with_number(short);
        case 'S': return_with_number(unsigned short);
        case 'i': return_with_number(int);
        case 'I': return_with_number(unsigned int);
        case 'l': return_with_number(int);
        case 'L': return_with_number(unsigned int);
        case 'q': return_with_number(long long);
        case 'Q': return_with_number(unsigned long long);
        case 'f': return_with_number(float);
        case 'd': return_with_number(double);
        case 'D': { // long double
            long double ret;
            [inv getReturnValue:&ret];
            return [NSNumber numberWithDouble:ret];
        };
            
        case '@': { // id
            id ret = nil;
            [inv getReturnValue:&ret];
            return ret;
        };
            
        case '#': { // Class
            Class ret = nil;
            [inv getReturnValue:&ret];
            return ret;
        };
            
        default: { // struct / union / SEL / void* / unknown
            const char *objCType = [sig methodReturnType];
            char *buf = calloc(1, length);
            if (!buf) return nil;
            [inv getReturnValue:buf];
            NSValue *value = [NSValue valueWithBytes:buf objCType:objCType];
            free(buf);
            return value;
        };
    }
#undef return_with_number
}

- (void)setInvocation:(NSInvocation *)invocation signature:(NSMethodSignature *)signature args:(va_list)args {
    
    NSUInteger count = [signature numberOfArguments];
    
    // the first is TARGET and the second is the SEL
    for (NSUInteger  index = 2; index < count; index++) {
        
        char *type = (char *)[signature getArgumentTypeAtIndex:index];
        
        while (*type == 'r'  ||
               *type == 'R'  ||
               *type == 'o'  ||
               *type == 'O'  ||
               *type == 'n'  ||
               *type == 'N'  ||
               *type == 'V'
               
               ) {
            
            type++;
        }
        
        BOOL unsupportedType = NO;
        
        
        switch (*type) {
                
            case 'c':    //char
            case 'C':    // unsigned char
            case 's':    //short
            case 'S':    // unsigned short
            case 'v':    //void
            case 'B':    //BOOL
            case 'i': {       //int
                
                int arg  = va_arg(args, int);
                [invocation setArgument:&arg atIndex:index];
            } break;
                
                
            case 'I': {
                
                unsigned int arg = va_arg(args, unsigned int);
                [invocation setArgument:&arg atIndex:index];
                
            }break;
                
                
            case 'l': {  //long
                
                long arg = va_arg(args, long);
                [invocation setArgument:&arg atIndex:index];
                
            }break;
                
            case 'L': {  // unsgined long
                
                unsigned long arg = va_arg(args, unsigned long);
                [invocation setArgument:&arg atIndex:index];
                
            }
                
            case 'q' :{    // long long
                
                long long arg = va_arg(args, long long);
                [invocation setArgument:&arg atIndex:index];
            }
                
            case 'Q': {    // unsigned long long
                
                unsigned long long arg = va_arg(args, unsigned long long);
                [invocation setArgument:&arg atIndex:index];
            }
                
            case 'f':    // float
            case 'd': {   //double
                
                double arg = va_arg(args, double);
                [invocation setArgument:&arg atIndex:index];
                
            }break;
                
            case 'D': // 16: long double
            {
                long double arg = va_arg(args, long double);
                [invocation setArgument:&arg atIndex:index];
            } break;
                
            case '*':    //char string
            case '^': {  // pointer
                
                void *arg = va_arg(args, void *);
                [invocation setArgument:&arg atIndex:index];
            }break;
                
            case '@': {   //object
                
                id arg = va_arg(args, id);
                [invocation setArgument:&arg atIndex:index];
            }break;
                
            case '#' : {  //class
                
                Class arg = va_arg(args, Class);
                [invocation setArgument:&arg atIndex:index];
                
            }break;
                
            case ':' :{ //selector
                
                SEL arg = va_arg(args, SEL);
                [invocation setArgument:&arg atIndex:index];
                
            }
                
            case '{': // struct
            {
                if (strcmp(type, @encode(CGPoint)) == 0) {
                    CGPoint arg = va_arg(args, CGPoint);
                    [invocation  setArgument:&arg atIndex:index];
                } else if (strcmp(type, @encode(CGSize)) == 0) {
                    CGSize arg = va_arg(args, CGSize);
                    [invocation  setArgument:&arg atIndex:index];
                } else if (strcmp(type, @encode(CGRect)) == 0) {
                    CGRect arg = va_arg(args, CGRect);
                    [invocation  setArgument:&arg atIndex:index];
                } else if (strcmp(type, @encode(CGVector)) == 0) {
                    CGVector arg = va_arg(args, CGVector);
                    [invocation  setArgument:&arg atIndex:index];
                } else if (strcmp(type, @encode(CGAffineTransform)) == 0) {
                    CGAffineTransform arg = va_arg(args, CGAffineTransform);
                    [invocation  setArgument:&arg atIndex:index];
                } else if (strcmp(type, @encode(CATransform3D)) == 0) {
                    CATransform3D arg = va_arg(args, CATransform3D);
                    [invocation  setArgument:&arg atIndex:index];
                } else if (strcmp(type, @encode(NSRange)) == 0) {
                    NSRange arg = va_arg(args, NSRange);
                    [invocation  setArgument:&arg atIndex:index];
                } else if (strcmp(type, @encode(UIOffset)) == 0) {
                    UIOffset arg = va_arg(args, UIOffset);
                    [invocation  setArgument:&arg atIndex:index];
                } else if (strcmp(type, @encode(UIEdgeInsets)) == 0) {
                    UIEdgeInsets arg = va_arg(args, UIEdgeInsets);
                    [invocation  setArgument:&arg atIndex:index];
                } else {
                    unsupportedType = YES;
                }
            } break;
                
            case '(': // union
            {
                unsupportedType = YES;
            } break;
                
            case '[': // array
            {
                unsupportedType = YES;
            } break;
                
            default: // what?!
            {
                unsupportedType = YES;
            } break;
        }
        
    }
}


//在+load中调用
- (void)swizzInstanceMethod:(SEL)originSelector new:(SEL)newSelector {
   
   
    Class class = [self class];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method  originMethod = class_getInstanceMethod(class, originSelector);
        Method  newMethod = class_getInstanceMethod(class, newSelector);
        
        BOOL didAddMethod = class_addMethod(class, newSelector, class_getMethodImplementation(class, newSelector),method_getTypeEncoding(newMethod));
        
        if (didAddMethod) {
            
            class_replaceMethod(class, newSelector, class_getMethodImplementation(class, originSelector), method_getTypeEncoding(originMethod));
        } else {
           
            method_exchangeImplementations(newMethod, originMethod);
        }
        
    });
}


- (void)swizzClassMethod:(SEL)originSelector new:(SEL)newSelector {
    
    Class class = [self class];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method originMethod = class_getClassMethod(class, originSelector);
        Method newMethod = class_getClassMethod(class, newSelector);
        
        BOOL didAddMethod = class_addMethod(class, newSelector, class_getMethodImplementation(class, newSelector),method_getTypeEncoding(newMethod));
        
        if (didAddMethod) {
            
            class_replaceMethod(class, newSelector, class_getMethodImplementation(class, originSelector), method_getTypeEncoding(originMethod));
        } else {
            
            method_exchangeImplementations(newMethod, originMethod);
        }
        
    });
}

- (void)setAssociateValue:(id)value key:(char *)key {
    
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setWeakAssociateValue:(id)value key:(char *)key {
   
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (id)getAssociateValueWithKey:(NSString *)key {
  
   return  objc_getAssociatedObject(self, [key UTF8String]);
}

- (void)removeAssocaiteValues {
   
    objc_removeAssociatedObjects(self);
}



@end

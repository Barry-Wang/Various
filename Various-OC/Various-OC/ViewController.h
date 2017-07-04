//
//  ViewController.h
//  Various-OC
//
//  Created by WangWei on 15/6/17.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol printProtocaolDelegate <NSObject>

- (void)printWithName:(NSString *)name age:(NSUInteger)age;

@end

@interface ViewController : UIViewController


@end


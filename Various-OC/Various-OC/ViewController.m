//
//  ViewController.m
//  Various-OC
//
//  Created by WangWei on 15/6/17.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import "ViewController.h"
#import "YYMac.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *view = nil;
    NSLog(@"%d", YM_Middle(10, 5, 20));

    NSLog(@"%d", YM_Middle(10, 15, 20));
    
    int a = 5, b = 0;
    YM_Swap(a, b);
    
    NSLog(@"a = %d, b = %d", a, b);
    
    
    NSThread *seperatorThread = [[NSThread alloc] initWithTarget:self selector:@selector(print) object:nil];
    [seperatorThread start];
    
}

- (void)print {
   
 

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

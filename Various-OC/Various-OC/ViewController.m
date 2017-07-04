//
//  ViewController.m
//  Various-OC
//
//  Created by WangWei on 15/6/17.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import "ViewController.h"
#import "YYMac.h"


@interface ViewController ()<printProtocaolDelegate>
@property (nonatomic, assign) NSTimeInterval currentTime;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self performSelector:@selector(outPut) withObject:nil afterDelay:1];

      //  [self performSelectorOnMainThread:@selector(printMain) withObject:nil waitUntilDone:NO];
        
    });
    
}

- (void)printSomething:(NSInteger)index name:(NSString *)name {
    
    NSLog(@"%f",[[NSDate date] timeIntervalSince1970] - self.currentTime);
   
    NSLog(@"可以处理这个方法了");
}

- (void)outPut {
   
    
    for (int i = 0; i < 100; i++) {
       
        NSLog(@"------------------");
    }

}

- (void)printMain {

    for (int i = 0; i < 100000; i++) {
        
        NSLog(@"1111111111111111111111111111");
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

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

@interface ViewController ()<printProtocaolDelegate>
@property (nonatomic, assign) NSTimeInterval currentTime;
@property (nonatomic, assign) NSInteger value;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 60, 100, 100);
    [button addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    
    
    self.value = 1;
    [self addObserverForKeyPath:@"value" block:^(__weak id object, id oldValue, id newValue) {
        
        NSLog(@"come here");
    }];
    
}

-(void)change {
   
    self.value = 10 - self.value;
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

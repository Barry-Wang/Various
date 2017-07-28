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

@interface ViewController ()<printProtocaolDelegate>
@property (nonatomic, assign) NSTimeInterval currentTime;
@property (nonatomic, assign) NSInteger value;
@end

@implementation ViewController

- (void)viewDidLoad {
    
//    [super viewDidLoad];
//    NSString *str = @"Hello,World";
//    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"%@",[data hexString]);
    
    
    YMTopTab *tab = [[YMTopTab alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 40)];
    tab.titles = @[@"推荐", @"视频", @"NBA", @"法律节目"];
    tab.fillout = NO;
    [self.view addSubview:tab];
    
}


-(void)change {
   
    self.value = 10 - self.value;
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

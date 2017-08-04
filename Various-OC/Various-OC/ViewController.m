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

@interface ViewController ()<printProtocaolDelegate, YMTopTabDelegate>
@property (nonatomic, assign) NSTimeInterval currentTime;
@property (nonatomic, assign) NSInteger value;
@end

@implementation ViewController

- (void)viewDidLoad {
    
//    [super viewDidLoad];
//    NSString *str = @"Hello,World";
//    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"%@",[data hexString]);
    
    
//    YMTopTab *tab = [[YMTopTab alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 40)];
//    tab.titles = @[@"推荐", @"视频", @"NBA", @"法律节目",@"推荐", @"视频", @"NBA", @"法律节目"];
//    tab.delegate = self;
// //   tab.fillout = NO;
//    tab.style = SLIDER;
//    [self.view addSubview:tab];
    
    OTDictionary *dict = [[OTDictionary alloc] initWithDictionary:@{@"11":@"yaoming"}];
    NSLog(@"%@",dict[@"11"]);
    
    [dict setForKey:@"456" value:nil defaultValue:@"djkldkasjdaskdlsakld"];

    
  NSLog(@"===%@",  [dict objectForKey:@"34" defaultValue:@"1234"]) ;
    
}


-(void)change {
   
    self.value = 10 - self.value;
}

- (void)didSelecteItemAtIndex:(NSUInteger)index title:(NSString *)title {
    
    NSLog(@"index = %d, titile = %@", index, title);
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

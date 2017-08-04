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

@interface ViewController ()<printProtocaolDelegate, YMTopTabDelegate, UIScrollViewDelegate>
@property (nonatomic, assign) NSTimeInterval currentTime;
@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) YMTopTab *topTab;
@end

@implementation ViewController

- (void)viewDidLoad {
    
//    [super viewDidLoad];
//    NSString *str = @"Hello,World";
//    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"%@",[data hexString]);
    
    
    YMTopTab *tab = [[YMTopTab alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 40)];
    tab.titles = @[@"推荐", @"视频", @"NBA", @"法律节目",@"推荐", @"视频", @"NBA", @"法律节目"];
    tab.selectedFont = [UIFont systemFontOfSize:18.0];
    tab.delegate = self;
 //   tab.fillout = NO;
    tab.style = BiGSLIDER;
    [self.view addSubview:tab];
    
    self.topTab = tab;
    
    self.colors = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor purpleColor], [UIColor yellowColor], [UIColor grayColor], [UIColor redColor], [UIColor greenColor]];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 140, self.view.frame.size.width, self.view.frame.size.height - 140)];
    scrollView.contentSize = CGSizeMake(8 * self.view.frame.size.width, scrollView.frame.size.height);
    for (int i = 0; i < 8; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame: CGRectMake(i * scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
        view.backgroundColor = self.colors[i];
        [scrollView addSubview:view];
        
    }
    scrollView.pagingEnabled = YES;
    
    scrollView.delegate = self;
    
    [self.view addSubview:scrollView];
    
    
}


-(void)change {
   
    self.value = 10 - self.value;
}

- (void)didSelecteItemAtIndex:(NSUInteger)index title:(NSString *)title {
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   
    [self.topTab adpatScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  
    [self.topTab adpatScrollViewDidEndScroll:scrollView];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

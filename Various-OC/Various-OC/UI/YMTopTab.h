//
//  YMTopTab.h
//  Various-OC
//
//  Created by YmWw on 2017/7/25.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMTopTab : UIView
@property (nonatomic, strong) NSArray *titles;      //要显示的标题
@property (nonatomic, strong) UIFont *normalFont;   //正常状态下标题字体的大小
@property (nonatomic, strong) UIFont *selectedFont; //选中状态下标题字体的大小
@property (nonatomic, assign) CGFloat topGap;
@property (nonatomic, assign) CGFloat bottomGap;
@end

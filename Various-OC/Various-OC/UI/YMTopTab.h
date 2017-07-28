//
//  YMTopTab.h
//  Various-OC
//
//  Created by YmWw on 2017/7/25.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMTopTab : UIView
@property (nonatomic, strong) NSArray *titles;      //The showd titles

@property (nonatomic, strong) UIFont *normalFont;
@property (nonatomic, strong) UIFont *selectedFont;

@property (nonatomic, assign) CGFloat topGap;     // the gap between the title top and self top
@property (nonatomic, assign) CGFloat bottomGap;  // the gap between the title bottom and self bottom

/*
  wether the titles fill out all the width when the titles total length less then the width.  default YES
 */
@property (nonatomic, assign) BOOL fillout;

/*
 
 the space between the title.it does not work when fillout is YES.
 @default 10
 
 */
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
@end
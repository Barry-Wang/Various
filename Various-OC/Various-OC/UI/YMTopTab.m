//
//  YMTopTab.m
//  Various-OC
//
//  Created by YmWw on 2017/7/25.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import "YMTopTab.h"
#import "YMTopTabCell.h"

#define BUTTON_PLUS 10

@interface YMTopTab()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL byendWidth;  // wether the total lenght of the titles byend the collectionview width
@property (nonatomic, assign) CGFloat notByendGap; // the lefted width divide the titles count
@property (nonatomic, assign) CGSize titleSize;
@property (nonatomic, assign) BOOL isFirstSelected; // if you set the selected in the initWithFrame, when  call didSelect, it will never call didDeselected, so this variable indicate that wether it called didDeselected.

@end

@implementation YMTopTab

- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
      

        [self creatCollectionView];
        
        self.backgroundColor = [UIColor yellowColor];
        self.topGap = 5;
        self.bottomGap = 4;
        self.fillout = YES;
        
        self.normalFont = [UIFont systemFontOfSize:18.0f];
        self.selectedFont = [UIFont systemFontOfSize:18.0f];
        self.normalColor = [UIColor blackColor];
        self.selectedColor = [UIColor redColor];
        self.isFirstSelected = YES;
        
    }
    
    return self;
}

- (void)setTitles:(NSArray *)titles {
    
    _titles = titles;
    NSAssert(titles.count > 0, @"tittles must have at least one");
    
    NSString *title = titles.firstObject;
    CGSize titleSize =  [title sizeWithAttributes:@{NSFontAttributeName:self.selectedFont}];
    
    self.titleSize = titleSize;
    CGSize size = self.collectionView.frame.size;
    size.height = titleSize.height;
    
    [self calculateWidth];
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, size.height + self.topGap + self.bottomGap);
    
    [self setNeedsLayout];
    
    [self.collectionView reloadData];
}

- (void)setTopGap:(CGFloat)topGap {
    
    _topGap = topGap;
    
    if (self.titles.count > 0) {
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.titleSize.height + self.topGap + self.bottomGap);
        
        [self setNeedsLayout];
        [self.collectionView reloadData];
    }
}


- (void)setBottomGap:(CGFloat)bottomGap {
   
    _bottomGap = bottomGap;
    
    if (self.titles.count > 0) {
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.titleSize.height + self.topGap + self.bottomGap);
        
        [self setNeedsLayout];
        [self.collectionView reloadData];
    }
}

- (void)calculateWidth {
    
    CGFloat width = 0;
    
    for (NSString *title in self.titles) {
        
        CGSize titleSize =  [title sizeWithAttributes:@{NSFontAttributeName:self.selectedFont}];
        width += titleSize.width;
    }
    self.byendWidth =  width > self.collectionView.frame.size.width;
    
    
    UICollectionViewFlowLayout *flowLayout =  (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    if (!self.byendWidth && self.fillout == YES) {

        self.notByendGap = (self.collectionView.frame.size.width - width) / self.titles.count;
        
        flowLayout.minimumInteritemSpacing = 0;

        
    } else {
       
        flowLayout.minimumInteritemSpacing = 10;

        
    }
    

}

- (void)layoutSubviews {
   
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, self.topGap, self.frame.size.width, self.frame.size.height - self.topGap - self.bottomGap);
}
- (void)creatCollectionView {
   
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing  = 0;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    [collectionView registerClass:[YMTopTabCell class] forCellWithReuseIdentifier:@"YMTopTabCell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView = collectionView;
    
    [self addSubview:collectionView];
}





#pragma  mark CollectionView Delegate and DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    YMTopTabCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YMTopTabCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.titles[indexPath.row];
    [self setCellSelectedStatus:cell selected:self.selectedIndex == indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = self.titles[indexPath.row];
    
    CGSize titleSize =  [title sizeWithAttributes:@{NSFontAttributeName:self.selectedFont}];
    

    if (self.byendWidth || self.fillout == NO) {
        

        return  CGSizeMake(titleSize.width + BUTTON_PLUS, titleSize.height);
        
    } else {
    
        return CGSizeMake(titleSize.width + self.notByendGap, collectionView.frame.size.height);
    }

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isFirstSelected) {
        
        YMTopTabCell *cell = (YMTopTabCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]];
        [self setCellSelectedStatus:cell selected:NO];
    }
    
    YMTopTabCell *cell = (YMTopTabCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    self.selectedIndex = indexPath.row;
    [self setCellSelectedStatus:cell selected:YES];
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    YMTopTabCell *cell = (YMTopTabCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [self setCellSelectedStatus:cell selected:NO];
    self.isFirstSelected = NO;
}

- (void)setCellSelectedStatus:(YMTopTabCell *)cell selected:(BOOL)selected {
   
    if (selected) {
        
        cell.titleLabel.font = self.selectedFont;
        cell.titleLabel.textColor = self.selectedColor;
        
    } else {
    
        cell.titleLabel.font = self.normalFont;
        cell.titleLabel.textColor = self.normalColor;
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
   
    _selectedIndex = selectedIndex;
}

@end

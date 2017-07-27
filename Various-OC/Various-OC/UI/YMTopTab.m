//
//  YMTopTab.m
//  Various-OC
//
//  Created by YmWw on 2017/7/25.
//  Copyright © 2017年 WangWei. All rights reserved.
//

#import "YMTopTab.h"
#import "YMTopTabCell.h"

@interface YMTopTab()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL byendWidth;
@property (nonatomic, assign) CGFloat notByendGap;

@end

@implementation YMTopTab

- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
      

        [self creatCollectionView];
        
        self.backgroundColor = [UIColor yellowColor];
        self.
        
        self.normalFont = [UIFont systemFontOfSize:18.0f];
        self.selectedFont = [UIFont systemFontOfSize:18.0f];
    }
    
    return self;
}

- (void)setTitles:(NSArray *)titles {
    
    _titles = titles;
    NSAssert(titles.count > 0, @"tittles must have at least one");
    
    NSString *title = titles.firstObject;
    CGSize titleSize =  [title sizeWithAttributes:@{NSFontAttributeName:self.selectedFont}];
    
    CGSize size = self.collectionView.frame.size;
    size.height = titleSize.height;
    
    [self calculateWidth];
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, size.height);
    [self setNeedsLayout];
    
    [self.collectionView reloadData];
}

- (void)calculateWidth {
    
    CGFloat width = 0;
    
    for (NSString *title in self.titles) {
        
        CGSize titleSize =  [title sizeWithAttributes:@{NSFontAttributeName:self.selectedFont}];
        width += titleSize.width;
    }
    self.byendWidth =  width > self.collectionView.frame.size.width;
    
    if (!self.byendWidth) {
        
        self.notByendGap = (self.collectionView.frame.size.width - width) / self.titles.count;
    }

}

- (void)layoutSubviews {
   
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}
- (void)creatCollectionView {
   
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing  = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    [collectionView registerClass:[YMTopTabCell class] forCellWithReuseIdentifier:@"YMTopTabCell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView = collectionView;
    
    [self addSubview:collectionView];
}


#pragma  mark CollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    YMTopTabCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YMTopTabCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.titles[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = self.titles[indexPath.row];
    
    CGSize titleSize =  [title sizeWithAttributes:@{NSFontAttributeName:self.selectedFont}];
    

    if (self.byendWidth) {
        

        return  CGSizeMake(titleSize.width + 10, titleSize.height);
        
    } else {
    
        return CGSizeMake(titleSize.width + self.notByendGap, collectionView.frame.size.height);
    }

}


@end

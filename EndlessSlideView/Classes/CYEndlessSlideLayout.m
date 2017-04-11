//
//  CYEndlessSlideLayout.m
//  EndlessSlideView
//
//  Created by angelen on 2017/4/11.
//  Copyright © 2017年 ANGELEN. All rights reserved.
//

#import "CYEndlessSlideLayout.h"

@implementation CYEndlessSlideLayout

// The collection view calls -prepareLayout once at its first layout as the first message to the layout instance.
// The collection view calls -prepareLayout again after layout is invalidated and before requerying the layout information.
// Subclasses should always call super if they override.
- (void)prepareLayout {
    [super prepareLayout];
    
    // {{16, 64}, {382, 200}}
    NSLog(@"collectionView.frame - > %@", NSStringFromCGRect(self.collectionView.frame));
    
    self.itemSize = self.collectionView.bounds.size;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
}

@end

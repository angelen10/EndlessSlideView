//
//  CYEndlessSlideView.m
//  EndlessSlideView
//
//  Created by angelen on 2017/4/11.
//  Copyright © 2017年 ANGELEN. All rights reserved.
//

#import "CYEndlessSlideView.h"
#import "CYEndlessSlideLayout.h"
#import "CYEndlessSlideCell.h"

static NSString *const kCellReuseIdentifier = @"kCellReuseIdentifier";

@interface CYEndlessSlideView () <UICollectionViewDataSource, UICollectionViewDelegate> {
    NSArray <NSURL *> *_imageUrls;
}

@end

@implementation CYEndlessSlideView

- (instancetype)initWithImageUrls:(NSArray <NSURL *> *)imageUrls {
    self = [super initWithFrame:CGRectZero collectionViewLayout:[[CYEndlessSlideLayout alloc] init]];
    if (self) {
        _imageUrls = imageUrls;
        
        self.dataSource = self;
        self.delegate = self;

        [self registerClass:[CYEndlessSlideCell class] forCellWithReuseIdentifier:kCellReuseIdentifier];
        
        // 主队列的作用就是安排任务在主线程上执行，如果主线程当前有任务在执行，主队列暂时不调度任务
        // 因此，它会先完成了数据源的方法，才会执行以下的方法，即执行顺序为 1️⃣ -> 2️⃣
        dispatch_async(dispatch_get_main_queue(), ^{ // 2️⃣
            // 第一组有 _imageUrls.count 张图片，第二组也有 _imageUrls.count 张图片
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[self numberOfItemsInSection:0] / 2 inSection:0];
            [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        });
    }
    return self;
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageUrls.count * 200; // 1️⃣，为了解决滑动到第 0 张和最后一张卡顿的情况，可以将乘以的基数放大，同时将一开始将这个 SlideView 滚动到中央的地方，这样就左右滑动在短时间内（需要滑动好久）都不会有卡顿的情况，同时由于 collectionView 已经做好了循环利用的机制，不用担心内存会过大
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CYEndlessSlideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    cell.imageUrl = _imageUrls[indexPath.item % _imageUrls.count];
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger offset = scrollView.contentOffset.x / scrollView.bounds.size.width;
    NSLog(@"%zd -> ", offset); // 滑动到的第几张图片
    
    // 调整 offset
    if (offset == 0) {
        // 如果是滑动到第 0 张图片，则将 offset 置为第二组的第 0 张照片
        offset = _imageUrls.count;
        
        // 重新调整 collectionView 的 contentOffset
        scrollView.contentOffset = CGPointMake(offset * scrollView.bounds.size.width, 0);
    } else if (offset == [self numberOfItemsInSection:0] - 1) {
        // 如果是滑动到最后一张图片，则将 offset 置为第一组的最后一张图片
        offset = _imageUrls.count - 1;
        
        // 重新调整 collectionView 的 contentOffset
        scrollView.contentOffset = CGPointMake(offset * scrollView.bounds.size.width, 0);
    }
    
    
}

@end

//
//  CYEndlessSlideCell.m
//  EndlessSlideView
//
//  Created by angelen on 2017/4/11.
//  Copyright © 2017年 ANGELEN. All rights reserved.
//

#import "CYEndlessSlideCell.h"

@implementation CYEndlessSlideCell {
    UIImageView *_imageView;
}

// Cell 的大小是根据之前的 layout 已经确定好的
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"cell frame -> %@", NSStringFromCGRect(frame));
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        [self.contentView addSubview:_imageView];
    }
    return self;
}

- (void)setImageUrl:(NSURL *)imageUrl {
    _imageUrl = imageUrl;
    
    NSData *data = [NSData dataWithContentsOfURL:imageUrl];
    UIImage *image = [UIImage imageWithData:data];
    
    _imageView.image = image;
}

@end

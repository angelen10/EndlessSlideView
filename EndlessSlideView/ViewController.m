//
//  ViewController.m
//  EndlessSlideView
//
//  Created by angelen on 2017/4/11.
//  Copyright © 2017年 ANGELEN. All rights reserved.
//

#import "ViewController.h"
#import "CYEndlessSlideView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSArray <NSURL *> *imageUrls = @[
                                     [[NSBundle mainBundle] URLForResource:@"01.jpg" withExtension:nil],
                                     [[NSBundle mainBundle] URLForResource:@"02.jpg" withExtension:nil],
                                     [[NSBundle mainBundle] URLForResource:@"03.jpg" withExtension:nil],
                                     ];
    
    CYEndlessSlideView *slideView = [[CYEndlessSlideView alloc] initWithImageUrls:imageUrls];
    slideView.frame = CGRectMake(16, 64, self.view.bounds.size.width - 2 * 16, 200);
    [self.view addSubview:slideView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

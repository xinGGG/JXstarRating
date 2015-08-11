//
//  ViewController.m
//  starRating
//
//  Created by Mac on 15/8/11.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "PureLayout.h"
@interface ViewController ()
//存放星星的字典
@property (nonatomic,strong) NSMutableArray *starArray;
@property (nonatomic,strong) NSMutableArray *starDict;

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation ViewController

- (void)loadView {
    self.view = [UIView new];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.starArray = [NSMutableArray array];
    for (int i = 0 ; i < 10; i++) {
        UIButton *btn = [UIButton newAutoLayoutView];
        if (!(i%2)) {
            [btn setBackgroundImage:[UIImage imageNamed:@"public_star_false_ico1"] forState:UIControlStateNormal];
        }else {
            [btn setBackgroundImage:[UIImage imageNamed:@"public_star_false_ico2"] forState:UIControlStateNormal];
        }
        btn.contentMode = UIViewContentModeScaleAspectFill;
        [btn sizeToFit];
        [self.view addSubview:btn];
        [self.starArray addObject:btn];
        [btn addTarget:self  action:@selector(starClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i+1;
    }
    
    [self updateViewConstraints];
}

- (void)starClick:(UIButton *)button {

    for (int i = 0 ; i < 10; i++) {
        if (!(i%2)) {
            [self.starArray[i] setBackgroundImage:[UIImage imageNamed:@"public_star_false_ico1"] forState:UIControlStateNormal];
        }else {
            [self.starArray[i] setBackgroundImage:[UIImage imageNamed:@"public_star_false_ico2"] forState:UIControlStateNormal];
        }

    }
    for (int i = 0; i<button.tag; i++) {
        
        if (!(i%2)) {
            [self.starArray[i] setBackgroundImage:[UIImage imageNamed:@"public_star_true_ico1"] forState:UIControlStateNormal];
        }else {
            [self.starArray[i] setBackgroundImage:[UIImage imageNamed:@"public_star_true_ico2"] forState:UIControlStateNormal];
        }
    }
}

- (void)updateViewConstraints
{
    if (!self.didSetupConstraints) {
        
        NSArray *views = self.starArray;
        
        [views autoSetViewsDimension:ALDimensionWidth toSize:20.0];
        [views autoSetViewsDimension:ALDimensionHeight toSize:40.0];
        
        
        // Match the widths of all the views
        [views autoMatchViewsDimension:ALDimensionWidth];
        
        // Pin the red view 20 pt from the top layout guide of the view controller
        [views[0] autoPinToTopLayoutGuideOfViewController:self withInset:20.0];
        
        // Loop over the views, attaching the left edge to the previous view's right edge,
        
        
        [[views firstObject] autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        UIView *previousView = nil;
            for (int i = 0; i<self.starArray.count; i++) {
            if (previousView) {
                [self.starArray[i] autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:previousView];
                [self.starArray[i] autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:previousView];
            }
            previousView = self.starArray[i];
        }
    
    
    //布局操作
    self.didSetupConstraints = YES;
}

[super updateViewConstraints];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@",self.starArray);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

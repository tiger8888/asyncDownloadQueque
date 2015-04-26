//
//  ViewController.m
//  asyncDownloadQueque
//
//  Created by sbx_fc on 15-4-26.
//  Copyright (c) 2015年 RG. All rights reserved.
//

#import "ViewController.h"
#import "DownLoadView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
     DownLoadView* downloadView = [[[NSBundle mainBundle] loadNibNamed:@"DownLoadView" owner:self options:nil] firstObject];
    [self.view addSubview:downloadView];
    
    downloadView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:downloadView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:downloadView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:downloadView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:downloadView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0f]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

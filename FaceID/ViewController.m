//
//  ViewController.m
//  FaceID
//
//  Created by 王鑫锋 on 2018/6/27.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

#import "ViewController.h"
#import "UIView+JKFrame.h"
#import "NSObject+FaceIDAuth.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *button = [[UIButton alloc] init];
    button.jk_size = CGSizeMake(77, 77);
    button.center = self.view.center;
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(showFaceIDView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showFaceIDView {
    [self showFaceIDAuthView];
}
@end

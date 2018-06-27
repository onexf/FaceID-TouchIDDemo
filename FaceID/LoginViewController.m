//
//  LoginViewController.m
//  FaceID
//
//  Created by 王鑫锋 on 2018/6/27.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

#import "LoginViewController.h"
#import "UIView+JKFrame.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    UIButton *button = [[UIButton alloc] init];
    button.jk_size = CGSizeMake(77, 77);
    button.center = self.view.center;
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

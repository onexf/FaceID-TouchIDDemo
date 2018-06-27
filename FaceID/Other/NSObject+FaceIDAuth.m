//
//  NSObject+FaceIDAuth.m
//  GoldCatBank
//
//  Created by 王鑫锋 on 2018/6/22.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

#import "NSObject+FaceIDAuth.h"
#import "FaceIDView.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <objc/runtime.h>
#import "LoginViewController.h"

static const void *kfaceIDView = "faceIDView";

@interface NSObject ()
/** faceidView */
@property(nonatomic, strong) FaceIDView *faceIDView;

@end
@implementation NSObject (FaceIDAuth)


- (FaceIDView *)faceIDView
{
    return objc_getAssociatedObject(self, kfaceIDView);
}
- (void)setFaceIDView:(FaceIDView *)faceIDView {
    objc_setAssociatedObject(self, kfaceIDView, faceIDView, OBJC_ASSOCIATION_RETAIN);
}
- (void)hideFaceIDView:(NSNotification *)message {
    [self.faceIDView removeFromSuperview];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)showFaceIDAuthView {
    FaceIDView *faceIDView = [FaceIDView new];
    self.faceIDView = faceIDView;
    
//    //在这里监听了登录页面登录成功事件
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideFaceIDView:) name:@"FACETOUCHID" object:nil];
    
    __weak typeof(faceIDView) weakFaceIDView = faceIDView;
    faceIDView.didTapLoginLabel = ^{
        //弹出登录页面
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:loginVC animated:YES completion:nil];

    };
    faceIDView.didTapImageView = ^{
        NSError *error;
        LAContext *context = [LAContext new];
        context.localizedFallbackTitle = @"验证码登录";
        BOOL canAuthentication = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
        if (canAuthentication) {
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"验证FaceID" reply:^(BOOL success, NSError * _Nullable error) {
                //注意iOS 11.3之后需要配置Info.plist权限才可以通过Face ID验证
                if (success) {
                    NSLog(@"验证成功");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakFaceIDView removeFromSuperview];
//                        [[NSNotificationCenter defaultCenter] removeObserver:self];
                    });
                } else {
                    LAError errorCode = error.code;
                    if (errorCode == LAErrorUserFallback) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //弹出登录页面
                            LoginViewController *loginVC = [[LoginViewController alloc] init];
                            [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:loginVC animated:YES completion:nil];
                        });
                    }
                }
            }];
        }
    };
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:faceIDView];
    NSError *error;
    LAContext *context = [LAContext new];
    context.localizedFallbackTitle = @"验证码登录";
    BOOL canAuthentication = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (canAuthentication) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"验证FaceID" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"验证成功");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [faceIDView removeFromSuperview];
                });
            } else {
                
                NSLog(@"验证失败：%@",error);
                LAError errorCode = error.code;
                if (errorCode == LAErrorUserFallback) {
                    NSLog(@"我就是我");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //弹出登录页面
                        LoginViewController *loginVC = [[LoginViewController alloc] init];
                        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:loginVC animated:YES completion:nil];
                    });
                }
            }
        }];
    }
}

@end

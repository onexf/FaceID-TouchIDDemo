//
//  FaceIDView.m
//  GoldCatBank
//
//  Created by 王鑫锋 on 2018/6/12.
//  Copyright © 2018 王鑫锋. All rights reserved.
//


#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)

#define IS_IPHONEX  ([UIScreen mainScreen].bounds.size.height == 812)


#define FONT_BOLD(size)         [UIFont boldSystemFontOfSize:size]

#define FONT_NAV                FONT_BOLD(16)


#import "FaceIDView.h"
#import "UIView+JKBlockGesture.h"
#import "UIView+JKFrame.h"

@interface FaceIDView ()

/** 电话号码 */
@property(nonatomic, strong) UILabel *phoneNum;
/** 密码图片 TOUCH ID */
@property(nonatomic, strong) UIImageView *password;
/** waring */
@property(nonatomic, strong) UILabel *subTitle;
/** 验证码登陆 */
@property(nonatomic, strong) UILabel *loginView;


@end

@implementation FaceIDView

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.phoneNum];
        [self addSubview:self.password];
        [self addSubview:self.subTitle];
        [self addSubview:self.loginView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.password.center = self.center;
}

- (UILabel *)phoneNum {
    if (!_phoneNum) {
        _phoneNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, 30)];
        _phoneNum.textColor = [UIColor blackColor];
        _phoneNum.font = FONT_NAV;
        _phoneNum.text = @"用户****手机号";
        _phoneNum.textAlignment = NSTextAlignmentCenter;
    }
    return _phoneNum;
}

- (UIImageView *)password {
    if (!_password) {
        _password = [[UIImageView alloc] init];
        _password.center = self.center;
//        _password.jk_centerY = self.jk_centerY;
        _password.jk_size = CGSizeMake(77, 77);
        _password.image = [UIImage imageNamed:@"TOUCH ID"];
        _password.userInteractionEnabled = YES;
        __weak typeof(self) weakSelf = self;
        [_password jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            if (weakSelf.didTapImageView) {
                weakSelf.didTapImageView();
            }
        }];
    }
    return _password;
}
- (UILabel *)subTitle {
    if (!_subTitle) {
        _subTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, self.password.jk_bottom + 20, SCREEN_WIDTH, 30)];
        _subTitle.textColor = [UIColor blackColor];
        _subTitle.font = FONT_NAV;
        _subTitle.text = IS_IPHONEX ? @"点击进行FaceID识别" : @"点击进行TouchID识别";
        _subTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _subTitle;
}
- (UILabel *)loginView {
    if (!_loginView) {
        _loginView = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 30)];
        _loginView.textColor = [UIColor blueColor];
        _loginView.font = FONT_NAV;
        _loginView.textAlignment = NSTextAlignmentCenter;
        _loginView.text = @"使用验证码登录";
        _loginView.userInteractionEnabled = YES;
        __weak typeof(self) weakSelf = self;
        [_loginView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            if (weakSelf.didTapLoginLabel) {
                weakSelf.didTapLoginLabel();
            }
        }];
    }
    return _loginView;
}
@end

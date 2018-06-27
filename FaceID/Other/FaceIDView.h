//
//  FaceIDView.h
//  GoldCatBank
//
//  Created by 王鑫锋 on 2018/6/12.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FaceIDView : UIView

/** 点击图片 */
@property (nonatomic, copy) void (^didTapImageView)(void);
/** 点击验证码登录 */
@property (nonatomic, copy) void (^didTapLoginLabel)(void);

@end

NS_ASSUME_NONNULL_END

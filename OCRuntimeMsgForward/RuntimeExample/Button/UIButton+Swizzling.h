//
//  UIButton+Swizzling.h
//  OCRuntimeMsgForward
//
//  Created by 赵肖杰 on 2019/6/21.
//  Copyright © 2019 knisa. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDefaultInterval 1


NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Swizzling)
//点击间隔
@property (nonatomic,assign) NSTimeInterval timeInterval;

//用于设置单个按钮不需要被hook
@property (nonatomic,assign) BOOL isIgnore;

@end

NS_ASSUME_NONNULL_END

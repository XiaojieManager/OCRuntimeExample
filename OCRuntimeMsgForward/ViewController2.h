//
//  ViewController2.h
//  OCRuntimeMsgForward
//
//  Created by 赵肖杰 on 2019/6/20.
//  Copyright © 2019 knisa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewController2 : UIViewController
- (void)methodWithoutImplementation;//重定向(s接收来之viewcontroller2的方法重定向)

@end

NS_ASSUME_NONNULL_END

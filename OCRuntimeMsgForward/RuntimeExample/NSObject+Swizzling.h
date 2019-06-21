//
//  NSObject+Swizzling.h
//  OCRuntimeMsgForward
//
//  Created by 赵肖杰 on 2019/6/20.
//  Copyright © 2019 knisa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzling)

+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector
                         bySwizzledSelector:(SEL)swizzledSelector;
@end

NS_ASSUME_NONNULL_END

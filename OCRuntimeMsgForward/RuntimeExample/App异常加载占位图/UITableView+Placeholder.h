//
//  UITableView+Placeholder.h
//  OCRuntimeMsgForward
//
//  Created by 赵肖杰 on 2019/6/21.
//  Copyright © 2019 knisa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Placeholder)
@property (nonatomic, assign) BOOL firstReload;
@property (nonatomic, strong) UIView *placeholderView;
@property (nonatomic,   copy) void(^reloadBlock)(void);

@end

NS_ASSUME_NONNULL_END

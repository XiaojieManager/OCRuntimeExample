//
//  UIViewController+Swizzling.m
//  OCRuntimeMsgForward
//
//  Created by 赵肖杰 on 2019/6/20.
//  Copyright © 2019 knisa. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import <objc/runtime.h>
#import "NSObject+Swizzling.h"


@implementation UIViewController (Swizzling)

/*
 +load 和 +initialize 是 Objective-C runtime 会自动调用的两个类方法，但是它们的调用时机是不一样的。+load 方法是在类被加载的时候调用的，而 +initialize 方法是在类或它的子类收到第一条消息之前被调用的，这里所指的消息包括实例方法和类方法调用。也就是说 +initialize 方法是以懒加载的方式被调用的，如果程序一直没有给某个类或它的子类发送消息，那么这个类的 +initialize 方法是永远不会被调用的。此外 +load 方法还有一个非常重要的特性，那就是子类、父类和分类中的 +load 方法的实现是被区别对待的。换句话说在 Objective-C runtime 自动调用 +load 方法时，分类中的 +load 方法并不会对主类中的 +load 方法造成覆盖。综上所述，+load 方法是实现 「Method Swizzling」 逻辑的最佳 「场所」。
 
 作者：r_瑞
 链接：https://juejin.im/post/5cdc0192e51d453a393af505
 来源：掘金
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */
+(void)load{
    //+load 方法在类加载的时候会被 runtime 自动调用一次，但是它并没有限制程序员对 +load 方法的手动调用，所以我们所能做的就是尽可能的保证程序能够在各种情况下正常运行。
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        Method original = class_getInstanceMethod(class, @selector(viewWillAppear:));
//        Method swizzled = class_getInstanceMethod(class, @selector(swizzle_ViewWillAppear:));
//
//        BOOL isSuccess = class_addMethod(class, @selector(viewWillAppear:), method_getImplementation(swizzled), method_getTypeEncoding(swizzled));
//        if (isSuccess) {
//            NSLog(@"替换了");
//            class_replaceMethod(class, @selector(swizzle_ViewWillAppear:), method_getImplementation(original), method_getTypeEncoding(original));
//        }else{
//            NSLog(@"交换了了");
//            method_exchangeImplementations(original, swizzled);
//        }
//    });
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(viewWillAppear:) bySwizzledSelector:@selector(swizzle_ViewWillAppear:)];
        [self methodSwizzlingWithOriginalSelector:@selector(viewWillDisappear:) bySwizzledSelector:@selector(swizzle_ViewWillDisappear:)];

    });
}


/*
 为什么没有发生死循环？
 
 一定有很多读者有疑惑，为什么swizzle_ViewWillAppear方法中的代码没有发生递归死循环。其原因很简单，因为方法已经执行过交换，调用[self swizzle_ViewWillAppear:animated]本质是在调用原有方法viewWillDisappear，反而如果我们在方法中调用[self viewWillDisappear:animated]才真的会发生死循环。是不是很绕？仔细看看。
 反向理解：如果在 swizzle_ViewWillAppear： 方法里调用了  [self viewWillAppear:animated] ,此时该方法已经被置换为 swizzle_ViewWillAppear: ，相当于自己调用了自己，造成死循环
 */
- (void)swizzle_ViewWillAppear:(BOOL)animated {
//    [self swizzle_ViewWillAppear:animated];
    NSLog(@"%s",__func__);
    //do something
    //比如 HUD 的 show，
}
- (void)swizzle_ViewWillDisappear:(BOOL)animated {
    [self swizzle_ViewWillDisappear:animated];
    NSLog(@"%s",__func__);
    
    //do something
    //比如 HUD 的 diss，
}



@end

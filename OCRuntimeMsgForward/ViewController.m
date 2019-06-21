//
//  ViewController.m
//  OCRuntimeMsgForward
//
//  Created by 赵肖杰 on 2019/6/20.
//  Copyright © 2019 knisa. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "fishhook.h"
#import "ViewController2.h"


@interface ViewController ()

//一个没有实现的方法
- (void)methodWithoutImplementation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //调用未实现的方法（）
    //未处理的情况下回报错
    //Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[ViewController methodWithoutImplementation]: unrecognized selector sent to instance 0x7fd756f096d0'
    [self methodWithoutImplementation];
}
//测试 Method Swizzling
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"测试 是否调用了 %s",__func__);
}
//自定义一个 用来接收的方法
// 动态添加的方法（OC 的方法其实只是一个 C 函数，不过它默认带了两个参数，一个是 id self. 另外一个是 SEL _cmd）

void resolveMethod() {
    NSLog(@"----%s",__func__);
}

- (void)pleaseHookMe{
    NSLog(@"haha ,I`m hooked");
}

//第一步，方法解析
//类方法,同实例方法
//+ (BOOL)resolveClassMethod:(SEL)sel{
//
//}
//实例方法
//如果你想让转发过程继续，那么就让 resolveInstnceMethod: 返回 NO。
//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//    //调试二三步，关闭动态添加方法
////    if (sel == @selector(methodWithoutImplementation)) {
////        /*
////         我们分别来看一下这四个参数对应的意思：
////
////         Class cls : 这是你要指定的类，runtime 会到这个类中去找方法
////         SEL name : 这是要解析的那一个方法
////         IMP : 这是动态添加的方法实现的 imp
////         const char *types : 类型编码，是个字符串（更多关于类型编码，https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1）
////
////        */
////        class_addMethod([self class], sel, (IMP)resolveMethod, "v@:");
////
////        return YES;
////    }
//    return  [super resolveInstanceMethod:sel];
//}


//第二步，重定向(x也相当于消息转发，只不过是替换的接收者)
//第一步必须返回NO，让消息转发过程继续
//- (id)forwardingTargetForSelector:(SEL)aSelector{
//    //调试三步，关闭重定向
////    if (aSelector == @selector(methodWithoutImplementation)) {
////        return [[ViewController2 alloc]init];
////    }
//    return [super forwardingTargetForSelector:aSelector];
//}

//第三步，消息转发(必须重写下面两个方法)
//不同于第二步，这一步需要耗费更多的时间
//1.创建 NSInvocation 对象，
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        if ([ViewController2 instancesRespondToSelector:aSelector]) {
            signature = [ViewController2 instanceMethodSignatureForSelector:aSelector];
        }
    }
    return signature;
}
//2.系统 把与尚未处理的消息有关的全部细节都封装在 anInvocation 中，包括 selector、目标（target）和参数。
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    if ([ViewController2 instancesRespondToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:[ViewController2 new]];
    }
}


@end

//
//  NSMutableArray+Swizzling.m
//  OCRuntimeMsgForward
//
//  Created by 赵肖杰 on 2019/6/21.
//  Copyright © 2019 knisa. All rights reserved.
//

#import "NSMutableArray+Swizzling.h"
#import "NSObject+Swizzling.h"

@implementation NSMutableArray (Swizzling)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("__NSArrayM") methodSwizzlingWithOriginalSelector:@selector(removeObject:) bySwizzledSelector:@selector(safeRemoveObject:) ];
        [objc_getClass("__NSArrayM") methodSwizzlingWithOriginalSelector:@selector(addObject:) bySwizzledSelector:@selector(safeAddObject:)];
        [objc_getClass("__NSArrayM") methodSwizzlingWithOriginalSelector:@selector(removeObjectAtIndex:) bySwizzledSelector:@selector(safeRemoveObjectAtIndex:)];
        [objc_getClass("__NSArrayM") methodSwizzlingWithOriginalSelector:@selector(insertObject:atIndex:) bySwizzledSelector:@selector(safeInsertObject:atIndex:)];
        [objc_getClass("__NSArrayM") methodSwizzlingWithOriginalSelector:@selector(objectAtIndex:) bySwizzledSelector:@selector(safeObjectAtIndex:)];

    });
    /*
     这里没有使用self来调用，而是使用objc_getClass("__NSArrayM")来调用的。因为NSMutableArray的真实类只能通过后者来获取，而不能通过[self class]来获取，而method swizzling只对真实的类起作用。这里就涉及到一个小知识点：类簇。补充以上对象对应类簇表。
     
     https://user-gold-cdn.xitu.io/2016/12/8/21566b4eaf0e07bde98512aee4f28e63?imageView2/0/w/1280/h/960/ignore-error/1
     */
}
- (void)safeAddObject:(id)obj {
    if (obj == nil) {
        NSLog(@"%s can add nil object into NSMutableArray", __FUNCTION__);
    } else {
        [self safeAddObject:obj];
    }
}
- (void)safeRemoveObject:(id)obj {
    if (obj == nil) {
        NSLog(@"%s call -removeObject:, but argument obj is nil", __FUNCTION__);
        return;
    }
    [self safeRemoveObject:obj];
}
- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil) {
        NSLog(@"%s can't insert nil into NSMutableArray", __FUNCTION__);
    } else if (index > self.count) {
        NSLog(@"%s index is invalid", __FUNCTION__);
    } else {
        [self safeInsertObject:anObject atIndex:index];
    }
}
- (id)safeObjectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        NSLog(@"%s can't get any object from an empty array", __FUNCTION__);
        return nil;
    }
    if (index > self.count) {
        NSLog(@"%s index out of bounds in array", __FUNCTION__);
        return nil;
    }
    return [self safeObjectAtIndex:index];
}
- (void)safeRemoveObjectAtIndex:(NSUInteger)index {
    if (self.count <= 0) {
        NSLog(@"%s can't get any object from an empty array", __FUNCTION__);
        return;
    }
    if (index >= self.count) {
        NSLog(@"%s index out of bound", __FUNCTION__);
        return;
    }
    [self safeRemoveObjectAtIndex:index];
}

@end

//
//  ViewController2.m
//  OCRuntimeMsgForward
//
//  Created by 赵肖杰 on 2019/6/20.
//  Copyright © 2019 knisa. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)methodWithoutImplementation{
    NSLog(@"%s  成功被我接收了",__func__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

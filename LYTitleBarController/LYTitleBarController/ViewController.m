//
//  ViewController.m
//  LYTitleBarController
//
//  Created by CloudL on 16/8/12.
//  Copyright © 2016年 CloudL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
/*
 
    演示:
 
    1.继承后,添加子控制器就行  *必须添加
 
    其他设置可设可不设,不设都会初始化默认值
 
    2.设置导航条一次最多显示多少个标题,此步可以省略,默认为4个,可以根据需求自行调整
 
 */
    
    for (int i = 0; i < 20; i ++) {
        UIViewController *vc = [UIViewController new];
        
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        
        vc.title = [NSString stringWithFormat:@"第%d个",i];
        
        [self addChildViewController:vc];
    }
    
    self.maxTitleCount = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

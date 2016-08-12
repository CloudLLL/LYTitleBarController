//
//  ViewController.m
//  LYTitleBarController
//
//  Created by CloudL on 16/8/12.
//  Copyright © 2016年 CloudL. All rights reserved.

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
/*
 
    演示
 
    注意点:
            
          继承后,添加子控制器并设置控制器View的Frame  *不设置frame可能出现一些异常
 
          添加控制器的时候需要设置控制器的title,不然标题为空
 
          其他设置可设可不设,不设都会初始化默认值

 
 */
//    添加子控制器
    
    for (int i = 0; i < 20; i ++) {
        UIViewController *vc = [UIViewController new];
        
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        
        vc.title = [NSString stringWithFormat:@"第%d个",i];
        
        CGFloat y = 20 + self.titleBarHeight; //20为状态栏高度
        
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        
        CGFloat h = [UIScreen mainScreen].bounds.size.height - y;
        
        vc.view.frame = CGRectMake(0, 20 + self.titleBarHeight, w, h );
        
        [self addChildViewController:vc];
    
    }

  
//    自定义属性
    
    self.maxTitleCount = 6;
    
    self.randomChangeIndicateViewColor = YES;
    
    self.randomChangeTitleBarColor = YES;
    
    self.indicateStyle = kIndicateStylePoint;
    
    self.indicateBarHeight = 5;
    
    self.indicatePointRadius = 4;
    
//  为了配合导航控制器默认Y值为64,为了演示效果,Y值为状态栏高度
    
    self.titleBarY = 20;
    

}

@end

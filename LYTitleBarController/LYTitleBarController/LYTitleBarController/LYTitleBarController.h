
//  Created by CloudL on 16/8/10.
//  Copyright © 2016年 CloudL. All rights reserved.
//

#import <UIKit/UIKit.h>

//指示器类型
typedef enum {
    //    矩形
    kIndicateStyleFrame,
    //    条形
    kIndicateStyleBar,
    //    点形
    kIndicateStylePoint,
    
} kIndicateStyle;

//指示器滚动模式
typedef enum {
    //    跟随内容拖拽滚动而滚动
    kIndicateScrollModeFollow,
    //    拖拽停止后滚动
    kIndicateScrollModeDelay,
    
} kIndicateScrollMode;

@interface LYTitleBarController : UIViewController

/*------------------设置标题按钮---------------------*/
/**
 标题按钮字体大小,默认为系统字体15;
 */
@property (nonatomic, strong) UIFont *titleBtnTextFont;
/**
 标题按钮默认文字颜色,默认为黑色;
 */
@property (nonatomic, strong) UIColor *titleBtnTextColor;
/**
 标题按钮默认文字颜色,默认为红色;
 */
@property (nonatomic, strong) UIColor *titleBtnTextSelectedColor;


/*------------------设置标题个数---------------------*/
/**
 导航条一次最多显示多少个标题,默认为4
 */
@property (nonatomic, assign) NSInteger maxTitleCount;


/*------------------设置标题栏---------------------*/
/**
 导航条的背景颜色,默认为白色
 */
@property (nonatomic, strong) UIColor *titleBarBackgroundColor;
/**
 导航条的透明度,默认为1;
 */
@property (nonatomic, assign) CGFloat  titleBarAlpha;
/**
 导航条的高度,默认为40
 */
@property (nonatomic, assign) CGFloat titleBarHeight;
/**
 导航条的Y值,默认为64
 */
@property (nonatomic, assign) CGFloat titleBarY;
/**
 滑动内容界面松手时导航条是否随机改变背景颜色,默认为NO;
 */
@property (nonatomic, assign) BOOL randomChangeTitleBarColor;


/*------------------设置指示器---------------------*/
/**
 指示器背景颜色,默认为黄色;
 */
@property (nonatomic, strong) UIColor * indicateViewBackgroundColor;
/**
 指示器透明度,默认为1;
 */
@property (nonatomic, assign) CGFloat  indicateViewAlpha;
/**
 滑动内容界面松手时指示器是否随机改变背景颜色,默认为NO;
 */
@property (nonatomic, assign) BOOL randomChangeIndicateViewColor;
/**
 指示器与标题按钮的宽度差,默认为30;
 */
@property (nonatomic, assign) CGFloat  indicateReduceWidth;
/**
 指示器与标题按钮的高度差,默认为10;
 */
@property (nonatomic, assign) CGFloat  indicateReduceHeight;
/**
 指示器的样式,默认为框形;
 */
@property (nonatomic, assign) kIndicateStyle indicateStyle;
/**
 指示器框形样式的半径,默认为高度的一半;
 */
@property (nonatomic, assign) CGFloat  indicateFrameRadius;
/**
 指示器条形样式的高度,默认为3;
 */
@property (nonatomic, assign) CGFloat  indicateBarHeight;
/**
 指示器点样式的半径,默认为3;
 */
@property (nonatomic, assign) CGFloat  indicatePointRadius;
/**
 指示器的滚动模式,默认为跟随模式;
 */
@property (nonatomic, assign) kIndicateScrollMode indicateScrollMode;



@end


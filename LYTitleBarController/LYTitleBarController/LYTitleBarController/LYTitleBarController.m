
//  Created by CloudL on 16/8/10.
//  Copyright © 2016年 CloudL. All rights reserved.
//

#define screen_W  [UIScreen mainScreen].bounds.size.width


#import "LYTitleBarController.h"


@interface LYTitleBarController ()<UICollectionViewDataSource,UICollectionViewDelegate>

//用于记录是否为第一次显示
@property (nonatomic, assign) NSInteger number;
//展示内容的collectionView
@property (nonatomic, weak) UICollectionView *collectionView;
//标题导航条
@property (nonatomic, weak) UIScrollView *titleBarView;
//选中的按钮
@property (nonatomic, weak) UIButton *selectedBtn;
//指示view
@property (nonatomic, weak) UIView *indicateView;
//所有标题按钮
@property (nonatomic, strong) NSMutableArray *btnArray;
//计算得到的指示器偏移量
@property (nonatomic, assign) CGFloat offSetX;


@end

static NSString * const cellID = @"essence";

@implementation LYTitleBarController

#pragma mark - 懒加载
- (NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (UIColor *)titleBarBackgroundColor
{
    if (_titleBarBackgroundColor == nil) {
        
        _titleBarBackgroundColor = [UIColor whiteColor];
    }
    
    return _titleBarBackgroundColor;
}

- (UIColor *)indicateViewBackgroundColor
{
    if (_indicateViewBackgroundColor == nil) {
        
        _indicateViewBackgroundColor = [UIColor yellowColor];
    }
    
    return _indicateViewBackgroundColor;
}

- (UIFont *)titleBtnTextFont
{
    if (_titleBtnTextFont == nil) {
        
        _titleBtnTextFont = [UIFont systemFontOfSize:15];
    }
    
    return _titleBtnTextFont;
}

- (UIColor *)titleBtnTextColor
{
    if (_titleBtnTextColor == nil) {
        
        _titleBtnTextColor = [UIColor blackColor];
    }
    
    return _titleBtnTextColor;
}

- (UIColor *)titleBtnTextSelectedColor
{
    if (_titleBtnTextSelectedColor == nil) {
        
        _titleBtnTextSelectedColor = [UIColor redColor];
    }
    
    return _titleBtnTextSelectedColor;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addCollectionView];
    
    [self setup];
}

#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_number == 1) {
        
        [self addNavigationView];
        
        [self addTitleBtn];
        
    }
    
    _number += 1;
}


#pragma mark - 初始化默认值
- (void)setup{
    
    _number = 1;
    
    _titleBarY = -1;
    
    _indicateViewAlpha = 1;
    
    _titleBarAlpha = 1;
    
    _titleBarHeight = 40;
    
    _titleBarY = 64;
    
    _maxTitleCount = 4;
    
    _indicateReduceWidth = 30;
    
    _indicateReduceHeight = 10;
    
    _indicateBarHeight = 3;
    
    _indicatePointRadius = 3;
    
    _indicateFrameRadius = (_titleBarHeight - _indicateReduceHeight) * 0.5;
    
}

#pragma mark - 添加标题按钮
- (void)addTitleBtn{
    
    CGFloat w;
    
    //    判断设置的最大显示标题按钮值是否大于子控制器的个数
    
    if (_maxTitleCount >= self.childViewControllers.count) {
        
        w = screen_W/self.childViewControllers.count;
        
    }else{
        
        w = screen_W/_maxTitleCount;
        
    }
    
    CGFloat h = _titleBarHeight;
    
    for (int i = 0; i < self.childViewControllers.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        
        [btn setTitleColor:self.titleBtnTextSelectedColor forState:UIControlStateSelected];
        
        [btn setTitleColor:self.titleBtnTextColor forState:UIControlStateNormal];
        
        btn.titleLabel.font = self.titleBtnTextFont;
        
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.tag = i;
        
        btn.frame = CGRectMake(i * w, 0, w, h);
        
        if (i == 0) {
            
            btn.selected = YES;
            
            _selectedBtn = btn;
            
            [self addIndicateViewWithWidth:w height:h];
            
        }
        
        [_titleBarView addSubview:btn];
        
        [self.btnArray addObject:btn];
        
    }
    
    _titleBarView.contentSize = CGSizeMake(w * self.childViewControllers.count, 0);
    
    //    if (self.titleBarBackgroundColor == [UIColor whiteColor] && _randomChangeTitleBarColor == NO)
    //    {
    //        [self addTitlebarBottomLine:_titleBarView.contentSize.width];
    //    }
    //
    [self addTitlebarBottomLine:_titleBarView.contentSize.width];
    
}

#pragma mark - 添加指示器
- (void)addIndicateViewWithWidth:(CGFloat)width height:(CGFloat)height{
    
    UIView *indicateView = [[UIView alloc]init];
    
    switch (_indicateStyle) {
            
        case kIndicateStyleFrame:
            // 为了让指示器看起来比较好看,稍微比btn小一点
            indicateView.frame = CGRectMake(_indicateReduceWidth * 0.5, _indicateReduceHeight * 0.5, width - _indicateReduceWidth, height - _indicateReduceHeight);
            
            indicateView.layer.cornerRadius = _indicateFrameRadius;
            
            break;
            
        case kIndicateStyleBar:
            
            indicateView.frame = CGRectMake(_indicateReduceWidth * 0.5, height - _indicateBarHeight, width - _indicateReduceWidth, _indicateBarHeight);
            
            break;
        case kIndicateStylePoint:
            
            indicateView.frame = CGRectMake(width * 0.5 - _indicatePointRadius, height - _indicatePointRadius * 2, _indicatePointRadius * 2,_indicatePointRadius * 2);
            
            indicateView.layer.cornerRadius = _indicatePointRadius;
            
            break;
            
        default:
            
            
            break;
    }
    
    _indicateView = indicateView;
    
    indicateView.backgroundColor = self.indicateViewBackgroundColor;
    
    indicateView.alpha = self.indicateViewAlpha;
    
    
    
    [_titleBarView addSubview:indicateView];
    
    
}

#pragma mark - 添加titleBar底部分割线
- (void)addTitlebarBottomLine:(CGFloat)wight{
    
    CGRect frame = CGRectMake(0, _titleBarHeight - 1, wight, 1);
    
    UIView *lineView = [[UIView alloc]initWithFrame:frame];
    
    [_titleBarView addSubview:lineView];
    
    lineView.backgroundColor = [UIColor colorWithRed:214 / 255 green:214 / 255 blue:214 / 255 alpha:0.2];
    
}


#pragma mark - 点击标题按钮
- (void)titleBtnClick:(UIButton *)btn{
    
    _selectedBtn.selected = NO;
    
    btn.selected = YES;
    
    _selectedBtn = btn;
    
    NSInteger page = btn.tag;
    
    //    collectionView的偏移量
    CGFloat offsetX = page * screen_W;
    
    //    导航条的偏移量
    
    
    CGFloat navViewoffsetX = btn.center.x - screen_W *0.5;
    
    //    最小等于0
    if (navViewoffsetX < 0) {
        navViewoffsetX = 0;
    }
    //    最大等于内容宽度减屏幕宽度
    if (navViewoffsetX > _titleBarView.contentSize.width - screen_W) {
        navViewoffsetX = _titleBarView.contentSize.width - screen_W;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _collectionView.contentOffset = CGPointMake(offsetX, 0);
        
        _titleBarView.contentOffset = CGPointMake(navViewoffsetX, 0);
        
        if (self.randomChangeTitleBarColor) {
            
            _titleBarView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:self.titleBarAlpha];
        }
        
        if (self.randomChangeIndicateViewColor){
            
            _indicateView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:self.indicateViewAlpha];
            
        }
        
        CGPoint center = _indicateView.center;
        
        center.x =  btn.center.x;
        
        _indicateView.center = center;
        
    }];
    
    
}

#pragma mark - 添加导航条
- (void)addNavigationView{
    
    UIScrollView *titleBarView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.titleBarY, screen_W, self.titleBarHeight)];
    
    _titleBarView = titleBarView;
    
    titleBarView.scrollsToTop = NO;
    
    titleBarView.showsHorizontalScrollIndicator = NO;
    
    titleBarView.showsVerticalScrollIndicator = NO;
    
    //    titleBarView.bounces = NO;
    
    titleBarView.backgroundColor = self.titleBarBackgroundColor;
    
    titleBarView.alpha = self.titleBarAlpha;
    
    [self.view addSubview:titleBarView];
    
}

#pragma mark - 添加展示内容的collectionView
- (void)addCollectionView{
    
    //    创建collectionView布局
    
    UICollectionViewFlowLayout *flow = [UICollectionViewFlowLayout new];
    
    flow.itemSize = [UIScreen mainScreen].bounds.size;
    
    flow.minimumLineSpacing = 0;
    
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    
    //    创建collectionView
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flow];
    
    _collectionView = collectionView;
    
    collectionView.delegate = self;
    
    collectionView.dataSource = self;
    
    collectionView.pagingEnabled = YES;
    
    collectionView.scrollsToTop = NO;
    
    collectionView.bounces = NO;
    
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
}

#pragma mark - collectionView数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIViewController *vc = self.childViewControllers[indexPath.row];
    
    [cell addSubview:vc.view];
    
    return cell;
}

#pragma mark - collectionView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger page = scrollView.contentOffset.x/screen_W;
    
    //    防止角标越界
    if (page >= _btnArray.count) {
        
        page = _btnArray.count - 1;
    }
    
    UIButton *btn = self.btnArray[page];
    
    
    [self titleBtnClick:btn];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (_indicateScrollMode == kIndicateScrollModeFollow) {
        
        [self indicateViewScrollWithOffSetX:scrollView.contentOffset.x];
    }
    
}


#pragma mark - 指示器实时滚动
- (void)indicateViewScrollWithOffSetX:(CGFloat)offSetX{
    
    CGFloat x = offSetX / screen_W  * (screen_W / _maxTitleCount) - _offSetX;
    
    _offSetX = offSetX / screen_W  * (screen_W / _maxTitleCount);
    
    CGPoint center = self.indicateView.center;
    
    center.x += x;
    
    self.indicateView.center = center;
    
    
}









@end


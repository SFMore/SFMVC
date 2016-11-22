//
//  GuideView.m
//  SFMVC
//
//  Created by zsf on 16/10/9.
//  Copyright © 2016年 zsf. All rights reserved.
//

#import "GuideView.h"
#define MainScreen_width  [UIScreen mainScreen].bounds.size.width//宽
#define MainScreen_height [UIScreen mainScreen].bounds.size.height//高
@interface GuideView ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *bigScrollView;
@property(nonatomic)NSArray *imageArray;
@property(nonatomic,strong)UIPageControl *pageControl;

@end


@implementation GuideView

-(instancetype)initGuideViewWithFrame:(CGRect)frame Images:(NSArray *)images
{
    if (self = [super initWithFrame:frame]) {
        self.imageArray=images;
        [self loadPageView];
    }
    return self;
}

-(void)loadPageView
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MainScreen_width, MainScreen_height)];
    
    scrollView.contentSize = CGSizeMake(_imageArray.count*MainScreen_width, MainScreen_height);
    scrollView.pagingEnabled = YES;//设置分页
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    _bigScrollView = scrollView;
    
    for (int i = 0; i < _imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(i * MainScreen_width, 0, MainScreen_width, MainScreen_height);
        UIImage *image = [UIImage imageNamed:_imageArray[i]];
        imageView.image = image;
        
        [scrollView addSubview:imageView];
        
        
        if(i == _imageArray.count - 1)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"" forState:UIControlStateNormal];
            button.backgroundColor = [UIColor redColor];
            CGSize  size = self.bounds.size;
            [button setFrame:CGRectMake(imageView.frame.origin.x + size.width * (1 - 0.472222) * 0.5, size.height * 0.834583, size.width * 0.472222, size.height * 0.067709)];
            [scrollView addSubview:button];
            [button addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(MainScreen_width/2, MainScreen_height - 60, 0, 40)];
    pageControl.numberOfPages = _imageArray.count;
    pageControl.backgroundColor = [UIColor clearColor];
    [self addSubview:pageControl];
    
    _pageControl = pageControl;
    
}

-(void)finish
{
    if (_pageControl.currentPage == self.imageArray.count-1) {
        [self removeFromSuperview];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _bigScrollView) {
        CGPoint offSet = scrollView.contentOffset;
        _pageControl.currentPage = offSet.x/(self.bounds.size.width);//计算当前的页码
        [scrollView setContentOffset:CGPointMake(self.bounds.size.width * (_pageControl.currentPage), scrollView.contentOffset.y) animated:YES];
    }
}


+ (void)show
{
    NSString *key =  @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *savedVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (![currentVersion isEqualToString:savedVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIView *guideView = [[GuideView alloc] initGuideViewWithFrame:window.bounds Images:@[@"introductoryPage1",@"introductoryPage2",@"introductoryPage3",@"introductoryPage4"]];
        [window addSubview:guideView];
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end

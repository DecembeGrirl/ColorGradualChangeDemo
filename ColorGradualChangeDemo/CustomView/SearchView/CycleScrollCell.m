//
//  CycleScrollView.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/7.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "CycleScrollCell.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
@implementation CycleScrollCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self CreatUI];
    }
    return  self;
}
-(void)CreatUI
{
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(HandleTimer) userInfo:nil repeats:YES];
}

-(void)setCycleScrollViewFrame
{
    [_scrollView setFrame:CGRectMake(0, 0, self.width, 100)];
    [_pageControl setFrame:CGRectMake(self.width - 110, _scrollView.bottom-30, 100, 25)];
}

-(void)ConfigCycleScrolView:(NSArray *)data
{
    _dataSource =data;
    _lastIndex = 0;
    _currentIndex = 1;
    _nextIndex = 2;
    
        _lastImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width* _lastIndex, 0, self.width, self.height)];
        [_scrollView addSubview:_lastImageView];
    _currentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width*_currentIndex, 0, self.width, self.height)];
    [_scrollView addSubview:_currentImageView];
    _nextImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width*_nextIndex, 0, self.width, self.height)];
    [_scrollView addSubview:_nextImageView];
     [self addSubview:_pageControl];
    _scrollView.contentSize = CGSizeMake(self.width* 3, self.height);
    _scrollView.contentOffset = CGPointMake(self.width * _currentIndex, 0);
    [self loadImageView];
    
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = _dataSource.count;
    [self addSubview:_pageControl];
    
    [self setCycleScrollViewFrame];
}

-(void)loadImageView
{
    [_lastImageView setImage:_dataSource[_lastIndex]];
    [_currentImageView setImage:_dataSource[_currentIndex]];
    [_nextImageView setImage:_dataSource[_nextIndex]];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(HandleTimer) userInfo:nil repeats:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    [self dragCycleScroll:offset];
    [self loadImageView];
    [_scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
}

//拖拽滑动 的
-(void)dragCycleScroll:(CGPoint)offset
{
        if(offset.x == 2*self.width)
        {
            _currentIndex =(_currentIndex + 1)>=_dataSource.count? 0:(_currentIndex + 1);
            _pageControl.currentPage = labs((_pageControl.currentPage + 1)%3) ;
        }
        else if(offset.x == 0)
        {
            _currentIndex =(_currentIndex - 1)<0?_dataSource.count - 1:(_currentIndex - 1);
           NSInteger temp= (_pageControl.currentPage -1)<0?_dataSource.count-1:(_pageControl.currentPage -1);
            _pageControl.currentPage = labs(temp%3) ;
        }
        _nextIndex = (_currentIndex + 1)>=_dataSource.count? 0:(_currentIndex + 1);
        _lastIndex = (_currentIndex - 1)<0?_dataSource.count - 1:(_currentIndex - 1);
//    [self loadImageView];
}

-(void)timerCycleScroll:(CGPoint)offset
{


}


-(void)HandleTimer
{
   __block  CGPoint offset = _scrollView.contentOffset;
    [UIView animateWithDuration:0.25 animations:^{
        offset.x += self.width;
        [self dragCycleScroll:offset];
        [self loadImageView];
        [_scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
        
    }completion:^(BOOL finished) {
    }];
}

-(void)setContionOffset:(UIScrollView *)scrollView
{
    CGPoint offset =scrollView.contentOffset;
//    offset.x -= self.width;
    [self dragCycleScroll:offset];
    [self loadImageView];
     [_scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
}


@end

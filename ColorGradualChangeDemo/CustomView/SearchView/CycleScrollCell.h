//
//  CycleScrollView.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/7.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleScrollCell : UITableViewCell<UIScrollViewDelegate>
{
    UIScrollView * _scrollView;
    UIPageControl * _pageControl;
    NSArray * _dataSource;
    UIImageView *_nextImageView;
    UIImageView *_lastImageView;
    UIImageView *_currentImageView;
    
    NSInteger _nextIndex;
    NSInteger _currentIndex;
    NSInteger _lastIndex;
    
    NSTimer * _timer;
}
-(void)ConfigCycleScrolView:(id)data;
@end

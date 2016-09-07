//
//  SearchView.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/21.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchBar.h"
#import "PullDownView.h"
typedef void(^SelectedSearchBarCancelBtnBlock)();

@interface SearchView : UIView<SearchBarDelegate,PullDownViewDelegate>
{
    PullDownView * _pullDownView;
    UIView * _hotSearchView;
    SearchBar *_searchBar;
    
}
@property (nonatomic, strong)SearchBar *searchBar;
@property (nonatomic, strong)SelectedSearchBarCancelBtnBlock selectedSearchBarCancelBtnBlock;
-(void)SearchBarBecomeFirstResponder;
@end

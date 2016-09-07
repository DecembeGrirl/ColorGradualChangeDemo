//
//  TableViewDelegate.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 15/12/23.
//  Copyright © 2015年 yangshuyaun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Config.h"
#import "BaseCell.h"
typedef void(^SearchTableViewConfigCellBlock)(NSIndexPath * indexPath,id item,UITableViewCell * cell);
typedef void(^ScrollViewDidScrollBlock)(UIView * view);
typedef CGFloat(^TableViewHeaderViewHeightBlock)(UITableView * tableView);
typedef void (^SelectedImageBlock)(NSInteger indexPath,NSArray * array);
typedef void (^SelectedSearchCellBlock)(UITableViewCell * cell);
typedef void (^SelectedCellNameOrHeader)(BaseCell *cell);//点击头像或者昵称
typedef void (^SelectedCellBtnBlock)(BaseCell * cell,CommentType type);  //点击bottomViewbtn
typedef void (^SelectedCellMoreBtn)(UITableViewCell *cell);


@interface DetailsTableViewDelegate : NSObject<UITableViewDelegate,UITableViewDataSource,BaseCellDelegate>
@property (nonatomic, assign)CommentType type;
@property (nonatomic, strong)NSArray * dataSource;
@property (nonatomic, strong)NSArray * commentsArray;

@property(nonatomic, copy)SearchTableViewConfigCellBlock configCellBlock;
@property (nonatomic, copy)ScrollViewDidScrollBlock scrollViewDidScrollBlock;

@property (nonatomic, copy)TableViewHeaderViewHeightBlock headerViewHeightBlock;
@property (nonatomic, copy)SelectedImageBlock selectedImageBlock;
@property (nonatomic, copy)SelectedSearchCellBlock selectedCellBolck;
@property (nonatomic, copy)SelectedCellMoreBtn selectedCellMoreBtnBlock;
@property (nonatomic, copy)SelectedCellNameOrHeader selectedNameOrHeaderBlock;

@property (nonatomic, copy)SelectedCellBtnBlock selectedCellBtnBolck;

@property (nonatomic, assign)NSInteger flag;

-(void)RegistTableView:(UITableView *)tableView;

@end

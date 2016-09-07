//
//  WeiboTableViewDelegate.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 15/12/23.
//  Copyright © 2015年 yangshuyaun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseCell.h"
#import "ImageContentView.h"
#import "TransmitViewController.h"
typedef void(^TableViewConfigCellBlock)(NSIndexPath * indexPath,id item,BaseCell * cell);

typedef CGFloat(^TableViewHeaderViewHeightBlock)(UITableView * tableView);
typedef void (^SelectedImageBlock)(NSInteger indexPath,NSArray * array);  //点击图片
typedef void (^SelectedCellBtnBlock)(BaseCell * cell,CommentType type);  //点击bottomViewbtn
typedef void (^SelectedCellNameOrHeader)(BaseCell *cell);//点击头像或者昵称

typedef void (^SelectedCellBlock)(UITableViewCell * cell);
typedef void (^SelectedCellBtnBlock)(BaseCell * cell,CommentType type);  //点击bottomViewbtn
typedef void (^SelectedCellMoreBtn)(UITableViewCell *cell);

typedef void (^SelectedURL)(NSString * str);
//加载微博
typedef void (^DownLoadWeiboBlock)();

typedef void (^SelectedUserPhoto)(UITableViewCell * cell);
@interface WeiboTableViewDelegate : NSObject<UITableViewDelegate,UITableViewDataSource,BaseCellDelegate>

@property (nonatomic, strong)NSArray * dataSource;

@property(nonatomic, copy)TableViewConfigCellBlock configCellBlock;
@property (nonatomic, copy)TableViewHeaderViewHeightBlock headerViewHeightBlock;
//@property (nonatomic, copy)SelectedImageBlock selectedImageBlock;
@property (nonatomic, copy)SelectedCellBtnBlock selectedCellBtnBolck;
@property (nonatomic, copy)SelectedCellBlock selectedCellBlock;
@property (nonatomic, copy)SelectedCellMoreBtn selectedCellMoreBtnBlock;
@property (nonatomic, copy)SelectedCellNameOrHeader selectedNameOrHeaderBlock;
@property (nonatomic, copy)SelectedURL selectedURL;
@property (nonatomic, copy)DownLoadWeiboBlock downLoadWeibo;
@property (nonatomic, copy)SelectedUserPhoto selectedPhotoBlock;
-(void)RegistTableView:(UITableView *)tableView;

@end

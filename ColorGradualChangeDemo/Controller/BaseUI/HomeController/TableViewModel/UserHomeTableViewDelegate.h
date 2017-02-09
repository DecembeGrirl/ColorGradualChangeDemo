//
//  UserHomeTableViewDelegate.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/22.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Config.h"
#import "User.h"
#import "BaseCell.h"
#import "RetweetedStatusViewCell.h"
#import "StatusViewForImageCell.h"
#import "userPhotoTableViewCell.h"
#import "HeadView.h"

typedef enum {
    TypeOfUserHomeTableView      = 0,     // 主页
    TypeOfUserStatusTableView    = 1,     //微博
    TypeOfUserAlssetsTableView   = 2,     //相册
}TypeOfUserInfoTableView;

typedef void(^ScrollViewDidScrollBlock)(UIView * view);
typedef void(^TableViewConfigCellBlock)(NSIndexPath * indexPath,id item,BaseCell * cell);
typedef void (^SelectedImageBlock)(NSInteger indexPath,NSArray * array);  //点击图片
typedef void (^SelectedCellBlock)(UITableViewCell * cell);
//typedef void (^ScrollViewWillBeginDecelerating)(UIView * view);

typedef void (^SelectedCellMoreBtn)(UITableViewCell *cell);

typedef void (^SelectedUserPhoto)(UITableViewCell * cell);
typedef void (^SelectedUserName)(Statuses *statusesObj);


@interface UserHomeTableViewDelegate : NSObject<UITableViewDataSource,UITableViewDelegate,BaseCellDelegate,userPhotoCollectionViewDelegate>
@property (nonatomic, assign)TypeOfUserInfoTableView type;
@property (nonatomic, strong)User* userObj;
@property (nonatomic, strong)NSArray  * dataSource;
@property (nonatomic, copy)ScrollViewDidScrollBlock scrollViewDidScrollBlock;
@property(nonatomic, copy)TableViewConfigCellBlock configCellBlock;
@property (nonatomic, copy)SelectedImageBlock selectedImageBlock;
@property (nonatomic, copy)SelectedCellBlock selectedCellBlock;
@property (nonatomic, copy)SelectedCellMoreBtn selectedCellMoreBtnBlock;
@property (nonatomic, copy)SelectedUserPhoto selectedPhotoBlock;
@property (nonatomic, copy)SelectedUserName selectedUserNameBlock;
//@property (nonatomic, copy)ScrollViewWillBeginDecelerating scrollViewWillBeginDeceleratingBlock;


-(void)RegistTableView:(UITableView *)tableView;
@end

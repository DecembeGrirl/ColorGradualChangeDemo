//
//  TableViewDelegate.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 15/12/23.
//  Copyright © 2015年 yangshuyaun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void(^SearchTableViewConfigCellBlock)(NSIndexPath * indexPath,id item,UITableViewCell * cell);
typedef void(^ScrollViewDidScrollBlock)(UIView * view);
typedef CGFloat(^TableViewHeaderViewHeightBlock)(UITableView * tableView);
typedef void (^SelectedImageBlock)(NSInteger indexPath,NSArray * array);
typedef void (^SelectedSearchCellBlock)(UITableViewCell * cell);


@interface FindeTableViewDelegate : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSArray * dataSource;

@property(nonatomic, copy)SearchTableViewConfigCellBlock configCellBlock;
@property (nonatomic, copy)ScrollViewDidScrollBlock scrollViewDidScrollBlock;

@property (nonatomic, copy)TableViewHeaderViewHeightBlock headerViewHeightBlock;
@property (nonatomic, copy)SelectedImageBlock selectedImageBlock;
@property (nonatomic, copy)SelectedSearchCellBlock selectedCellBolck;

-(void)RegistTableView:(UITableView *)tableView;

@end

//
//  CellObj.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 15/12/23.
//  Copyright © 2015年 yangshuyaun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CellObj : NSObject
@property (nonatomic, copy)NSString *headImageURL;
@property (nonatomic, copy)NSString *nickName;
@property (nonatomic, copy)NSString *text;
@property (nonatomic, strong)NSArray *imageArrary ;
@end

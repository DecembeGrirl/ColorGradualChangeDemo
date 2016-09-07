//
//  addNewStatuesViewController.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/9/5.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "BaseController.h"
#import "BlurEffectMenu.h"
@interface addNewStatuesViewController : BaseController <BlurEffectMenuDelegate>
@property (nonatomic, strong)UIImage * backGroundImage;
@property (nonatomic, assign)NSInteger  index;  // 截屏的 ViewController
@end

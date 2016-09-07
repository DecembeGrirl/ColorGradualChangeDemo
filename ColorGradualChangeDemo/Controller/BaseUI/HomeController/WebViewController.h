//
//  WebViewController.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/7/5.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "BaseController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
@interface WebViewController : BaseController<NJKWebViewProgressDelegate,UIWebViewDelegate>
{
    UIWebView * _webView;
    NJKWebViewProgress * _progress;
    NJKWebViewProgressView * _progressView;
}
@property (nonatomic, copy)NSString * urlString;
@end

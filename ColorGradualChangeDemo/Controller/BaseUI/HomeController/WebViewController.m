//
//  WebViewController.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/7/5.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "WebViewController.h"
#import "Config.h"
#import "UIView+Frame.h"
@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNav.leftBtn.hidden = NO;
    [self CreatUI];
}

-(void)CreatUI
{
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, [[self.customNav class]barHeight], KScreenWidth, KScreenHeight-[[self.customNav class]barHeight] )];
    [self.view addSubview:_webView];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    _progress = [[NJKWebViewProgress alloc]init];
    _webView.delegate = _progress;
    _progress.webViewProxyDelegate = self;
    _progress.progressDelegate = self;
    
    _progressView = [[NJKWebViewProgressView alloc]initWithFrame:CGRectMake(0, _webView.top, KScreenWidth, 2)];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleWidth;
    [_progressView setProgress:0];
    [self.view addSubview:_progressView];
}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}
@end

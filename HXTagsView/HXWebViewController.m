//
//  HXWebViewController.m
//  HXTagsView
//
//  Created by 黄轩 on 16/1/15.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "HXWebViewController.h"

@interface HXWebViewController () <UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;

@end

@implementation HXWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _keyWord;
    // Do any additional setup after loading the view.
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    [self loadWebPageWithString:[NSString stringWithFormat:@"https://www.baidu.com/s?wd=%@",_keyWord]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadWebPageWithString:(NSString*)urlString {
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    
}

@end

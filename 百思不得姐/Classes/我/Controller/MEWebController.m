//
//  MEWebController.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/19.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "MEWebController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface MEWebController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NJKWebViewProgress *progress;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBack;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwd;

@end

@implementation MEWebController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.progress = [[NJKWebViewProgress alloc]init];
    
    //先把webview的delegate设置为NJKWebViewProgress，因为其内部需要根据webview的代理方法才可以获取进度
    self.webView.delegate = self.progress;
    
    
   __weak typeof(self) weakSelf = self;
    self.progress.progressBlock = ^(float progress){
        
        if (progress != 1.0) {
            NJKWebViewProgressView *progressView = [[NJKWebViewProgressView alloc]init];
            progressView.frame = CGRectMake(0, 64, SCREENWIDTH, 2);
            [weakSelf.view addSubview:progressView];
            [progressView setProgress:progress animated:YES];
        }
    };
    
    //这里再把progress.webViewProxyDelegate的代理设置为控制器，这样控制器中就可以实现webview的代理方法了
    self.progress.webViewProxyDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}
- (IBAction)goForwd:(id)sender {
    [self.webView goForward];
}
- (IBAction)fresh:(id)sender {
    [self.webView reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goBack.enabled = webView.canGoBack;
    self.goForwd.enabled = webView.canGoForward;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

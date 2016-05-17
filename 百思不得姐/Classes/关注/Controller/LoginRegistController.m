//
//  LoginRegistController.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/30.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "LoginRegistController.h"

@interface LoginRegistController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextFiead;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation LoginRegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view insertSubview:_bgView atIndex:0];
    /**
     修改Placeholder字体颜色
     */
//    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:_nameTextFiead.placeholder];
//    [placeholder addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, _nameTextFiead.placeholder.length)];
//    _nameTextFiead.attributedPlaceholder = placeholder;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    //iOS7以后状态栏由controller进行控制，如果不需要控制器控制的话需要在info.plist设置View controller-based status bar appearancer然后通过[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;设置
    
    return UIStatusBarStyleLightContent;
}
- (IBAction)showLoginOrRegister:(UIButton *)sender {
//    self.loginViewLeftMargin.constant = -self.view.width;
    
    if (self.loginViewLeftMargin.constant == 0) {
        self.loginViewLeftMargin.constant = -self.view.width;
        sender.selected = YES;
    }else{
        self.loginViewLeftMargin.constant = 0;
        sender.selected = NO;
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)closeController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  1.修改Placeholder的方法有好几种，可以设置textField的attributedPlaceholder属性，这是一个富文本属性，
 2，也可以自定义一个TextField，重写- (void)drawPlaceholderInRect:(CGRect)rect这个方法[self.placeholder drawInRect:rect withAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
 3.就是通过Runtime运行时进行修改
 */
@end

//
//  TRRegisterViewController.m
//  GameLive
//
//  Created by tarena on 16/8/9.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRRegisterViewController.h"
#import <SMS_SDK/SMSSDK.h>

@interface TRRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@end

@implementation TRRegisterViewController
#pragma mark - method
- (IBAction)registerPhone:(id)sender {
    [self.view endEditing:YES];
    if (_phoneTF.text.length == 11 && _pwdTF.text.length > 0 && _codeTF.text.length > 0) {
        [SMSSDK commitVerificationCode:_codeTF.text phoneNumber:_phoneTF.text zone:@"86" result:^(NSError *error) {
            NSLog(@"%@", error ? error : @"验证成功");
        }];
    }else{
        [self.view showWarning:@"请准确填写所有信息"];
    }
    
}

- (IBAction)getValidCode:(UIButton *)sender {
    [self.view endEditing:YES];
    if (_phoneTF.text.length != 11) {
        [self.view showWarning:@"请输入11位手机号"];
        return;
    }
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneTF.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        NSLog(@"%@", error ? error : @"短信验证码已发送");
    }];
    //按钮变灰倒数, 只有用__block修饰的变量 才能在block中修改
    __block NSInteger count = 60;
    sender.enabled = NO;
    sender.backgroundColor = [UIColor grayColor];
    [sender setTitle:@"60" forState:UIControlStateDisabled];
    [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
        [sender setTitle:@(--count).stringValue forState:UIControlStateDisabled];
        if (count == 0) {
            [timer invalidate];
            sender.enabled = YES;
            sender.backgroundColor = kRGBA(255, 60, 80, 1);
        }
    } repeats:YES];
    
}


#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    [TRFactory addBackItemForVC:self];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"登录页底图"]];
}

@end

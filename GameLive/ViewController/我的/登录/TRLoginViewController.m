//
//  TRLoginViewController.m
//  GameLive
//
//  Created by tarena on 16/8/9.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRLoginViewController.h"

@interface TRLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@end

@implementation TRLoginViewController
#pragma mark - method
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)login:(id)sender {
    [self.view endEditing:YES];
    NSLog(@"%@ , %@", _phoneTF.text, _pwdTF.text);
}



#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"登录页底图"]];
}

@end

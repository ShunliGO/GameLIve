//
//  MineViewController.m
//  GameLive
//
//  Created by tarena on 16/7/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MineViewController.h"
#import "TRMineCell.h"
#import "TRHeaderCell.h"

@interface MineViewController ()<TRHeaderCellDelegate>

@end

@implementation MineViewController
#pragma mark - TRHeaderCellDelegate
- (void)headerIconClickedInHeaderCell:(TRHeaderCell *)headerCell{
    //故事板中的场景 必须使用 故事板初始化
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //获取故事板中, 箭头指向的控制器指针
    id vc = [sb instantiateInitialViewController];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - life
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[TRMineCell class] forCellReuseIdentifier:@"TRMineCell"];
    [self.tableView registerClass:[TRHeaderCell class] forCellReuseIdentifier:@"TRHeaderCell"];
    self.tableView.sectionFooterHeight = 1;
    self.tableView.sectionHeaderHeight = 9;
    self.tableView.contentInset = UIEdgeInsetsMake(-56, 0, 0, 0);
    //    self.tableView.bounces = NO;
    //通过KVO监听偏移量y, 不允许出现下拉操作.    KVO真乃神技
    [self.tableView bk_addObserverForKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew task:^(id obj, NSDictionary *change) {
        CGPoint p = [change[@"new"] CGPointValue];
        NSLog(@"%f", p.y);
        if (p.y < 36) {
            self.tableView.contentOffset = CGPointMake(0, 36);
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [@[@1, @3, @1][section] integerValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 250;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        TRHeaderCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"TRHeaderCell" forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }else{
        TRMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRMineCell" forIndexPath:indexPath];
        if (indexPath.section == 1) {
            NSArray *imageNames = @[@"竖屏开播提醒", @"icon_tike", @"play_set"];
            cell.iconIV.image = [UIImage imageNamed:imageNames[indexPath.row]];
            cell.titleLb.text = @[@"开播提醒", @"票务查询", @"设置选项"][indexPath.row];
        }else{
            cell.titleLb.text = @"手游中心";
            cell.iconIV.image = [UIImage imageNamed:@"手游中心"];
            cell.detailTextLabel.text = @"玩游戏领鱼丸";
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

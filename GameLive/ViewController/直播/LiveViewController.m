//
//  LiveViewController.m
//  GameLive
//
//  Created by tarena on 16/7/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "LiveViewController.h"
#import "TRLiveCell.h"
#import "TRLiveViewModel.h"

@import AVKit;
@import AVFoundation;

#import "TRSearchViewController.h"

@interface LiveViewController ()
@property (nonatomic) TRLiveViewModel *liveVM;
@end

@implementation LiveViewController

static NSString * const reuseIdentifier = @"Cell";
#pragma mark - LifeCycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [TRFactory addSearchItemForVC:self clickedHandler:^{
        NSLog(@"搜索按钮被点击");
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        CGFloat width = (kScreenW - 3 * 10) / 2;
        //390 219
        CGFloat height = width * 219 / 390 + 30;
        layout.itemSize = CGSizeMake((long)width, height);
        //跳转到搜索控制器
        TRSearchViewController *vc = [[TRSearchViewController alloc] initWithCollectionViewLayout:layout];
        //推出下一页时, 隐藏掉tabbar
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];

    
    self.collectionView.backgroundColor = kRGBA(234, 234, 234, 1);
    [self.collectionView registerClass:[TRLiveCell class] forCellWithReuseIdentifier:reuseIdentifier];
    __weak typeof(self) weakSelf = self;
    [self.collectionView addHeaderRefresh:^{
        [weakSelf.liveVM getDataWithMode:RequestModeRefresh completionHandler:^(NSError *error) {
            [weakSelf.collectionView reloadData];
            [weakSelf.collectionView endHeaderRefresh];
        }];
    }];
    [self.collectionView beginHeaderRefresh];
    [self.collectionView addFooterRefresh:^{
        [weakSelf.liveVM getDataWithMode:RequestModeMore completionHandler:^(NSError *error) {
            [weakSelf.collectionView reloadData];
            [weakSelf.collectionView endFooterRefresh];
        }];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.liveVM.rowNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TRLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell.iconIV setImageWithURL:[self.liveVM iconURLForRow:indexPath.row] placeholder:[UIImage imageNamed:@"主播正在赶来"]];
    cell.nickLb.text = [self.liveVM nickForRow:indexPath.row];
    cell.titleLb.text = [self.liveVM titleForRow:indexPath.row];
    cell.viewLb.text = [self.liveVM viewForRow:indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AVPlayerViewController *vc = [AVPlayerViewController new];
    vc.player = [AVPlayer playerWithURL:[self.liveVM uidForRow:indexPath.row].yx_VideoURL];
    //NSLog(@"%@", [self.liveVM uidForRow:indexPath.row].yx_VideoURL);
    [vc.player play];
    [self presentViewController:vc animated:YES completion:nil];
}
#pragma mark - LazyLoad 懒加载
- (TRLiveViewModel *)liveVM {
	if(_liveVM == nil) {
		_liveVM = [[TRLiveViewModel alloc] init];
	}
	return _liveVM;
}

@end

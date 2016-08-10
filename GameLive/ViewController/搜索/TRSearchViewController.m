//
//  TRSearchViewController.m
//  GameLive
//
//  Created by tarena on 16/8/5.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRSearchViewController.h"
#import "TRSearchViewModel.h"
#import "TRLiveCell.h"

@import AVFoundation;
@import AVKit;

@interface TRSearchViewController ()<UISearchBarDelegate>
@property (nonatomic) TRSearchViewModel *searchViewModel;
@end

@implementation TRSearchViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar endEditing:YES];
    if (searchBar.text.length > 0) {
        self.searchViewModel.keywords = searchBar.text;
        [self.view showHUD];
        [self.searchViewModel getDataWithMode:RequestModeRefresh completionHandler:^(NSError *error) {
            [self.view hideHUD];
            [self.collectionView reloadData];
        }];
    }else{
        [self.view showWarning:@"请输入搜索内容"];
    }
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        UISearchBar *bar = [[UISearchBar alloc] init];
        bar.delegate = self;
        bar.placeholder = @"请输入搜索内容";
        self.navigationItem.titleView = bar;
        [TRFactory addBackItemForVC:self];
        [TRFactory addSearchItemForVC:self clickedHandler:^{
            [bar endEditing:YES];
            if (bar.text.length > 0) {
                self.searchViewModel.keywords = bar.text;
                [self.view showHUD];
                [self.searchViewModel getDataWithMode:RequestModeRefresh completionHandler:^(NSError *error) {
                    [self.view hideHUD];
                    [self.collectionView reloadData];
                }];
            }else{
                [self.view showWarning:@"请输入搜索内容"];
            }
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    MJWeakSelf
    [self.collectionView registerClass:[TRLiveCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView addHeaderRefresh:^{
        [weakSelf.searchViewModel getDataWithMode:RequestModeRefresh completionHandler:^(NSError *error) {
            [weakSelf.collectionView reloadData];
            [weakSelf.collectionView endHeaderRefresh];
        }];
    }];
    //刚进入时,没有内容需要搜索. 所以不刷新
    //[self.collectionView beginHeaderRefresh];
    [self.collectionView addFooterRefresh:^{
        [weakSelf.searchViewModel getDataWithMode:RequestModeMore completionHandler:^(NSError *error) {
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
    return self.searchViewModel.rowNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TRLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell.iconIV setImageWithURL:[self.searchViewModel iconURLForRow:indexPath.row] placeholder:[UIImage imageNamed:@"主播正在赶来"]];
    cell.nickLb.text = [self.searchViewModel nickForRow:indexPath.row];
    cell.titleLb.text = [self.searchViewModel titleForRow:indexPath.row];
    cell.viewLb.text = [self.searchViewModel viewForRow:indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AVPlayerViewController *vc = [AVPlayerViewController new];
    vc.player = [AVPlayer playerWithURL:[self.searchViewModel videoURLForRow:indexPath.row]];
    //NSLog(@"%@", [self.liveVM uidForRow:indexPath.row].yx_VideoURL);
    [vc.player play];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - LazyLoad 懒加载
- (TRSearchViewModel *)searchViewModel {
	if(_searchViewModel == nil) {
		_searchViewModel = [[TRSearchViewModel alloc] init];
	}
	return _searchViewModel;
}

@end

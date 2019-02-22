//
//  ViewController.m
//  RAC+MVVM
//
//  Created by yellow on 2018/12/31.
//  Copyright © 2018 yellow. All rights reserved.
//

#import "ViewController.h"
#import "NewsViewModel.h"
#import <MJRefresh/MJRefresh.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NewsTableViewCell.h"
#import "ImagesTableViewCell.h"
#import "SVProgressHud.h"
#import "FLEXManager.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *dataSource;

@property (nonatomic,strong) NewsViewModel *viewModel;

@end

@implementation ViewController

- (NewsViewModel *)viewModel {
    
    if (_viewModel == nil) {
        _viewModel = [[NewsViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self initSubViews];
    
    [self bindViewModel];
    
    // 添加手势唤起FLEX
    UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGR)];
    [self.view addGestureRecognizer:swipeGR];
}


- (void)initSubViews {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self)
        self.viewModel.type = Down;
        [self.viewModel.command execute:nil];
        
        [SVProgressHUD showWithStatus:@"加载中..."];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        @strongify(self)
        self.viewModel.type = Up;
        [self.viewModel.command execute:nil];
        
        [SVProgressHUD showWithStatus:@"加载中..."];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)bindViewModel {
    @weakify(self);
    [self.viewModel.command.executionSignals.switchToLatest subscribeNext:^(NSArray *dataSource) {
        
        @strongify(self)
        
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        
        self.dataSource = dataSource;
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
        [SVProgressHUD dismissWithDelay:1.5];
    }];
    
}

- (void)handleSwipeGR {
    [[FLEXManager sharedManager] showExplorer];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsModel *model = self.dataSource[indexPath.row];
    
    if (model.newsImageInfoList.count < 3) {
        
        NewsTableViewCell *cell = [NewsTableViewCell cellWithTableView:tableView];

        cell.model = model;
        
        return cell;
        
    }else {
        
        ImagesTableViewCell *cell = [ImagesTableViewCell cellWithTableView:tableView];
        
        cell.model = model;
        
        return cell;
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

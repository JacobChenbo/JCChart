//
//  MatrixViewController.m
//  表格Demo
//
//  Created by 陈波 on 2017/8/15.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "MatrixViewController.h"
#import <Masonry.h>
#import "JCAutoScrollMatrixView.h"
#import "HXDetailTableSingleRowModel.h"
#import "HXDetailTableSingleValueModel.h"

@interface MatrixViewController ()

@end

@implementation MatrixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViews];
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    JCAutoScrollMatrixView *view = [[JCAutoScrollMatrixView alloc] init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.superview).offset(100);
        make.left.equalTo(view.superview).offset(16);
        make.right.equalTo(view.superview).offset(-16);
        make.bottom.equalTo(view.superview);
    }];
    view.dataSource = [self setupMorkData];
    
}

- (NSArray *)setupMorkData {
    HXDetailTableSingleRowModel *rowModel = [[HXDetailTableSingleRowModel alloc] init];
    rowModel.key = @"发动机";
    
    HXDetailTableSingleValueModel *valueModel = [[HXDetailTableSingleValueModel alloc] init];
    valueModel.price = @"¥20,000";
    valueModel.detail = @[@"111", @"222"];
    
    HXDetailTableSingleValueModel *valueModel0 = [[HXDetailTableSingleValueModel alloc] init];
    
    rowModel.values = @[valueModel, valueModel0, valueModel, valueModel0];
    
    HXDetailTableSingleRowModel *rowModel1 = [[HXDetailTableSingleRowModel alloc] init];
    rowModel1.key = @"发动fdsfdsfds机";
    rowModel1.values = @[valueModel0, valueModel, valueModel0, valueModel];
    
    return @[rowModel, rowModel1, rowModel, rowModel1,
             rowModel, rowModel1, rowModel, rowModel1,
             rowModel, rowModel1, rowModel, rowModel1,
             rowModel, rowModel1, rowModel, rowModel1,
             rowModel, rowModel1, rowModel, rowModel1];
}

@end

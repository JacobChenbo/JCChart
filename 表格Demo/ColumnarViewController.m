//
//  ColumnarViewController.m
//  表格Demo
//
//  Created by 陈波 on 2017/8/15.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "ColumnarViewController.h"
#import "JCColumarFormView.h"
#import <Masonry.h>

@interface ColumnarViewController ()

@end

@implementation ColumnarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    JCColumarFormView *salvageView = [[JCColumarFormView alloc] initWithDataSource:@"52.07,43.78,36.77,30.90,25.89,80" estPrice:0 formViewType:ColumarFormViewTypeSalvage];
    [self.view addSubview:salvageView];
    [salvageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(salvageView.superview);
        make.top.equalTo(salvageView.superview).offset(100);
    }];

}

@end

//
//  ViewController.m
//  表格Demo
//
//  Created by Jacob on 5/14/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "MatrixViewController.h"
#import "ColumnarViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupViews];
}

- (void)setupViews {
    UIButton *button1 = [UIButton new];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(button1.superview);
        make.top.equalTo(button1.superview).offset (100);
        make.height.equalTo(@50);
    }];
    [button1 setTitle:@"柱状图" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(onClickButton1) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [UIButton new];
    [self.view addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(button2.superview);
        make.top.equalTo(button1.mas_bottom).offset (20);
        make.height.equalTo(@50);
    }];
    [button2 setTitle:@"表格图" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(onClickButton2) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onClickButton1 {
    MatrixViewController *matrixVC = [[MatrixViewController alloc] init];
    [self.navigationController pushViewController:matrixVC animated:YES];
}

- (void)onClickButton2 {
    ColumnarViewController *matrixVC = [[ColumnarViewController alloc] init];
    [self.navigationController pushViewController:matrixVC animated:YES];
}

@end

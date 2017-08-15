//
//  JCAutoScrollMatrixView.m
//  表格Demo
//
//  Created by Jacob on 6/21/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "JCAutoScrollMatrixView.h"
#import "HXProductsViewElementConfig.h"
#import "HXDetailTableSingleRowModel.h"
#import "HXDetailTableSingleValueModel.h"

@interface JCAutoScrollMatrixView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *colunmScroll;   // 列标头
@property (nonatomic, strong) UIScrollView *rowScroll;      // 行表头
@property (nonatomic, strong) UIScrollView *dataScroll;     // 数据

@property (nonatomic, assign) NSInteger rowNum;     // 行数
@property (nonatomic, assign) CGFloat width;        // 单元格的宽度
@property (nonatomic, assign) CGFloat height;       // 单元格的高度
@property (nonatomic, assign) CGFloat dy;           // 高度

@end

@implementation JCAutoScrollMatrixView

- (id)init {
    if (self = [super init]) {
        self.colunmScroll = [[UIScrollView alloc] init];
        self.rowScroll = [[UIScrollView alloc] init];
        self.dataScroll = [[UIScrollView alloc] init];
        self.colunmScroll.scrollEnabled = NO;
        self.colunmScroll.delegate = self;
        self.rowScroll.scrollEnabled = NO;
        self.rowScroll.delegate = self;
        self.dataScroll.scrollEnabled = YES;
        self.dataScroll.delegate = self;
        self.dataScroll.bounces = NO;
        self.backgroundColor = UIColorFromRGB(0xD5D5D5);
        self.layer.borderColor = UIColorFromRGB(0xD5D5D5).CGColor;
        self.layer.borderWidth = 1.0;
        
        [self addSubview:self.colunmScroll];
        [self addSubview:self.rowScroll];
        [self addSubview:self.dataScroll];
        
        self.width = (kScreenWidth - 16 * 2) / 4;  // 默认显示4行的宽度
    }
    return self;
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    
    NSArray *rowHeader = @[@"质保涵盖范围", @"基础宝\n999/年", @"畅行宝\n2080/年", @"省心宝\n3980/年", @"全家宝\n8888/年"];
    [self addRecord:rowHeader]; // 首行
    
    NSMutableArray *record = [[NSMutableArray alloc] init];
    for (HXDetailTableSingleRowModel *model in dataSource) {
        [record addObject:model.key];
        for (HXDetailTableSingleValueModel *valueModel in model.values) {
            [record addObject:valueModel];
        }
        [self addRecord:record];
        [record removeAllObjects];
    }
    
    CGSize size = multilineTextSize(@"质保涵盖范围", [UIFont systemFontOfSize:14], CGSizeMake(self.width - 15 * 2, MAXFLOAT));
    __weak JCAutoScrollMatrixView *weakSelf = self;
    [self.rowScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.rowScroll.superview).offset(weakSelf.width);
        make.top.right.equalTo(weakSelf.rowScroll.superview);
        make.height.equalTo(@(size.height + 14 * 2 + 1));
    }];
    [self.colunmScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.rowScroll.mas_bottom);
        make.left.bottom.equalTo(weakSelf.colunmScroll.superview);
        make.width.equalTo(@(weakSelf.width));
    }];
    [self.dataScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.colunmScroll.mas_right);
        make.top.equalTo(weakSelf.rowScroll.mas_bottom);
        make.right.bottom.equalTo(weakSelf.dataScroll.superview);
    }];
    
    [self.rowScroll setContentSize:CGSizeMake(self.width * 4, size.height + 14 * 2)];
    [self.colunmScroll setContentSize:CGSizeMake(self.width, self.dy)];
    [self.dataScroll setContentSize:CGSizeMake(self.width * 4, self.dy)];
}

// 添加数据
- (void)addRecord:(NSArray *)record {
    NSString *colunmHeaderText = [record objectAtIndex:0];
    UIFont *textFont = [UIFont systemFontOfSize:14];
    UIColor *textColor = UIColorFromRGB(0x444444);
    
    CGSize size = multilineTextSize(colunmHeaderText, textFont, CGSizeMake(self.width - 15 * 2, MAXFLOAT));
    self.height = size.height + 14 * 2;
    NSLog(@"widht: %f, height: %f", self.width, self.height);
    for (NSInteger i = 0; i < record.count; i++) {
        CGFloat dx = 0;
        UIView *singleView = [UIView new];
        singleView.backgroundColor = [UIColor whiteColor];
        
        __weak JCAutoScrollMatrixView *weakSelf = self;
        if (self.rowNum == 0 && i != 0) {
            [self.rowScroll addSubview:singleView]; // 第一行
            
        } else if (self.rowNum != 0 && i == 0) {
            [self.colunmScroll addSubview:singleView];  // 第一列
            
        } else if (self.rowNum == 0 && i == 0) {
            [self addSubview:singleView];   // 左上角
        } else {
            [self.dataScroll addSubview:singleView]; // 数据表格
        }
        
        [singleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(singleView.superview).offset(i > 1 ? (i - 1) * weakSelf.width : 0);
            make.top.equalTo(singleView.superview).offset(weakSelf.rowNum >= 1 ? (weakSelf.dy) : (weakSelf.dy + 1));
            make.size.mas_equalTo(CGSizeMake(weakSelf.width - 1, weakSelf.height - 1));
        }];
        
        dx += self.width;
        
        if ([[record objectAtIndex:i] isKindOfClass:[HXDetailTableSingleValueModel class]]) {
            HXDetailTableSingleValueModel *valueModel = [record objectAtIndex:i];
            
            if (valueModel.price.length > 0) {
                UIImageView *icon = [UIImageView new];
                [singleView addSubview:icon];
                [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(icon.superview).offset(-5);
                    make.centerY.equalTo(icon.superview);
                    make.size.mas_equalTo(CGSizeMake(13, 13));
                }];
                icon.backgroundColor = [UIColor blueColor];
                
                UILabel *price = [UILabel new];
                [singleView addSubview:price];
                [price mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(price.superview).offset(5);
                    make.top.bottom.equalTo(price.superview);
                    make.right.equalTo(icon.mas_left).offset(-5);
                }];
                price.text = valueModel.price;
                price.textColor = textColor;
                price.font = textFont;
            } else {
                UIView *lineView = [UIView new];
                [singleView addSubview:lineView];
                [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(lineView.superview);
                    make.height.equalTo(@1);
                    make.width.equalTo(@29);
                }];
                lineView.backgroundColor = UIColorFromRGB(0x444444);
            }
            
        } else {
            UILabel *title = [UILabel new];
            [singleView addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(title.superview).insets(UIEdgeInsetsMake(0, 10, 0, 10));
            }];
            title.text = [record objectAtIndex:i];
            title.font = textFont;
            title.textColor = textColor;
            title.numberOfLines = 0;
            title.textAlignment = NSTextAlignmentCenter;
        }
    }
    
    if (self.rowNum == 0) {
        self.dy = 0;
    } else {
        self.dy += self.height;
    }
    self.rowNum++;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint dataOffset = self.dataScroll.contentOffset;
    
    CGPoint rowOffset = self.rowScroll.contentOffset;
    rowOffset.x = dataOffset.x;
    self.rowScroll.contentOffset = rowOffset;
    
    CGPoint colunmOffset = self.colunmScroll.contentOffset;
    colunmOffset.y = dataOffset.y;
    self.colunmScroll.contentOffset = colunmOffset;
    if (dataOffset.y == 0) {
        self.colunmScroll.contentOffset = CGPointZero;
    } else if (dataOffset.x == 0) {
        self.rowScroll.contentOffset = CGPointZero;
    }
}

@end

//
//  UCCarValueResultRectangleView.m
//  HXMall
//
//  Created by 吴凯 on 16/5/13.
//  Copyright © 2016年 HXQC. All rights reserved.
//

#import "JCColumnarRectangleView.h"
#import "HXProductsViewElementConfig.h"

@interface JCColumnarRectangleView ()

@property (nonatomic,copy)NSString *xPosition;//横坐标

@property (nonatomic,copy)NSString *value;

@property (nonatomic,strong)UIColor *color;

@property (nonatomic,strong) MASViewAttribute *maxHeight;
@property (nonatomic, assign) CGFloat percentage;

@property (nonatomic, strong) UIView *rectangleView;

@end

static CGFloat bottomPadding = 38;//最后一根线距离底部的距离
static CGFloat rectangleViewWidth = 25;//线和线的间距

@implementation JCColumnarRectangleView


-(id)initWithXPosition:(NSString *)xPosition value:(NSString *)value  maxHeight:(MASViewAttribute *)height percentage:(CGFloat)percentage andColor:(UIColor *)color {
    
    if (self = [super init]) {
        self.xPosition = xPosition;
        self.value = value;
        self.color = color;
        self.maxHeight = height;
        self.percentage = percentage;
        
        [self setUpViews];
    }
    
    return self;
    
}

-(void)setUpViews{
    
    UIView *rectangleView = [[UIView alloc] init];
    self.rectangleView = rectangleView;
    [self addSubview:rectangleView];
    
    UILabel *valueLabel = [[UILabel alloc] init];
    [self addSubview:valueLabel];
    
    UILabel *xPositionLabel = [[UILabel alloc] init];
    [self addSubview:xPositionLabel];
    
    [rectangleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(rectangleView.superview);
        make.width.equalTo(@(rectangleViewWidth));
        make.bottom.equalTo(rectangleView.superview.mas_bottom).offset(-bottomPadding);
    }];
    
    [valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(rectangleView);
        make.bottom.equalTo(rectangleView.mas_top).offset(-4);
    }];
    
    [xPositionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(rectangleView);
        make.top.equalTo(rectangleView.mas_bottom).offset(6);
    }];
    
    //文字
    valueLabel.text = self.value;
    xPositionLabel.text = self.xPosition;
    
    //颜色
    valueLabel.textColor = CommonCellMinorFontColor;
    xPositionLabel.textColor = CommonCellMinorFontColor;
    rectangleView.backgroundColor = self.color;
    
    //字体
    valueLabel.font = [UIFont systemFontOfSize:11.0f];
    xPositionLabel.font = [UIFont systemFontOfSize:11.0f];
    
    //位置
    valueLabel.textAlignment = NSTextAlignmentCenter;
    xPositionLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [self performSelector:@selector(animate) withObject:nil afterDelay:0.0];
}

- (void)animate {
    __weak JCColumnarRectangleView *weakSelf = self;
    [UIView animateWithDuration:1.0 animations:^{
        [weakSelf.rectangleView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(weakSelf.maxHeight).multipliedBy(weakSelf.percentage);
            [weakSelf.superview layoutIfNeeded];
        }];
    }];
    
}

@end

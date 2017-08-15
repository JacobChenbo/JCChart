//
//  UCCarValueResultFormView.m
//  HXMall
//
//  Created by Jacob on 16/5/13.
//  Copyright © 2016年 HXQC. All rights reserved.
//

#import "JCColumarFormView.h"
#import "HXProductsViewElementConfig.h"
#import "JCColumnarRectangleView.h"
#import "UIView+JWMasonryConstraint.h"
#import <Masonry/Masonry.h>
@interface JCFormContentView : UIView

@end

@implementation JCFormContentView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, UIColorFromRGB(0xC6C6C6).CGColor);
    CGContextFillRect(ctx, rect);
    
    UIBezierPath *bezieerPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:2];
    
    CGPathRef path = bezieerPath.CGPath;
    CGContextAddPath(ctx, path);
    
    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextFillPath(ctx);
}

@end

@interface JCColumarFormView ()

@property (nonatomic,copy)NSString *title;//标题
@property (nonatomic,copy)NSString *unit;//单位
@property (nonatomic,strong)NSArray *yPositions;//纵坐标数组
@property (nonatomic,strong)NSMutableArray *xPositions;//横坐标数组

@property (nonatomic, assign) CGFloat estPrice; // 预估价格
@property (nonatomic, assign) ColumarFormViewType type;    // 表格类型
@property (nonatomic, strong) NSArray *values;//柱子的数值
@property (nonnull, strong) UIView *formView;

@property (nonatomic, strong) UIView *rectContentView;  //柱子父View
@property (nonatomic, strong) MASViewAttribute *maxHeight;//柱子最大高度
@property (nonatomic, strong) NSArray *rectangleViews;//矩形图数组

@property (nonatomic, strong) NSArray *colorMap; // 颜色数组

@end

static CGFloat leftPadding = 38;//横线离的左边距
static CGFloat rightPadding = 23;//横线右边距

@implementation JCColumarFormView

- (id)initWithDataSource:(NSString *)dataSource estPrice:(CGFloat)estPrice formViewType:(ColumarFormViewType)formViewType {
    if (self = [super init]) {
        self.estPrice = estPrice;
        self.type = formViewType;
        self.values = [dataSource componentsSeparatedByString:@","];
        if (self.values.count > 0) {
            [self setupDataSource];
            [self setUpViews];
        }
        
    }
    return self;
}

- (void)setupDataSource {
    NSInteger count = self.values.count;
    if (self.type == ColumarFormViewTypePrice) {
        self.title = [NSString stringWithFormat:@"未来%ld年价格", (long)count];
        self.unit = @"单位:万元";
        self.yPositions = @[
                            [NSString stringWithFormat:@"%.2f", self.estPrice],
                            [NSString stringWithFormat:@"%.2f", self.estPrice * 0.8],
                            [NSString stringWithFormat:@"%.2f", self.estPrice * 0.6],
                            [NSString stringWithFormat:@"%.2f", self.estPrice * 0.4],
                            [NSString stringWithFormat:@"%.2f", self.estPrice * 0.2],
                            [NSString stringWithFormat:@"%.2f", self.estPrice * 0]
                            ];
    } else if (self.type == ColumarFormViewTypeSalvage) {
        self.title = [NSString stringWithFormat:@"未来%ld年", (long)count];
        self.unit = @"单位:%";
        self.yPositions = @[@"100", @"80", @"60", @"40", @"20", @"0"];
    }
    
    NSCalendarUnit calendarUnit = NSCalendarUnitYear;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:calendarUnit fromDate:[NSDate date]];
    NSInteger currentYear = dateComponents.year;
    
    for (int i = 1; i <= count; i++) {
        NSString *year = [NSString stringWithFormat:@"%ld年", (long)(currentYear + i)];
        [self.xPositions addObject:year];
    }
}

-(void)setUpViews{
    
    JCFormContentView *contentView = [[JCFormContentView alloc] init];
    [self addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.superview).offset(8);
        make.bottom.equalTo(contentView.superview).offset(-8);
        make.left.equalTo(contentView.superview).offset(16);
        make.right.equalTo(contentView.superview).offset(-16);
    }];
    
    contentView.layer.shadowColor = UIColorFromRGB(0xC6C6C6).CGColor;
    contentView.layer.shadowOffset = CGSizeMake(0, 4);
    contentView.layer.shadowOpacity = 1;
    
    
    UIView *titleView = [[UIView alloc] init];
    [contentView addSubview:titleView];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(contentView);
        make.height.equalTo(@44);
    }];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.superview).offset(12);
        make.centerY.equalTo(titleLabel.superview);
    }];
    titleLabel.text = self.title;
    titleLabel.textColor = CommonCellMainFontColor;
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    
    //分界线
    UIView *lineView = [[UIView alloc] init];
    [titleView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(lineView.superview);
        make.height.equalTo(@(3));
    }];
    lineView.backgroundColor = UIColorFromRGB(0xd5d5d5);
    
    //表格
    UIView *formView = [[UIView alloc] init];
    self.formView = formView;
    [contentView addSubview:formView];
    [formView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(formView.superview);
        make.top.equalTo(titleView.mas_bottom);
        make.bottom.equalTo(formView.superview);
    }];
    
    //单位
    UILabel *unitLabel = [[UILabel alloc] init];
    [formView addSubview:unitLabel];
    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(unitLabel.superview).offset(12);
        make.left.equalTo(unitLabel.superview).offset(12);
    }];
    unitLabel.text = self.unit;
    unitLabel.textColor = CommonCellMinorFontColor;
    unitLabel.font = [UIFont systemFontOfSize:12.0f];
    unitLabel.textAlignment = NSTextAlignmentLeft;
    
    //纵坐标
    UIView *lastView;
    lastView = unitLabel;
    UIView *tempView = [UIView new];
    [formView addSubview:tempView];
    tempView.backgroundColor = [UIColor clearColor];
    [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tempView.superview).offset(0);
        make.width.equalTo(@1);
    }];
    for (int i = 0; i < self.yPositions.count; i++) {
        
        UIView *yPositionView = [self yPositionViewByYPosition:self.yPositions[i]];
        if (i == 0) {//第一根线
            [yPositionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(yPositionView.superview).offset(-rightPadding);
                make.height.equalTo(@(15));
                make.top.equalTo(lastView.mas_bottom).offset(10);
            }];
            [tempView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(yPositionView.mas_centerY);
            }];
        }else{//
            [yPositionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(yPositionView.superview).offset(-rightPadding);
                make.height.equalTo(@(15));
                make.top.equalTo(lastView.mas_bottom).offset(10);
            }];
        }
        if (i == self.yPositions.count - 1) {//最后一根线
            [yPositionView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(yPositionView.superview).offset(-30);
            }];
            [tempView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(yPositionView.mas_centerY);
            }];
        }
        
        
        lastView = yPositionView;
    }
    
    self.maxHeight = tempView.mas_height;
    
    //横坐标
    UIView *xPositionContentView = [[UIView alloc] init];
    [formView addSubview:xPositionContentView];
    self.rectContentView = xPositionContentView;
    
    [xPositionContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(xPositionContentView.superview).offset(leftPadding + 8);
        make.right.equalTo(xPositionContentView.superview).offset(-rightPadding - 8);
        make.top.equalTo(unitLabel.mas_bottom);
        make.bottom.equalTo(xPositionContentView.superview);
    }];
    [self setUpXPositionContentViewByView:xPositionContentView];
}

-(void)setUpXPositionContentViewByView:(UIView *)xPositionContentView{
    
    NSMutableArray *rectangleViews = [NSMutableArray array];
    for (int j = 0; j < self.values.count; j ++) {
        CGFloat currentNumber = [self.values[j] floatValue];
        CGFloat maxNumber = 0;
        if (self.type == ColumarFormViewTypePrice) {
            maxNumber = self.estPrice;
        } else if (self.type == ColumarFormViewTypeSalvage) {
            maxNumber = 100.00;
        }
        CGFloat percentage = currentNumber / maxNumber;
        
        JCColumnarRectangleView *rectangleView = [[JCColumnarRectangleView alloc] initWithXPosition:self.xPositions[j] value:self.values[j] maxHeight:self.maxHeight percentage:percentage andColor:j < 5 ? self.colorMap[j] : self.colorMap[4]];
        [rectangleViews addObject:rectangleView];
    }
    
    self.rectangleViews = rectangleViews;
    [xPositionContentView makeEqualWidthViews:rectangleViews];
}

- (void)test {
    [self.rectContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self setUpXPositionContentViewByView:self.rectContentView];
}

-(UIView *)yPositionViewByYPosition:(NSString *)position{
 
    UIView *positionView = [[UIView alloc] init];
    [self.formView addSubview:positionView];
    
    UIView *lineView = [[UIView alloc] init];
    [positionView addSubview:lineView];
    lineView.backgroundColor = UIColorFromRGB(0xebebeb);
    
    CGFloat lineViewWidth = kScreenWidth - 16 - 16 - leftPadding - rightPadding;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.equalTo(lineView.superview);
        make.height.equalTo(@(1));
        make.width.equalTo(@(lineViewWidth));
    }];
    
    UILabel *positionLabel = [[UILabel alloc] init];
    [positionView addSubview:positionLabel];
    [positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lineView.mas_left).offset(-4);
        make.centerY.equalTo(lineView);
    }];
    positionLabel.text = position;
    positionLabel.textColor = CommonCellMinorFontColor;
    positionLabel.textAlignment = NSTextAlignmentRight;
    positionLabel.font = [UIFont systemFontOfSize:11];
    
    return positionView;
}

- (NSArray *)colorMap {
    if (_colorMap == nil) {
        _colorMap = @[UIColorFromRGB(0xFC6620), UIColorFromRGB(0xF98824), UIColorFromRGB(0xFDA431), UIColorFromRGB(0xFDC351), UIColorFromRGB(0xFED23E)];
    }
    return _colorMap;
}

- (NSArray *)values {
    if (_values == nil) {
        _values = [[NSArray alloc] init];
    }
    return _values;
}

- (NSArray *)xPositions {
    if (_xPositions == nil) {
        _xPositions = [[NSMutableArray alloc] init];
    }
    return _xPositions;
}

@end

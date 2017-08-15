//
//  UIView+JWMasonryConstraint.m
//  JWMasonryConstraint
//
//  Created by  on 6/18/15.
//  Copyright (c) 2015 XieJunwei. All rights reserved.
//

#import "UIView+JWMasonryConstraint.h"
#import <Masonry.h>
@implementation UIView (JWEqualWidthConstraint)

-(void)makeEqualWidthViews:(NSArray *)views{
    [self makeEqualWidthViews:views
                  LeftPadding:0
                 RightPadding:0
                   TopPadding:0
                BottomPadding:0
                  viewPadding:0];
}

-(void)makeEqualWidthViews:(NSArray *)views
                 LRpadding:(CGFloat)LRpadding{
    [self makeEqualWidthViews:views
                  LeftPadding:LRpadding
                 RightPadding:LRpadding
                   TopPadding:0
                BottomPadding:0
                  viewPadding:0];
}

-(void)makeEqualWidthViews:(NSArray *)views
                 TBpadding:(CGFloat)TBpadding{
    [self makeEqualWidthViews:views
                  LeftPadding:0
                 RightPadding:0
                   TopPadding:TBpadding
                BottomPadding:TBpadding
                  viewPadding:0];
}

-(void)makeEqualWidthViews:(NSArray *)views
              viewPadding :(CGFloat)viewPadding{
    [self makeEqualWidthViews:views
                  LeftPadding:0
                 RightPadding:0
                   TopPadding:0
                BottomPadding:0
                  viewPadding:viewPadding];
}

-(void)makeEqualWidthViews:(NSArray *)views
                 LRpadding:(CGFloat)LRpadding
              viewPadding :(CGFloat)viewPadding{
    [self makeEqualWidthViews:views
                  LeftPadding:LRpadding
                 RightPadding:LRpadding
                   TopPadding:0
                BottomPadding:0
                  viewPadding:viewPadding];
}

-(void)makeEqualWidthViews:(NSArray *)views
                 LRpadding:(CGFloat)LRpadding
                 TBpadding:(CGFloat)TBpadding
              viewPadding :(CGFloat)viewPadding{
    [self makeEqualWidthViews:views
                  LeftPadding:LRpadding
                 RightPadding:LRpadding
                   TopPadding:TBpadding
                BottomPadding:TBpadding
                  viewPadding:viewPadding];
}

-(void)makeEqualWidthViews:(NSArray *)views
               LeftPadding:(CGFloat)leftPadding
              RightPadding:(CGFloat)rightPadding
                TopPadding:(CGFloat)topPadding
             BottomPadding:(CGFloat)bottomPadding
              viewPadding :(CGFloat)viewPadding{
    UIView *lastView;
    for (UIView *view in views) {
        [self addSubview:view];
        if (lastView) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(lastView);
                make.left.greaterThanOrEqualTo(lastView.mas_right).offset(viewPadding);
                make.left.equalTo(lastView.mas_right).offset(viewPadding).priority(999);//用于防止宽度过小时的约束错误
                make.width.equalTo(lastView);
            }];
        }else
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.equalTo(self).insets(UIEdgeInsetsMake(topPadding, leftPadding, bottomPadding, rightPadding));
            }];
        }
        lastView=view;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.greaterThanOrEqualTo(self).offset(-rightPadding);
        make.right.equalTo(self).offset(-rightPadding).priority(999);
    }];
}

@end

@implementation UIView (JWEqualHeightConstraint)

-(void)makeEqualHeightViews:(NSArray *)views{
    [self makeEqualHeightViews:views
                   LeftPadding:0
                  RightPadding:0
                    TopPadding:0
                 BottomPadding:0
                   viewPadding:0];
}

-(void)makeEqualHeightViews:(NSArray *)views
                  LRpadding:(CGFloat)LRpadding{
    [self makeEqualHeightViews:views
                   LeftPadding:LRpadding
                  RightPadding:LRpadding
                    TopPadding:0
                 BottomPadding:0
                   viewPadding:0];
}

-(void)makeEqualHeightViews:(NSArray *)views
                  TBpadding:(CGFloat)TBpadding{
    [self makeEqualHeightViews:views
                   LeftPadding:0
                  RightPadding:0
                    TopPadding:TBpadding
                 BottomPadding:TBpadding
                   viewPadding:0];
}

-(void)makeEqualHeightViews:(NSArray *)views
               viewPadding :(CGFloat)viewPadding{
    [self makeEqualHeightViews:views
                   LeftPadding:0
                  RightPadding:0
                    TopPadding:0
                 BottomPadding:0
                   viewPadding:viewPadding];
}

-(void)makeEqualHeightViews:(NSArray *)views
                  LRpadding:(CGFloat)LRpadding
               viewPadding :(CGFloat)viewPadding{
    [self makeEqualHeightViews:views
                   LeftPadding:LRpadding
                  RightPadding:LRpadding
                    TopPadding:0
                 BottomPadding:0
                   viewPadding:viewPadding];
}

-(void)makeEqualHeightViews:(NSArray *)views
                  LRpadding:(CGFloat)LRpadding
                  TBpadding:(CGFloat)TBpadding
               viewPadding :(CGFloat)viewPadding{
    [self makeEqualHeightViews:views
                   LeftPadding:LRpadding
                  RightPadding:LRpadding
                    TopPadding:TBpadding
                 BottomPadding:TBpadding
                   viewPadding:viewPadding];
}

-(void)makeEqualHeightViews:(NSArray *)views
                LeftPadding:(CGFloat)leftPadding
               RightPadding:(CGFloat)rightPadding
                 TopPadding:(CGFloat)topPadding
              BottomPadding:(CGFloat)bottomPadding
                viewPadding:(CGFloat)viewPadding{
    UIView *lastView;
    for (UIView *view in views) {
        [self addSubview:view];
        if (lastView) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(lastView);
                make.top.greaterThanOrEqualTo(lastView.mas_bottom).offset(viewPadding);
                make.top.equalTo(lastView.mas_bottom).offset(viewPadding).priority(999);//用于防止高度过小时的约束错误
                make.height.equalTo(lastView);
            }];
        }else
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.equalTo(self).insets(UIEdgeInsetsMake(topPadding, leftPadding, bottomPadding, rightPadding));
            }];
        }
        lastView=view;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.greaterThanOrEqualTo(self).offset(-bottomPadding);
        make.bottom.equalTo(self).offset(-bottomPadding).priority(999);
    }];
}

@end


@implementation UIView (JWCoverConstraint)

- (void)jw_makeCoverOnView:(UIView *)superView{
    [superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
}

@end


@implementation UIView (JWEqualWidthHeightConstraint)

- (void)makeEqualWidthHeightViews:(NSArray *)views numberOfRows:(NSInteger)rows{
    if (rows < 1) {
        return;
    }
    NSInteger columns = [UIView numberOfColumnsWithItemCount:views.count numberOfRows:rows];
    [self makeEqualWidthHeightViews:views numberOfColumns:columns viewVertivalPadding:0 viewHorizenPadding:0 insets:UIEdgeInsetsZero];
    
}


- (void)makeEqualWidthHeightViews:(NSArray *)views
                     numberOfRows:(NSInteger)rows
              viewVertivalPadding:(CGFloat)viewVertivalPadding
               viewHorizenPadding:(CGFloat)viewHorizenPadding
                           insets:(UIEdgeInsets)insets{
    if (rows<1) {
        return;
    }
    NSInteger columns = [UIView numberOfColumnsWithItemCount:views.count numberOfRows:rows];
    [self makeEqualWidthHeightViews:views numberOfColumns:columns viewVertivalPadding:viewVertivalPadding viewHorizenPadding:viewHorizenPadding insets:insets];
}


- (void)makeEqualWidthHeightViews:(NSArray *)views
                  numberOfColumns:(NSInteger)columns
              viewVertivalPadding:(CGFloat)viewVertivalPadding
               viewHorizenPadding:(CGFloat)viewHorizenPadding
                           insets:(UIEdgeInsets)insets{
    
    if (columns < 1 ) {
        return;
    }
    
    NSInteger rows = [UIView numberOfRowsWithItemCount:views.count numberOfColumns:columns];
    
    [self makeEqualWidthHeightViews:views numberOfRows:rows numberOfColumns:columns viewVertivalPadding:viewVertivalPadding viewHorizenPadding:viewHorizenPadding insets:insets];
}

- (void)makeEqualWidthHeightViews:(NSArray *)views
                     numberOfRows:(NSInteger)rows
                  numberOfColumns:(NSInteger)columns
              viewVertivalPadding:(CGFloat)viewVertivalPadding
               viewHorizenPadding:(CGFloat)viewHorizenPadding
                           insets:(UIEdgeInsets)insets{
    if (columns < 1 || rows < 1) {
        return;
    }
    
    //预处理 不得小于0
    if (viewHorizenPadding<0) {
        viewHorizenPadding = 0 ;
    }
    
    if (viewVertivalPadding < 0) {
        viewVertivalPadding = 0;
    }
    
    //应有总数量
    NSInteger shouldTotalView = rows * columns;
    
    NSMutableArray <UIView *> *allViews = [views mutableCopy];
    while (allViews.count < shouldTotalView) {
        UIView *placeHolderView = [UIView new];
        placeHolderView.hidden = YES;
        [allViews addObject:placeHolderView];
    }
    
    //横向子视图
    NSMutableArray <NSMutableArray *> *allViewsInRow = [NSMutableArray new];
    for (NSInteger row = 0; row < rows; row ++) {
        NSMutableArray <UIView *> *viewsInRow = [NSMutableArray new];
        [allViewsInRow addObject:viewsInRow];
    }
    //纵向子视图
    NSMutableArray <NSMutableArray *>  *allViewsInColumn = [NSMutableArray new];
    for (NSInteger column = 0; column < columns; column ++) {
        NSMutableArray <UIView *> *viewsInColumn = [NSMutableArray new];
        [allViewsInColumn addObject:viewsInColumn];
    }
    for (NSInteger row = 0; row < rows; row ++) {
        for (NSInteger column = 0; column < columns; column ++) {
            NSInteger index = row * columns +column;
            NSMutableArray <UIView *> *viewsInRow = allViewsInRow[row];
            NSMutableArray <UIView *> *viewsInColumn = allViewsInColumn[column];
            UIView *view = allViews[index];;
            view = allViews[index];
            [viewsInRow addObject:view];
            [viewsInColumn addObject:view];
            [self addSubview:view];
        }
    }
    
    if (rows < 2 || columns < 2) {
        //特殊处理
        if (rows >= 2 ) {
            //单列纵向排列 eg:rows = 3 , columns = 1
            [self makeEqualHeightViews:allViews LeftPadding:insets.left RightPadding:insets.right TopPadding:insets.top BottomPadding:insets.bottom viewPadding:viewVertivalPadding];
        }
        else{
            //单列横向排列 eg:rows = 1 , columns = 3 or eg:rows = 1 , columns = 1
            [self makeEqualWidthViews:allViews LeftPadding:insets.left RightPadding:insets.right TopPadding:insets.top BottomPadding:insets.bottom viewPadding:viewHorizenPadding];
        }
    }
    else{
        //常规等宽等高
        [allViewsInRow enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull viewsInRow, NSUInteger idx, BOOL * _Nonnull stop) {
            [viewsInRow mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:viewHorizenPadding leadSpacing:insets.left tailSpacing:insets.right];
        }];
        
        [allViewsInColumn enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull viewsInColumn, NSUInteger idx, BOOL * _Nonnull stop) {
            [viewsInColumn mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:viewVertivalPadding leadSpacing:insets.top tailSpacing:insets.bottom];
        }];
    }
    
    
}

@end



@implementation UIView (JWConstraitCommonCalcMethod)

+ (NSInteger)numberOfRowsWithItemCount:(NSInteger)count numberOfColumns:(NSInteger)columns{
    if (columns < 1 || count < 1) {
        return 0;
    }
    NSInteger rows = (count-1)/columns+1;
    return rows;
}

+ (NSInteger)numberOfColumnsWithItemCount:(NSInteger)count numberOfRows:(NSInteger)rows{
    if (rows < 1 || count < 1) {
        return 0;
    }
    NSInteger colums = (count-1)/rows+1;;
    return colums;
}

+ (CGFloat)cellViewLengthWithViewLength:(CGFloat)viewLength numberOfCellView:(NSInteger)numberOfCellView sidePadding:(CGFloat)sidePadding otherSidePadding:(CGFloat)otherSidePadding viewPadding:(CGFloat)viewPadding{
    if (numberOfCellView < 1) {
        return 0;
    }
    CGFloat result = (viewLength + viewPadding - sidePadding - otherSidePadding - viewPadding * numberOfCellView)*1.0/numberOfCellView;
    if (result < 0) {
        return 0;
    }
    return result;
}

+ (CGFloat)viewLengthWithCellViewLength:(CGFloat)cellViewLength numberOfCellView:(NSInteger)numberOfCellView sidePadding:(CGFloat)sidePadding otherSidePadding:(CGFloat)otherSidePadding viewPadding:(CGFloat)viewPadding{
    CGFloat result = cellViewLength * numberOfCellView + viewPadding * (numberOfCellView - 1) + sidePadding + otherSidePadding;
    if (result < 0) {
        return 0;
    }
    return result;
}

@end

// //////////////////////////////////////////////////////////////////////////


@implementation UIView (JWLayoutPriority)

- (void)makeRefuseHuggingAndCompressForAxis:(UILayoutConstraintAxis)axis{
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:axis];
    [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:axis];
}

@end

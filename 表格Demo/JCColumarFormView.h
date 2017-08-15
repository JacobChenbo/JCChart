//
//  UCCarValueResultFormView.h
//  HXMall
//
//  Created by Jacob on 16/5/13.
//  Copyright © 2016年 HXQC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ColumarFormViewType) {
    ColumarFormViewTypePrice,
    ColumarFormViewTypeSalvage
};

@interface JCColumarFormView : UIView

- (id)initWithDataSource:(NSString *)dataSource estPrice:(CGFloat)estPrice formViewType:(ColumarFormViewType)formViewType;

- (void)test;

@end

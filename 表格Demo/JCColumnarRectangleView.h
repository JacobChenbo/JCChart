//
//  UCCarValueResultRectangleView.h
//  HXMall
//
//  Created by 吴凯 on 16/5/13.
//  Copyright © 2016年 HXQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface JCColumnarRectangleView : UIView

-(id)initWithXPosition:(NSString *)xPosition value:(NSString *)value maxHeight:(MASViewAttribute *)height percentage:(CGFloat)percentage andColor:(UIColor *)color;

@end

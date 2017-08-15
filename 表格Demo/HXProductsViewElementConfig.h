//
//  HXProductsViewElementConfig.h
//  HXProducts
//
//  Created by  on 15/3/24.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <Foundation/Foundation.h>

#define UIColorFromRGBA(rgb,a) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:a]
#define UIColorFromRGB(rgb) UIColorFromRGBA(rgb,1.0f)

// 获取设备屏幕的物理尺寸
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

// 多行文本获取高度
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
#define multilineTextSize(text, font, maxSize) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define multilineTextSize(text, font, maxSize) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize] : CGSizeZero;
#endif

//主要颜色 红色
#define HXMainColor UIColorFromRGB(0xe02c36)
//主要按钮或控件点击状态 橙色
#define HXMainOrSslectedColor UIColorFromRGB(0xff7043)
//可点击 蓝色
#define HXClickableColor UIColorFromRGB(0x2196f3)
//特定按钮 绿色
#define HXCSpacialColor UIColorFromRGB(0x17a05e)
//分割线 浅灰
#define HXCSeperateLineColor UIColorFromRGB(0xd5d5d5)
//标签底色 象牙白
#define HXLableBackgroundColor UIColorFromRGB(0xf0f0f0)
//界面底色 白色
#define HXViewBackgroundColor UIColorFromRGB(0xfafafa)// UIColorFromRGB(0xfafafa)

//图像与label水平间距
#define CommonProductCellHorizontalPaddingBetweenThumbImageAndLabel 16
//Cell主要文字字体
#define CommonCellMainFont [UIFont systemFontOfSize:16]
//Cell主要文字颜色
#define CommonCellMainFontColor UIColorFromRGBA(0x000000, 0.87)
//Cell次要文字字体
#define CommonCellMinorFont [UIFont systemFontOfSize:14]
//Cell次要文字颜色
#define CommonCellMinorFontColor UIColorFromRGBA(0x000000, 0.54)

@interface HXProductsViewElementConfig : NSObject

@end



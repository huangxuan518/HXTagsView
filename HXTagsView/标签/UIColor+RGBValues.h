//
//  UIColor+RGBValues.h
//  LDBarButtonItemExample
//
//  Created by Christian Di Lorenzo on 1/24/13.
//  Copyright (c) 2013 Light Design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RGBValues)

- (CGFloat)red;
- (CGFloat)green;
- (CGFloat)blue;
- (CGFloat)alpha;

- (UIColor *)darkerColor;
- (UIColor *)lighterColor;
- (BOOL)isLighterColor;
- (BOOL)isClearColor;
- (UIColor *)fdd_colorByDarkeningColorWithValue:(CGFloat)value;
/**
 *  使用方式 [UIColor colorWithHex:@"007aff"];
 *
 *  @param string 16进制的颜色
 *
 *  @return 颜色对象
 */
+ (UIColor *)colorWithHex:(NSString *)string;
@end

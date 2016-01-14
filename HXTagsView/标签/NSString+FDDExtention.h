//
//  NSString+FDDExtention.h
//  SecondHouseBroker
//
//  Created by Yohunl on 14-8-18.
//  Copyright (c) 2014年 Lin Dongpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (FDDExtention)
- (CGSize)fdd_sizeWithFont:(UIFont *)font;
- (CGSize)fdd_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
+ (CGSize)calculateContentSize:(CGSize)size  content:(NSString *)content fontSize:(UIFont *)fontsize;

/**
 *  用来格式化字符串的,取自ReTableViewManager
 *
 *  @param format 格式化的字符串
 *
 *  @return 格式化后的
 */
- (NSString *)re_stringWithNumberFormat:(NSString *)format;

/**
 *  //sizeWithFont:forWidth:lineBreakMode:' is deprecated: first deprecated in iOS 7.0 - Use -boundingRectWithSize:options:attributes:context:
 //针对带有lineBreakMode参数的过期方法,可以使用如下
 *
 *  @param font 字体
 *  @param maxWidth 最大宽度
 *  @param lineBreakMode  多了后的切分方式
 *
 *  @return <#return value description#>
 */
-(CGSize)integralSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth lineBreakMode:(NSLineBreakMode)lineBreakMode;
-(CGSize)integralSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth numberOfLines:(NSInteger)lines;
-(CGSize)integralSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)maxSize;
@end

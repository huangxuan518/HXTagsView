//
//  UIImage+Tint.h
//
//  Created by Matt Gemmell on 04/07/2010.
//  Copyright 2010 Instinctive Code.
//

#import <UIKit/UIKit.h>

@interface UIImage (MGTint)

- (UIImage *)imageTintedWithColor:(UIColor *)color;
- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageOfSize:(CGSize)size color:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)circularImageWithColor:(UIColor *)color withDiamter:(NSUInteger)diameter;
+ (UIImage *)circularImageWithColor:(UIColor *)color withDiamter:(NSUInteger)diameter  scale:(CGFloat)scale;
+ (UIImage *)circularImageWithColor:(UIColor *)color waiColor:(UIColor *)waiColor withDiamter:(NSUInteger)diameter;
- (UIImage *)pbResizedImageWithWidth:(CGFloat)newWidth andTiledAreaFrom:(CGFloat)from1 to:(CGFloat)to1 andFrom:(CGFloat)from2 to:(CGFloat)to2;
+ (UIImage *)fdd_imageWithColor:(UIColor *)color size:(CGSize)size;
+(UIImage *)fdd_paopaoWithColor:(UIColor *)color size:(CGSize)size;


+(void)drawLinearGradient:(CGContextRef)context colorBottom:(UIColor *)colorBottom topColor:(UIColor *)topColor frame:(CGRect)frame;
+ (UIImage *)circularWithDiamter:(NSUInteger)diameter colorBottom:(UIColor *)colorBottom topColor:(UIColor *)topColor;
@end

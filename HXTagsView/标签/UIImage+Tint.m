//
//  UIImage+Tint.m
//
//  Created by Matt Gemmell on 04/07/2010.
//  Copyright 2010 Instinctive Code.
//

#import "UIImage+Tint.h"

@implementation UIImage (MGTint)


- (UIImage *)imageTintedWithColor:(UIColor *)color
{
	// This method is designed for use with template images, i.e. solid-coloured mask-like images.
	return [self imageTintedWithColor:color fraction:0.0]; // default to a fully tinted mask of the image.
}


- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction
{
	if (color) {
		// Construct new image the same size as this one.
		UIImage *image;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
		if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
			UIGraphicsBeginImageContextWithOptions([self size], NO, 0.f); // 0.f for scale means "scale for device's main screen".
		} else {
			UIGraphicsBeginImageContext([self size]);
		}
#else
		UIGraphicsBeginImageContext([self size]);
#endif
		CGRect rect = CGRectZero;
		rect.size = [self size];
		
		// Composite tint color at its own opacity.
		[color set];
		UIRectFill(rect);
		
		// Mask tint color-swatch to this image's opaque mask.
		// We want behaviour like NSCompositeDestinationIn on Mac OS X.
		[self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];
		
		// Finally, composite this image over the tinted mask at desired opacity.
		if (fraction > 0.0) {
			// We want behaviour like NSCompositeSourceOver on Mac OS X.
			[self drawInRect:rect blendMode:kCGBlendModeSourceAtop alpha:fraction];
		}
		image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		return image;
	}
	
	return self;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, .0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [color set];
    CGContextFillRect(context, CGRectMake(.0, .0, size.width, size.height));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIImage *)imageOfSize:(CGSize)size color:(UIColor *)color{
    return [self imageWithColor:color size:size];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageOfSize:CGSizeMake(1.0, 1.0) color:color];
}



+ (UIImage *)circularImageWithColor:(UIColor *)color withDiamter:(NSUInteger)diameter
{
    NSParameterAssert(color != nil);
    NSParameterAssert(diameter > 0);
    CGRect frame = CGRectMake(0.0f, 0.0f, diameter, diameter);
    
    UIScreen *screen = [UIScreen mainScreen];
    CGFloat scale = screen.scale;
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    
    UIBezierPath *imgPath = [UIBezierPath bezierPathWithOvalInRect:frame];
    [imgPath addClip];
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillEllipseInRect(context, frame);


    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)circularImageWithColor:(UIColor *)color withDiamter:(NSUInteger)diameter  scale:(CGFloat)scale {
    NSParameterAssert(color != nil);
    NSParameterAssert(diameter > 0);
    CGRect frame = CGRectMake(0.0f, 0.0f, diameter, diameter);
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    
    UIBezierPath *imgPath = [UIBezierPath bezierPathWithOvalInRect:frame];
    [imgPath addClip];
    
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillEllipseInRect(context, frame);
    
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGRect frame2 = CGRectInset(frame, 1, 1);
    CGContextFillEllipseInRect(context, frame2);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return newImage;
}



+ (UIImage *)circularImageWithColor:(UIColor *)color waiColor:(UIColor *)waiColor withDiamter:(NSUInteger)diameter
{
    NSParameterAssert(color != nil);
    NSParameterAssert(diameter > 0);
    CGRect frame = CGRectMake(0.0f, 0.0f, diameter, diameter);
    
    UIScreen *screen = [UIScreen mainScreen];
    CGFloat scale = screen.scale;
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    
    UIBezierPath *imgPath = [UIBezierPath bezierPathWithOvalInRect:frame];
    [imgPath addClip];
    
    if (waiColor) {
        
        CGContextSaveGState(context);
        
        CGFloat lineWidth = 4;
        
        CGContextSetLineWidth(context, lineWidth);
        
        UIBezierPath *outlinePath = [UIBezierPath bezierPathWithOvalInRect:frame];
        CGContextSetStrokeColorWithColor(context, waiColor.CGColor);
        CGContextAddPath(context, outlinePath.CGPath);
        CGContextStrokePath(context);
        CGContextRestoreGState(context);
        
        CGRect frame3 = CGRectInset(frame,3, 3);
        //CGContextClearRect(context, frame3);
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillEllipseInRect(context, frame3);
        //CGContextFillPath(context);
    }
    else {
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGRect frame2 = CGRectInset(frame, 2, 2);
        CGContextFillEllipseInRect(context, frame2);
    }
    
 
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return newImage;
}


- (UIImage *)pbResizedImageWithWidth:(CGFloat)newWidth andTiledAreaFrom:(CGFloat)from1 to:(CGFloat)to1 andFrom:(CGFloat)from2 to:(CGFloat)to2  {
    NSAssert(self.size.width < newWidth, @"Cannot scale NewWidth %f > self.size.width %f", newWidth, self.size.width);
    
    CGFloat originalWidth = self.size.width;
    CGFloat tiledAreaWidth = (newWidth - originalWidth)/2;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(originalWidth + tiledAreaWidth, self.size.height), NO, self.scale);
    
    UIImage *firstResizable = [self resizableImageWithCapInsets:UIEdgeInsetsMake(0, from1, 0, originalWidth - to1) resizingMode:UIImageResizingModeTile];
    [firstResizable drawInRect:CGRectMake(0, 0, originalWidth + tiledAreaWidth, self.size.height)];
    
    UIImage *leftPart = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWidth, self.size.height), NO, self.scale);
    
    UIImage *secondResizable = [leftPart resizableImageWithCapInsets:UIEdgeInsetsMake(0, from2 + tiledAreaWidth, 0, originalWidth - to2) resizingMode:UIImageResizingModeTile];
    [secondResizable drawInRect:CGRectMake(0, 0, newWidth, self.size.height)];
    
    UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return fullImage;
}


+ (UIImage *)fdd_imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
    
    UIScreen *screen = [UIScreen mainScreen];
    CGFloat scale = screen.scale;
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(.0, .0, size.width, size.height));
    //CGContextFillEllipseInRect(context, frame);
    
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return newImage;
}

+(UIImage *)fdd_paopaoWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIScreen *screen = [UIScreen mainScreen];
    CGFloat scale = screen.scale;
    
    CGRect frame2 = CGRectInset(frame, -3, -3);
    UIGraphicsBeginImageContextWithOptions(frame2.size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: frame cornerRadius: 4];
    [color setFill];
    [rectanglePath fill];
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    CGFloat midx = CGRectGetMidX(frame);
    [bezierPath moveToPoint: CGPointMake(midx - 4, CGRectGetMaxY(frame))];
    [bezierPath addLineToPoint: CGPointMake(midx , CGRectGetMaxY(frame) + 6)];
    [bezierPath addLineToPoint: CGPointMake(midx + 4, CGRectGetMaxY(frame))];
    //[bezierPath moveToPoint: CGPointMake(CGRectGetMidX(frame) - 4, CGRectGetMaxY(frame))];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return newImage;
}

+(void)drawLinearGradient:(CGContextRef)context colorBottom:(UIColor *)colorBottom topColor:(UIColor *)topColor frame:(CGRect)frame{
    //使用rgb颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    
    //创建起点颜色
    CGColorRef
    beginColor = colorBottom.CGColor;
    
    //创建终点颜色
    CGColorRef
    endColor = topColor.CGColor;
    
    //创建颜色数组
    CFArrayRef
    colorArray = CFArrayCreate(kCFAllocatorDefault, (const void*[]){beginColor,
        endColor}, 2, nil);
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colorArray, NULL);
    
    
    /*绘制线性渐变
     context:图形上下文
     gradient:渐变色
     startPoint:起始位置
     endPoint:终止位置
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，到结束点之后继续填充
     */
    CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(frame.size.width, frame.size.height), kCGGradientDrawsAfterEndLocation);
    CFRelease(gradient);
    //释放颜色空间
    CFRelease(colorArray);
    CGColorSpaceRelease(colorSpace);
}

+ (UIImage *)circularWithDiamter:(NSUInteger)diameter colorBottom:(UIColor *)colorBottom topColor:(UIColor *)topColor
{
    NSParameterAssert(diameter > 0);
    CGRect frame = CGRectMake(0.0f, 0.0f, diameter, diameter);
    UIScreen *screen = [UIScreen mainScreen];
    CGFloat scale = screen.scale;
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    UIBezierPath *imgPath = [UIBezierPath bezierPathWithOvalInRect:frame];
    [imgPath addClip];
    [self drawLinearGradient:context colorBottom:colorBottom topColor:topColor frame:frame];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return newImage;
}

@end

//
//  NSString+FDDExtention.m
//  SecondHouseBroker
//
//  Created by Yohunl on 14-8-18.
//  Copyright (c) 2014年 Lin Dongpeng. All rights reserved.
//

#import "NSString+FDDExtention.h"

@implementation NSString (FDDExtention)


- (CGSize)fdd_sizeWithFont:(UIFont *)font
{
    CGSize size;
    if ([self respondsToSelector:@selector(sizeWithAttributes:)]) {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(sizeWithAttributes:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(sizeWithAttributes:)];
        NSDictionary *attributes = @{ NSFontAttributeName:font };
        [invocation setArgument:&attributes atIndex:2];
        [invocation invoke];
        [invocation getReturnValue:&size];
    } else {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(sizeWithFont:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(sizeWithFont:)];
        [invocation setArgument:&font atIndex:2];
        [invocation invoke];
        [invocation getReturnValue:&size];
    }
    return size;
}

- (CGSize)fdd_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize resultSize;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(boundingRectWithSize:options:attributes:context:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(boundingRectWithSize:options:attributes:context:)];
        NSDictionary *attributes = @{ NSFontAttributeName:font };
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
        NSStringDrawingContext *context;
        [invocation setArgument:&size atIndex:2];
        [invocation setArgument:&options atIndex:3];
        [invocation setArgument:&attributes atIndex:4];
        [invocation setArgument:&context atIndex:5];
        [invocation invoke];
        CGRect rect;
        [invocation getReturnValue:&rect];
        resultSize = rect.size;
    } else {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(sizeWithFont:constrainedToSize:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(sizeWithFont:constrainedToSize:)];
        [invocation setArgument:&font atIndex:2];
        [invocation setArgument:&size atIndex:3];
        [invocation invoke];
        [invocation getReturnValue:&resultSize];
    }
    
    return resultSize;
}

//字符串计算高度
+ (CGSize)calculateContentSize:(CGSize)size  content:(NSString *)content fontSize:(UIFont *)fontsize{
    CGSize  result;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary  *attritutes = [NSDictionary dictionaryWithObjectsAndKeys:fontsize,NSFontAttributeName, nil];
        result = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attritutes context:nil].size;
    }
    return  result;
}


- (NSString *)re_stringWithNumberFormat:(NSString *)format
{
    if (self.length == 0 || format.length == 0)
        return self;
    
    format = [format stringByAppendingString:@"X"];
    NSString *string = [self stringByAppendingString:@"0"];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\D" options:NSRegularExpressionCaseInsensitive error:NULL];
    NSString *stripped = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, string.length) withTemplate:@""];
    
    NSMutableArray *patterns = [[NSMutableArray alloc] init];
    NSMutableArray *separators = [[NSMutableArray alloc] init];
    [patterns addObject:@0];
    
    NSInteger maxLength = 0;
    for (NSInteger i = 0; i < [format length]; i++) {
        NSString *character = [format substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"X"]) {
            maxLength++;
            NSNumber *number = [patterns objectAtIndex:patterns.count - 1];
            number = @(number.integerValue + 1);
            [patterns replaceObjectAtIndex:patterns.count - 1 withObject:number];
        } else {
            [patterns addObject:@0];
            [separators addObject:character];
        }
    }
    
    if (stripped.length > maxLength)
        stripped = [stripped substringToIndex:maxLength];
    
    NSString *match = @"";
    NSString *replace = @"";
    
    NSMutableArray *expressions = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < patterns.count; i++) {
        NSString *currentMatch = [match stringByAppendingString:@"(\\d+)"];
        match = [match stringByAppendingString:[NSString stringWithFormat:@"(\\d{%ld})", (long)((NSNumber *)[patterns objectAtIndex:i]).integerValue]];
        
        NSString *templateStr;
        if (i == 0) {
            templateStr = [NSString stringWithFormat:@"$%li", (long)i+1];
        } else {
            unichar separatorCharacter = [[separators objectAtIndex:i-1] characterAtIndex:0];
            templateStr = [NSString stringWithFormat:@"\\%C$%li", separatorCharacter, (long)i+1];
            
        }
        replace = [replace stringByAppendingString:templateStr];
        [expressions addObject:@{@"match": currentMatch, @"replace": replace}];
    }
    
    NSString *result = [stripped copy];
    
    for (NSDictionary *exp in expressions) {
        NSString *match = [exp objectForKey:@"match"];
        NSString *replace = [exp objectForKey:@"replace"];
        NSString *modifiedString = [stripped stringByReplacingOccurrencesOfString:match
                                                                       withString:replace
                                                                          options:NSRegularExpressionSearch
                                                                            range:NSMakeRange(0, stripped.length)];
        
        if (![modifiedString isEqualToString:stripped])
            result = modifiedString;
    }
    return [result substringWithRange:NSMakeRange(0, result.length - 1)];
}

-(CGSize)integralSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)maxSize
{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGRect rect = CGRectIntegral([self boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil]);
    return rect.size;
}

-(CGSize)integralSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth numberOfLines:(NSInteger)lines
{
    if (lines == 0) {
        lines = 1;
    }
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGFloat height = font.lineHeight * lines;
    CGSize maxsize = CGSizeMake(maxWidth, height);
    CGRect rect = CGRectIntegral([self boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:attributes context:nil]);
    return rect.size;
}

-(CGSize)integralSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth lineBreakMode:(NSLineBreakMode)lineBreakMode {
    //sizeWithFont:forWidth:lineBreakMode:' is deprecated: first deprecated in iOS 7.0 - Use -boundingRectWithSize:options:attributes:context:
    //针对带有lineBreakMode参数的过期方法,可以使用如下
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = lineBreakMode;
    NSDictionary *fontAtts = @{NSFontAttributeName : font, NSParagraphStyleAttributeName : paragraphStyle};
    CGSize maxsize = CGSizeMake(maxWidth, CGFLOAT_MAX);
    CGRect rect = CGRectIntegral([self boundingRectWithSize:maxsize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:fontAtts context:nil]);
    return rect.size;
}


@end

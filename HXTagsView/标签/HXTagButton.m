//
//  HXTagButton.m
//  HXTagsView
//
//  Created by 黄轩 on 16/4/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "HXTagButton.h"

@implementation HXTagButton {
    UIButton *tagButton;
    UILabel *label;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame] ) {
        [self instancetypeView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super initWithCoder:aDecoder]) {
        [self instancetypeView];
    }
    return self;
}

- (void)instancetypeView {
    tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tagButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    tagButton.backgroundColor = [UIColor clearColor];
    tagButton.titleLabel.hidden = YES;
    tagButton.adjustsImageWhenHighlighted = NO;
    [tagButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tagButton.frame.size.width, tagButton.frame.size.height)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [tagButton addSubview:label];
    [self addSubview:tagButton];
}

- (void)setTagKey:(NSString *)tagKey {
    _tagKey = tagKey;
}

- (void)setKeyColor:(UIColor *)keyColor {
    _keyColor = keyColor;
}

- (void)setBorderWidth:(float)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = _borderWidth > 0 ? _borderWidth : 1.0f;
}

- (void)setBorderNormalColor:(UIColor *)borderNormalColor {
    _borderNormalColor = borderNormalColor;
    self.layer.borderColor = _borderNormalColor.CGColor;
}

- (void)setBorderSelectedColor:(UIColor *)borderSelectedColor {
    _borderSelectedColor = borderSelectedColor;
}

- (void)setMasksToBounds:(BOOL)masksToBounds {
    self.layer.masksToBounds = masksToBounds;
}

- (void)setCornerRadius:(float)cornerRadius {
    _cornerRadius = cornerRadius;
    
    if (_cornerRadius > 0) {
        [self setMasksToBounds:YES];
        self.layer.cornerRadius = _cornerRadius;
    } else {
        [self setMasksToBounds:NO];
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    if (_title.length == 0) {
        return;
    }
    [tagButton setTitle:title forState:UIControlStateNormal];
}

- (void)setTitleSize:(float)titleSize {
    _titleSize = titleSize;
    label.font = [UIFont systemFontOfSize:_titleSize];
}

- (void)setTitleNormalColor:(UIColor *)titleNormalColor {
    _titleNormalColor = titleNormalColor;
    [tagButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
}

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor {
    _titleSelectedColor = titleSelectedColor;
    [tagButton setTitleColor:[UIColor clearColor] forState:UIControlStateSelected];
    label.textColor = _titleNormalColor;
}

- (void)setNormalBackgroundColor:(UIColor *)normalBackgroundColor {
    _normalBackgroundColor = normalBackgroundColor;
    [tagButton setBackgroundImage:[self imageWithColor:[UIColor clearColor] size:tagButton.frame.size] forState:UIControlStateNormal];
    self.backgroundColor = _normalBackgroundColor;
}

- (void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor {
    _selectedBackgroundColor = selectedBackgroundColor;
    [tagButton setBackgroundImage:[self imageWithColor:[UIColor clearColor] size:tagButton.frame.size] forState:UIControlStateSelected];
}

- (void)buttonAction:(UIButton *)sender {
    if (_buttonAction) {
        _buttonAction(self.tag);
    }
    
    if (_tagKey.length > 0) {
        label.attributedText = [self searchTitle:_title key:_tagKey keyColor:_keyColor size:_titleSize];
    } else {
        label.text = _title;
    }
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    
    if (selected) {
        self.layer.borderColor = _borderSelectedColor.CGColor;
        label.textColor = _titleSelectedColor;
        self.backgroundColor = _selectedBackgroundColor;
    } else {
        self.layer.borderColor = _borderNormalColor.CGColor;
        label.textColor = _titleNormalColor;
        self.backgroundColor = _normalBackgroundColor;
    }
}

- (void)setIsMultiSelect:(BOOL)isMultiSelect {
    _isMultiSelect = isMultiSelect;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_tagKey.length > 0) {
        label.attributedText = [self searchTitle:_title key:_tagKey keyColor:_keyColor size:_titleSize];
    } else {
        label.text = _title;
    }
}

/**
 *  设置文字中关键字高亮
 *
 *  @param title    <#title description#>
 *  @param key      <#key description#>
 *  @param keyColor <#keyColor description#>
 *  @param size     <#size description#>
 *
 *  @return <#return value description#>
 */
- (NSMutableAttributedString *)searchTitle:(NSString *)title key:(NSString *)key keyColor:(UIColor *)keyColor size:(float)size {
    if (size > 0) {
        
    } else {
        size = 16;
    }
    
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:title];
    NSString *copyStr = title;
    
    NSMutableString *xxstr = [NSMutableString new];
    for (int i = 0; i < key.length; i++) {
        [xxstr appendString:@"*"];
    }
    
    while ([copyStr rangeOfString:key].location != NSNotFound) {
        
        NSRange range = [copyStr rangeOfString:key];
        if (!keyColor) {
            keyColor = [UIColor redColor];
        }
        [str1 addAttribute:NSForegroundColorAttributeName value:keyColor range:range];
        [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:range];
        
        copyStr = [copyStr stringByReplacingCharactersInRange:NSMakeRange(range.location, range.length) withString:xxstr];
    }
    return str1;
}

//颜色生成图片方法
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,
                                   
                                   color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end

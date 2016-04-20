//
//  HXTagView.m
//  HXTagsView
//
//  Created by 黄轩 on 16/4/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "HXTagView.h"

@interface HXTagView ()

@property (nonatomic,strong) UILabel *tagLabel;
@property (nonatomic,strong) UITapGestureRecognizer *tap;

@end

@implementation HXTagView

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
    _tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _tagLabel.backgroundColor = [UIColor clearColor];
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    _tagLabel.userInteractionEnabled = YES;
    [self addSubview:_tagLabel];
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap:)];
    [_tagLabel addGestureRecognizer:_tap];
}

- (void)setBorderWidth:(float)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = _borderWidth > 0 ? _borderWidth : 1.0f;
}

- (void)setBorderNormalColor:(UIColor *)borderNormalColor {
    _borderNormalColor = borderNormalColor;
    self.layer.borderColor = _borderNormalColor.CGColor;
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

- (void)setTitleSize:(float)titleSize {
    _titleSize = titleSize;
    _tagLabel.font = [UIFont systemFontOfSize:_titleSize];
}

- (void)setTitleNormalColor:(UIColor *)titleNormalColor {
    _titleNormalColor = titleNormalColor;
    _tagLabel.textColor = _titleNormalColor;
}

- (void)setNormalBackgroundColor:(UIColor *)normalBackgroundColor {
    _normalBackgroundColor = normalBackgroundColor;
    self.backgroundColor = _normalBackgroundColor;
}

- (void)handTap:(UITapGestureRecognizer *)tap {
    if (_buttonAction) {
        _buttonAction(self.tag);
    }
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (selected) {
        self.layer.borderColor = _borderSelectedColor.CGColor;
        if (_tagKey.length > 0) {
            _tagLabel.attributedText = [self searchTitle:_title key:_tagKey keyColor:_keyColor size:_titleSize];
        } else {
            _tagLabel.textColor = _titleSelectedColor;
        }
        self.backgroundColor = _selectedBackgroundColor;
    } else {
        self.layer.borderColor = _borderNormalColor.CGColor;
        if (_tagKey.length > 0) {
            _tagLabel.attributedText = [self searchTitle:_title key:_tagKey keyColor:_keyColor size:_titleSize];
        } else {
            _tagLabel.textColor = _titleNormalColor;
        }
        self.backgroundColor = _normalBackgroundColor;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_tagKey.length > 0) {
        _tagLabel.attributedText = [self searchTitle:_title key:_tagKey keyColor:_keyColor size:_titleSize];
    } else {
        _tagLabel.text = _title;
    }
}

// 设置文字中关键字高亮
- (NSMutableAttributedString *)searchTitle:(NSString *)title key:(NSString *)key keyColor:(UIColor *)keyColor size:(float)size {
    
    NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:title];
    NSString *copyStr = title;
    
    NSMutableString *xxstr = [NSMutableString new];
    for (int i = 0; i < key.length; i++) {
        [xxstr appendString:@"*"];
    }
    
    while ([copyStr rangeOfString:key].location != NSNotFound) {
        
        NSRange range = [copyStr rangeOfString:key];

        [titleStr addAttribute:NSForegroundColorAttributeName value:keyColor range:range];
        [titleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:range];
        
        copyStr = [copyStr stringByReplacingCharactersInRange:NSMakeRange(range.location, range.length) withString:xxstr];
    }
    return titleStr;
}

@end

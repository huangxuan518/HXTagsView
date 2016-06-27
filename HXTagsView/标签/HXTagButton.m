//
//  HXTagButton.m
//  HXTagsView
//
//  Created by 黄轩 on 16/4/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "HXTagButton.h"

@interface HXTagButton ()

@property (nonatomic,strong) UILabel *tagLabel;
@property (nonatomic,strong) UITapGestureRecognizer *tap;

@end

@implementation HXTagButton

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

- (void)handTap:(UITapGestureRecognizer *)tap {
    if (_buttonAction) {
        _buttonAction(self);
    }
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (selected) {
        self.layer.borderColor = _tagAttribute.borderSelectedColor.CGColor;
        _tagLabel.textColor = _tagAttribute.titleSelectedColor;
        if (_tagKey.length > 0) {
            _tagLabel.attributedText = [self searchTitle:_title key:_tagKey keyColor:_tagAttribute.keyColor size:_tagAttribute.titleSize];
        }
        self.backgroundColor = _tagAttribute.selectedBackgroundColor;
    } else {
        self.layer.borderColor = _tagAttribute.borderNormalColor.CGColor;
        _tagLabel.textColor = _tagAttribute.titleNormalColor;
        if (_tagKey.length > 0) {
            _tagLabel.attributedText = [self searchTitle:_title key:_tagKey keyColor:_tagAttribute.keyColor size:_tagAttribute.titleSize];
        }
        self.backgroundColor = _tagAttribute.normalBackgroundColor;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.borderWidth = _tagAttribute.borderWidth > 0 ? _tagAttribute.borderWidth : 1.0f;
    self.layer.borderColor = _tagAttribute.borderNormalColor.CGColor;
    if (_tagAttribute.cornerRadius > 0) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = _tagAttribute.cornerRadius;
    } else {
        self.layer.masksToBounds = NO;;
    }

    _tagLabel.font = [UIFont systemFontOfSize:_tagAttribute.titleSize];
    _tagLabel.textColor = _tagAttribute.titleNormalColor;
    self.backgroundColor = _tagAttribute.normalBackgroundColor;
    
    if (_tagKey.length > 0) {
        _tagLabel.attributedText = [self searchTitle:_title key:_tagKey keyColor:_tagAttribute.keyColor size:_tagAttribute.titleSize];
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

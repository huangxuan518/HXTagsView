//
//  HXTagsView.m
//  IT小子
//
//  Created by 黄轩 on 16/1/13.
//  Copyright © 2015年 IT小子. All rights reserved.

#import "HXTagsView.h"
#import "NSString+FDDExtention.h"
#import "UIImage+Tint.h"
#import "UIColor+RGBValues.h"
#import "UIView+Helpers.h"

@implementation HXTagsView {
    NSArray *disposeAry;//根据type处理后的数据源
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 设置scrollview的属性
        self.showsHorizontalScrollIndicator = YES;
        self.showsVerticalScrollIndicator = YES;
        self.frame = frame;
        self.backgroundColor = UIColorHexFromRGB(0xF5F5F5);
        if (self.frame.size.height > 0) {
            _maxHeight = self.frame.size.height;
        } else {
            _maxHeight = [[UIScreen mainScreen] bounds].size.height - self.frame.origin.y;
        }
        _tagSpace = 9.0;
        _tagHeight = 32.0;
        _tagOriginX = 10.0;
        _tagOriginY = 10.0;
        _tagHorizontalSpace = 10.0;
        _tagVerticalSpace = 10.0;
        _borderColor = UIColorHexFromRGB(0xD8D8D8);
        _borderWidth = 0.5f;
        _masksToBounds = YES;
        _cornerRadius = 2.0;
        _titleSize = 14;
        _titleColor = UIColorHexFromRGB(0x666666);
        _normalBackgroundImage = [UIImage imageWithColor:UIColorHexFromRGB(0xFFFFFF)];
        _highlightedBackgroundImage = [UIImage imageWithColor:UIColorHexFromRGB(0xEAEAEA)];
    }
    return self;
}

//设置标签数据和代理
- (void)setTagAry:(NSArray *)tagAry delegate:(id)delegate {
    _tagDelegate = delegate;
    [self disposeTags:tagAry];
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //遍历标签数组,将标签显示在界面上,并给每个标签打上tag加以区分
    for (NSArray *iTags in disposeAry) {
        NSUInteger i = [disposeAry indexOfObject:iTags];
        
        for (NSDictionary *tagDic in iTags) {
            NSUInteger j = [iTags indexOfObject:tagDic];
            
            NSString *tagTitle = tagDic[@"tagTitle"];
            float originX = [tagDic[@"originX"] floatValue];
            float buttonWith = [tagDic[@"buttonWith"] floatValue];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(originX, _tagOriginY+i*(_tagHeight+_tagVerticalSpace), buttonWith, _tagHeight);
            button.layer.borderColor = _borderColor.CGColor;
            button.layer.borderWidth = _borderWidth;
            button.layer.masksToBounds = _masksToBounds;
            button.layer.cornerRadius = _cornerRadius;
            button.titleLabel.font = [UIFont systemFontOfSize:_titleSize];
            [button setTitle:tagTitle forState:UIControlStateNormal];
            [button setTitleColor:_titleColor forState:UIControlStateNormal];
            [button setBackgroundImage:_normalBackgroundImage forState:UIControlStateNormal];
            [button setBackgroundImage:_highlightedBackgroundImage forState:UIControlStateHighlighted];
            button.tag = i*iTags.count+j;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
    
    if (disposeAry.count > 0) {
        if (_type == 0) {
            //多行
            float contentSizeHeight = _tagOriginY+disposeAry.count*(_tagHeight+_tagVerticalSpace);
            if (_maxHeight > contentSizeHeight) {
                self.frameSizeHeight = contentSizeHeight;
            } else {
                self.frameSizeHeight = _maxHeight;
            }
            self.contentSize = CGSizeMake(self.frame.size.width,contentSizeHeight);
        } else if (_type == 1) {
            //单行
            NSArray *a = disposeAry[0];
            NSDictionary *tagDic = a[a.count-1];
            float originX = [tagDic[@"originX"] floatValue];
            float buttonWith = [tagDic[@"buttonWith"] floatValue];
            self.contentSize = CGSizeMake(originX+buttonWith+_tagOriginX,self.frame.size.height);
        }
    }
}

//将标签数组根据type以及其他参数进行分组装入数组
- (void)disposeTags:(NSArray *)ary {
    NSMutableArray *tags = [NSMutableArray new];//纵向数组
    NSMutableArray *subTags = [NSMutableArray new];//横向数组
    
    float originX = _tagOriginX;
    for (NSString *tagTitle in ary) {
        NSUInteger index = [ary indexOfObject:tagTitle];
        
        //计算每个tag的宽度
        CGSize contentSize = [tagTitle fdd_sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.frame.size.width-_tagOriginX*2, MAXFLOAT)];
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        dict[@"tagTitle"] = tagTitle;//标签标题
        dict[@"buttonWith"] = [NSString stringWithFormat:@"%f",contentSize.width+_tagSpace];//标签的宽度
        
        if (index == 0) {
            dict[@"originX"] = [NSString stringWithFormat:@"%f",originX];//标签的X坐标
            [subTags addObject:dict];
        } else {
            if (_type == 0) {
                //多行
                if (originX + contentSize.width > self.frame.size.width-_tagOriginX*2) {
                    //当前标签的X坐标+当前标签的长度>屏幕的横向总长度则换行
                    [tags addObject:subTags];
                    //换行标签的起点坐标初始化
                    originX = _tagOriginX;
                    dict[@"originX"] = [NSString stringWithFormat:@"%f",originX];//标签的X坐标
                    subTags = [NSMutableArray new];
                    [subTags addObject:dict];
                } else {
                    //如果没有超过屏幕则继续加在前一个数组里
                    dict[@"originX"] = [NSString stringWithFormat:@"%f",originX];//标签的X坐标
                    [subTags addObject:dict];
                }
            } else {
                //一行
                dict[@"originX"] = [NSString stringWithFormat:@"%f",originX];//标签的X坐标
                [subTags addObject:dict];
            }
        }
        
        if (index +1 == ary.count) {
            //最后一个标签加完将横向数组加到纵向数组中
            [tags addObject:subTags];
            disposeAry = tags;
        }
        
        //标签的X坐标每次都是前一个标签的宽度+标签左右空隙+标签距下个标签的距离
        originX += contentSize.width+_tagHorizontalSpace+_tagSpace;
    }
}

//获取tagsView的高度根据标签的数组
- (float)getTagsViewHeight:(NSArray *)tagAry {
    
    [self disposeTags:tagAry];
    
    float height = 0;
    
    if (disposeAry.count > 0) {
        if (_type == 0) {
            height = _tagOriginY+disposeAry.count*(_tagHeight+_tagVerticalSpace);
        } else if (_type == 1) {
            height = _tagOriginY+_tagHeight+_tagVerticalSpace;
        }
    }
    return height;
}

- (void)buttonAction:(UIButton *)sender {
    if (_tagDelegate && [_tagDelegate respondsToSelector:@selector(tagsViewButtonAction:button:)]) {
        [_tagDelegate tagsViewButtonAction:self button:sender];
    }
}

@end

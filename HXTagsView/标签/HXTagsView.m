//
//  HXTagsView.m
//  IT小子
//
//  Created by 黄轩 on 16/1/13.
//  Copyright © 2015年 IT小子. All rights reserved.

#import "HXTagsView.h"

@implementation HXTagsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = YES;
        self.showsVerticalScrollIndicator = YES;
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        int r = arc4random() % 255;
        int g = arc4random() % 255;
        int b = arc4random() % 255;
        
        _currentIndex = -1;
        
        _tagSpace = HXTagSpace;
        _tagHeight = HXTagHeight;
        _tagOriginX = HXTagOriginX;
        _tagOriginY = HXTagOriginY;
        _tagHorizontalSpace = HXTagHorizontalSpace;
        _tagVerticalSpace = HXTagVerticalSpace;
        
        _borderWidth = 0.5f;
        _masksToBounds = YES;
        _cornerRadius = 2.0;
        _titleSize = 14;
        _titleNormalColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
        _titleSelectedColor = [UIColor colorWithRed:g/255.0 green:b/255.0 blue:r/255.0 alpha:1.0];
        _normalBackgroundImage = [self imageWithColor:[UIColor whiteColor] size:CGSizeMake(1.0, 1.0)];
        _highlightedBackgroundImage = [self imageWithColor:[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0] size:CGSizeMake(1.0, 1.0)];
        _selectedBackgroundImage = [self imageWithColor:[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0] size:CGSizeMake(1.0, 1.0)];
    }
    return self;
}

- (void)setPropertyDic:(NSDictionary *)propertyDic {
    int type = [propertyDic[@"type"] length] > 0 ? [propertyDic[@"type"] intValue] : 0;
    float frameSizeWidth = [propertyDic[@"frameSizeWidth"] length] > 0 ? [propertyDic[@"frameSizeWidth"] floatValue] : [[UIScreen mainScreen] bounds].size.width;
    float tagOriginX = [propertyDic[@"tagOriginX"] length] > 0 ? [propertyDic[@"tagOriginX"] floatValue] : HXTagOriginX;
    float tagOriginY = [propertyDic[@"tagOriginY"] length] > 0 ? [propertyDic[@"tagOriginY"] floatValue] : HXTagOriginY;
    float tagSpace = [propertyDic[@"tagSpace"] length] > 0 ? [propertyDic[@"tagSpace"] floatValue] : HXTagSpace;
    float tagHeight = [propertyDic[@"tagHeight"] length] > 0 ? [propertyDic[@"tagHeight"] floatValue] : HXTagHeight;
    float tagHorizontalSpace = [propertyDic[@"tagHorizontalSpace"] length] > 0 ? [propertyDic[@"tagHorizontalSpace"] floatValue] : HXTagHorizontalSpace;
    float tagVerticalSpace = [propertyDic[@"tagVerticalSpace"] length] > 0 ? [propertyDic[@"tagVerticalSpace"] floatValue] : HXTagVerticalSpace;
    
    _type = type;
    self.frame = CGRectMake(CGRectGetMinX([self frame]), CGRectGetMinY([self frame]), frameSizeWidth, CGRectGetHeight([self frame]));
    _tagOriginX = tagOriginX;
    _tagOriginY = tagOriginY;
    _tagSpace = tagSpace;
    _tagHeight = tagHeight;
    _tagHorizontalSpace = tagHorizontalSpace;
    _tagVerticalSpace = tagVerticalSpace;
}

//设置标签数据和代理
- (void)setTagAry:(NSArray *)tagAry delegate:(id)delegate {
    
    //先移除之前的View
    if (self.subviews.count > 0) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    //代理
    _tagDelegate = delegate;
    
    //将数组根据类型和参数进行处理分组
    NSArray *disposeAry = [self disposeTags:tagAry];
    
    //遍历标签数组,将标签显示在界面上,并给每个标签打上tag加以区分
    for (NSArray *iTags in disposeAry) {
        
        NSUInteger i = [disposeAry indexOfObject:iTags];
        
        for (NSDictionary *tagDic in iTags) {
            
            NSString *tagTitle = tagDic[@"tagTitle"];
            NSUInteger index = [tagDic[@"index"] integerValue];
            float originX = [tagDic[@"originX"] floatValue];
            float buttonWith = [tagDic[@"buttonWith"] floatValue];
            
            CGRect frame = CGRectMake(originX, _tagOriginY+i*(_tagHeight+_tagVerticalSpace), buttonWith, _tagHeight);;
            UIButton *button = [self ittemButtonWithFrame:frame];
            [button setTitle:tagTitle forState:UIControlStateNormal];
            if (index == _currentIndex) {
                button.selected = YES;
            } else {
                button.selected = NO;
            }
            button.tag = index;
            [self addSubview:button];
        }
    }
    
    //设置当前scrollView的contentSize
    if (disposeAry.count > 0) {
        if (_type == 1) {
            //多行
            float contentSizeHeight = _tagOriginY+disposeAry.count*(_tagHeight+_tagVerticalSpace);
            self.contentSize = CGSizeMake(self.frame.size.width,contentSizeHeight);
        } else {
            //单行
            NSArray *a = disposeAry[0];
            NSDictionary *tagDic = a[a.count-1];
            float originX = [tagDic[@"originX"] floatValue];
            float buttonWith = [tagDic[@"buttonWith"] floatValue];
            self.contentSize = CGSizeMake(originX+buttonWith+_tagOriginX,self.frame.size.height);
        }
    }
    
    //设置当前scrollView的高度
    if (self.frame.size.height <= 0) {
        self.frame = CGRectMake(CGRectGetMinX([self frame]), CGRectGetMinY([self frame]), CGRectGetWidth([self frame]), [self getDisposeTagsViewHeight:disposeAry]);
    } else {
        if (_type == 1) {
            if (self.frame.size.height > self.contentSize.height) {
                self.frame = CGRectMake(CGRectGetMinX([self frame]), CGRectGetMinY([self frame]), CGRectGetWidth([self frame]), self.contentSize.height);
            }
        }
    }
}

//根据frame生成对应的标签按钮
- (UIButton *)ittemButtonWithFrame:(CGRect)frame {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.layer.borderColor = _titleNormalColor.CGColor;
    button.layer.borderWidth = _borderWidth;
    button.layer.masksToBounds = _masksToBounds;
    button.layer.cornerRadius = _cornerRadius;
    button.titleLabel.font = [UIFont systemFontOfSize:_titleSize];
    [button setTitleColor:_titleNormalColor forState:UIControlStateNormal];
    [button setTitleColor:_titleSelectedColor forState:UIControlStateSelected];
    [button setBackgroundImage:_normalBackgroundImage forState:UIControlStateNormal];
    [button setBackgroundImage:_highlightedBackgroundImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:_selectedBackgroundImage forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

//将标签数组根据type以及其他参数进行分组装入数组
- (NSArray *)disposeTags:(NSArray *)ary {
    NSMutableArray *disposeTags = [NSMutableArray new];//纵向数组
    NSMutableArray *subTags = [NSMutableArray new];//横向数组
    
    float originX = _tagOriginX;
    float maxFrameWidth = self.frame.size.width-_tagOriginX*2;
    
    for (NSString *tagTitle in ary) {
        NSUInteger index = [ary indexOfObject:tagTitle];
        
        //计算每个tag的宽度
        CGSize contentSize = [tagTitle fdd_sizeWithFont:[UIFont systemFontOfSize:_titleSize] constrainedToSize:CGSizeMake(maxFrameWidth, MAXFLOAT)];
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        dict[@"tagTitle"] = tagTitle;//标签标题
        dict[@"index"] = @(index);//标签index
        if (contentSize.width+_tagSpace > maxFrameWidth) {
            dict[@"buttonWith"] = [NSString stringWithFormat:@"%f",maxFrameWidth];//标签的宽度
        } else {
            dict[@"buttonWith"] = [NSString stringWithFormat:@"%f",contentSize.width+_tagSpace];//标签的宽度
        }
        
        if (index == 0) {
            dict[@"originX"] = [NSString stringWithFormat:@"%f",originX];//标签的X坐标
            [subTags addObject:dict];
        } else {
            if (_type == 1) {
                //多行
                if (originX + contentSize.width+_tagSpace > maxFrameWidth) {
                    //当前标签的X坐标+当前标签的长度>屏幕的横向总长度则换行
                    [disposeTags addObject:subTags];
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
            [disposeTags addObject:subTags];
            return disposeTags;
        }
        
        //标签的X坐标每次都是前一个标签的宽度+标签左右空隙+标签距下个标签的距离
        originX += contentSize.width+_tagHorizontalSpace+_tagSpace;
    }
    return disposeTags;
}

//获取处理后的tagsView的高度根据标签的数组
- (float)getDisposeTagsViewHeight:(NSArray *)disposeTags {
    float height = 0;
    if (disposeTags.count > 0) {
        if (_type == 1) {
            height = _tagOriginY+disposeTags.count*(_tagHeight+_tagVerticalSpace);
        } else {
            height = _tagOriginY+_tagHeight+_tagVerticalSpace;
        }
    }
    return height;
}

- (void)buttonAction:(UIButton *)sender {
    if (_tagDelegate && [_tagDelegate respondsToSelector:@selector(tagsViewButtonAction:button:)]) {
        [_tagDelegate tagsViewButtonAction:self button:sender];
    }
    
    if (sender.tag != _currentIndex) {
        //只有点击的按钮不是之前点击的才执行以下方法,寻找点击的按钮
        for (UIButton *button in self.subviews) {
            if ([button isKindOfClass:[UIButton class]]) {
                if (button.tag == sender.tag) {
                    button.selected = YES;
                } else {
                    button.selected = NO;
                }
                
                if (button.selected) {
                    button.layer.borderColor = _titleSelectedColor.CGColor;
                } else {
                    button.layer.borderColor = _titleNormalColor.CGColor;
                }
            }
        }
    }
}

//当把标签View放到cell中时,需要先计算出cell的高度,所以如果自己定制,则需要传入所有影响计算结果的参数
+ (float)getTagsViewHeight:(NSArray *)ary dic:(NSDictionary *)dic {
    int type = [dic[@"type"] length] > 0 ? [dic[@"type"] intValue] : 0;
    float frameSizeWidth = [dic[@"frameSizeWidth"] length] > 0 ? [dic[@"frameSizeWidth"] floatValue] : [[UIScreen mainScreen] bounds].size.width;
    float tagOriginX = [dic[@"tagOriginX"] length] > 0 ? [dic[@"tagOriginX"] floatValue] : HXTagOriginX;
    float tagOriginY = [dic[@"tagOriginY"] length] > 0 ? [dic[@"tagOriginY"] floatValue] : HXTagOriginY;
    float tagSpace = [dic[@"tagSpace"] length] > 0 ? [dic[@"tagSpace"] floatValue] : HXTagSpace;
    float tagHeight = [dic[@"tagHeight"] length] > 0 ? [dic[@"tagHeight"] floatValue] : HXTagHeight;
    float tagHorizontalSpace = [dic[@"tagHorizontalSpace"] length] > 0 ? [dic[@"tagHorizontalSpace"] floatValue] : HXTagHorizontalSpace;
    float tagVerticalSpace = [dic[@"tagVerticalSpace"] length] > 0 ? [dic[@"tagVerticalSpace"] floatValue] : HXTagVerticalSpace;

    NSMutableArray *tags = [NSMutableArray new];//纵向数组
    NSMutableArray *subTags = [NSMutableArray new];//横向数组
    
    float originX = tagOriginX;
    float maxFrameWidth = frameSizeWidth-tagOriginX*2;
    
    for (NSString *tagTitle in ary) {
        NSUInteger index = [ary indexOfObject:tagTitle];
        
        //计算每个tag的宽度
        CGSize contentSize = [tagTitle fdd_sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(maxFrameWidth, MAXFLOAT)];
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        dict[@"tagTitle"] = tagTitle;//标签标题
        
        if (contentSize.width+tagSpace > maxFrameWidth) {
            dict[@"buttonWith"] = [NSString stringWithFormat:@"%f",maxFrameWidth];//标签的宽度
        } else {
            dict[@"buttonWith"] = [NSString stringWithFormat:@"%f",contentSize.width+tagSpace];//标签的宽度
        }
        
        if (index == 0) {
            dict[@"originX"] = [NSString stringWithFormat:@"%f",originX];//标签的X坐标
            [subTags addObject:dict];
        } else {
            if (type == 1) {
                //多行
                if (originX + contentSize.width+tagSpace > maxFrameWidth) {
                    //当前标签的X坐标+当前标签的长度>屏幕的横向总长度则换行
                    [tags addObject:subTags];
                    //换行标签的起点坐标初始化
                    originX = tagOriginX;
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
        }
        
        //标签的X坐标每次都是前一个标签的宽度+标签左右空隙+标签距下个标签的距离
        originX += contentSize.width+tagHorizontalSpace+tagSpace;
    }
    
    float height = 0;
    if (tags.count > 0) {
        if (type == 1) {
            height = tagOriginY+tags.count*(tagHeight+tagVerticalSpace);
        } else {
            height = tagOriginY+tagHeight+tagVerticalSpace;
        }
    }
    return height;
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

#pragma mark - 扩展方法

@implementation NSString (HXExtention)

- (CGSize)fdd_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
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

@end

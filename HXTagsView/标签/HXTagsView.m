//
//  HXTagsView.m
//  IT小子
//
//  Created by 黄轩 on 16/1/13.
//  Copyright © 2015年 IT小子. All rights reserved.

#import "HXTagsView.h"
#import "HXTagButton.h"

#define HXTagSpace 18.0
#define HXTagHeight 32.0
#define HXTagOriginX 10.0
#define HXTagOriginY 10.0
#define HXTagHorizontalSpace 10.0
#define HXTagVerticalSpace 10.0

@interface HXTagsView ()

@property (nonatomic,strong) NSMutableArray *tags;//多选 选中的标签数组
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,assign) BOOL isFirst;//第一加载

@end

@implementation HXTagsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = YES;
        self.showsVerticalScrollIndicator = YES;
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];

        _tagAttribute = [HXTagAttribute new];
        
        _currentIndex = -1;
        
        _tagLayout = [HXTagLayout new];
        
        _tagLayout.tagSpace = HXTagSpace;
        _tagLayout.tagHeight = HXTagHeight;
        _tagLayout.tagOriginX = HXTagOriginX;
        _tagLayout.tagOriginY = HXTagOriginY;
        _tagLayout.tagHorizontalSpace = HXTagHorizontalSpace;
        _tagLayout.tagVerticalSpace = HXTagVerticalSpace;
    
        _isFirst = YES;
    }
    return self;
}

//将标签数组根据type以及其他参数进行分组装入数组
- (NSArray *)disposeTags:(NSArray *)ary {
    NSMutableArray *disposeTags = [NSMutableArray new];//纵向数组
    NSMutableArray *subTags = [NSMutableArray new];//横向数组
    
    float originX = _tagLayout.tagOriginX;
    float maxFrameWidth = self.frame.size.width-_tagLayout.tagOriginX*2;
    
    for (int i = 0; i < ary.count; i++) {
        NSString *tagTitle = ary[i];
        NSUInteger index = i;
        
        //计算每个tag的宽度
        CGSize contentSize = [tagTitle ex_sizeWithFont:[UIFont systemFontOfSize:_tagAttribute.titleSize] constrainedToSize:CGSizeMake(maxFrameWidth, MAXFLOAT)];
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        dict[@"tagTitle"] = tagTitle;//标签标题
        dict[@"index"] = @(index);//标签index
        if (contentSize.width+_tagLayout.tagSpace > maxFrameWidth) {
            dict[@"buttonWith"] = [NSString stringWithFormat:@"%f",maxFrameWidth];//标签的宽度
        } else {
            dict[@"buttonWith"] = [NSString stringWithFormat:@"%f",contentSize.width+_tagLayout.tagSpace];//标签的宽度
        }
        
        if (index == 0) {
            dict[@"originX"] = [NSString stringWithFormat:@"%f",originX];//标签的X坐标
            [subTags addObject:dict];
        } else {
            if (_tagLayout.type == 1) {
                //多行
                if (originX + contentSize.width+_tagLayout.tagSpace > maxFrameWidth) {
                    //当前标签的X坐标+当前标签的长度>屏幕的横向总长度则换行
                    [disposeTags addObject:subTags];
                    //换行标签的起点坐标初始化
                    originX = _tagLayout.tagOriginX;
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
        originX += contentSize.width+_tagLayout.tagHorizontalSpace+_tagLayout.tagSpace;
    }
    return disposeTags;
}

//获取处理后的tagsView的高度根据标签的数组
- (float)getDisposeTagsViewHeight:(NSArray *)disposeTags {
    float height = 0;
    if (disposeTags.count > 0) {
        if (_tagLayout.type == 1) {
            height = _tagLayout.tagOriginY+disposeTags.count*(_tagLayout.tagHeight+_tagLayout.tagVerticalSpace);
        } else {
            height = _tagLayout.tagOriginY+_tagLayout.tagHeight+_tagLayout.tagVerticalSpace;
        }
    }
    return height;
}

- (void)buttonAction:(HXTagButton *)tagButton {

    if (_isMultiSelect) {
        if (!_tags) {
            _tags = [NSMutableArray new];
        }
        [_tags removeAllObjects];
        
        
        tagButton.selected = !tagButton.selected;
        
        for (HXTagButton *view in self.subviews) {
            if ([view isKindOfClass:[HXTagButton class]]) {
                if (view.selected == YES) {
                    [_tags addObject:view.title];
                }
            }
        }
        
        if (_tagDelegate && [_tagDelegate respondsToSelector:@selector(tagsViewButtonAction:tags:)]) {
            [_tagDelegate tagsViewButtonAction:self tags:_tags];
        }
        
    } else {
        //单选
        //只有点击的按钮不是之前点击的才执行以下方法,寻找点击的按钮
        for (HXTagButton *view in self.subviews) {
            if ([view isKindOfClass:[HXTagButton class]]) {
                if (view.tag == tagButton.tag) {
                    view.selected = YES;
                } else {
                    view.selected = NO;
                }
            }
        }

        if (_tagDelegate && [_tagDelegate respondsToSelector:@selector(tagsViewButtonAction:selectIndex:tagTitle:)]) {
            [_tagDelegate tagsViewButtonAction:self selectIndex:tagButton.tag tagTitle:tagButton.title];
        }
    }
}

- (void)reloadData {
    //先移除之前的View
    if (self.subviews.count > 0) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    //将数组根据类型和参数进行处理分组
    NSArray *disposeAry = [self disposeTags:_tagAry];
    
    //遍历标签数组,将标签显示在界面上,并给每个标签打上tag加以区分
    for (int i = 0; i < disposeAry.count; i++) {
        NSArray *iTags = disposeAry[i];
        for (int j = 0; j < iTags.count; j++) {
            NSDictionary *tagDic = iTags[j];
            NSString *tagTitle = tagDic[@"tagTitle"];
            NSUInteger index = [tagDic[@"index"] integerValue];
            float originX = [tagDic[@"originX"] floatValue];
            float buttonWith = [tagDic[@"buttonWith"] floatValue];
            
            HXTagButton *tagButton = [[HXTagButton alloc] initWithFrame:CGRectMake(originX, _tagLayout.tagOriginY+i*(_tagLayout.tagHeight+_tagLayout.tagVerticalSpace), buttonWith, _tagLayout.tagHeight)];
            tagButton.title = tagTitle;
            tagButton.tagKey = _key;
            tagButton.tagAttribute = _tagAttribute;
            tagButton.tag = index;
            tagButton.buttonAction = ^(HXTagButton *tagButton) {
                [self buttonAction:tagButton];
            };
            [self addSubview:tagButton];
        }
    }
    
    //设置当前scrollView的contentSize
    if (disposeAry.count > 0) {
        if (_tagLayout.type == 1) {
            //多行
            float contentSizeHeight = _tagLayout.tagOriginY+disposeAry.count*(_tagLayout.tagHeight+_tagLayout.tagVerticalSpace);
            self.contentSize = CGSizeMake(self.frame.size.width,contentSizeHeight);
        } else {
            //单行
            NSArray *a = disposeAry[0];
            NSDictionary *tagDic = a[a.count-1];
            float originX = [tagDic[@"originX"] floatValue];
            float buttonWith = [tagDic[@"buttonWith"] floatValue];
            self.contentSize = CGSizeMake(originX+buttonWith+_tagLayout.tagOriginX,self.frame.size.height);
        }
    }
    
    //设置当前scrollView的高度
    if (self.frame.size.height <= 0) {
        self.frame = CGRectMake(CGRectGetMinX([self frame]), CGRectGetMinY([self frame]), CGRectGetWidth([self frame]), [self getDisposeTagsViewHeight:disposeAry]);
    } else {
        if (_tagLayout.type == 1) {
            if (self.frame.size.height > self.contentSize.height) {
                self.frame = CGRectMake(CGRectGetMinX([self frame]), CGRectGetMinY([self frame]), CGRectGetWidth([self frame]), self.contentSize.height);
            }
        }
    }
}

//当把标签View放到cell中时,需要先计算出cell的高度,所以如果自己定制,则需要传入所有影响计算结果的参数
+ (float)getTagsViewHeightWithTags:(NSArray *)ary tagLayout:(HXTagLayout *)tagLayout width:(float)width {
    if (!tagLayout) {
        tagLayout = [HXTagLayout new];
    }

    float frameSizeWidth = width > 0 ? width : [[UIScreen mainScreen] bounds].size.width;

    NSMutableArray *tags = [NSMutableArray new];//纵向数组
    NSMutableArray *subTags = [NSMutableArray new];//横向数组
    
    float originX = tagLayout.tagOriginX;
    float maxFrameWidth = frameSizeWidth-tagLayout.tagOriginX*2;
    
    for (int i = 0; i < ary.count; i++) {
        NSString *tagTitle = ary[i];
        NSUInteger index = i;
        
        //计算每个tag的宽度
        CGSize contentSize = [tagTitle ex_sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(maxFrameWidth, MAXFLOAT)];
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        dict[@"tagTitle"] = tagTitle;//标签标题
        
        if (contentSize.width+tagLayout.tagSpace > maxFrameWidth) {
            dict[@"buttonWith"] = [NSString stringWithFormat:@"%f",maxFrameWidth];//标签的宽度
        } else {
            dict[@"buttonWith"] = [NSString stringWithFormat:@"%f",contentSize.width+tagLayout.tagSpace];//标签的宽度
        }
        
        if (index == 0) {
            dict[@"originX"] = [NSString stringWithFormat:@"%f",originX];//标签的X坐标
            [subTags addObject:dict];
        } else {
            if (tagLayout.type == 1) {
                //多行
                if (originX + contentSize.width+tagLayout.tagSpace > maxFrameWidth) {
                    //当前标签的X坐标+当前标签的长度>屏幕的横向总长度则换行
                    [tags addObject:subTags];
                    //换行标签的起点坐标初始化
                    originX = tagLayout.tagOriginX;
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
        originX += contentSize.width+tagLayout.tagHorizontalSpace+tagLayout.tagSpace;
    }
    
    float height = 0;
    if (tags.count > 0) {
        if (tagLayout.type == 1) {
            height = tagLayout.tagOriginY+tags.count*(tagLayout.tagHeight+tagLayout.tagVerticalSpace);
        } else {
            height = tagLayout.tagOriginY+tagLayout.tagHeight+tagLayout.tagVerticalSpace;
        }
    }
    return height;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_isFirst) {
        _isFirst = NO;
        [self reloadData];
    }
}

@end

#pragma mark - 样式

@implementation HXTagLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tagOriginX = HXTagOriginX;
        _tagOriginY = HXTagOriginY;
        _tagSpace = HXTagSpace;
        _tagHeight = HXTagHeight;
        _tagHorizontalSpace = HXTagHorizontalSpace;
        _tagVerticalSpace = HXTagVerticalSpace;
    }
    return self;
}

@end

#pragma mark - 扩展方法

@implementation NSString (HXExtention)

- (CGSize)ex_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
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
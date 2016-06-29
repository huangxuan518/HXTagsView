//
//  HXTagsView.h
//  黄轩 https://github.com/huangxuan518
//
//  Created by 黄轩 on 16/1/13.
//  Copyright © 2015年 IT小子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXTagCollectionViewFlowLayout.h"

@class HXTagAttribute;

@interface HXTagsView : UIView

@property (nonatomic,strong) NSArray *tags;//传入的标签数组 字符串数组
@property (nonatomic,strong) HXTagCollectionViewFlowLayout *layout;//布局layout
@property (nonatomic,strong) HXTagAttribute *tagAttribute;//按钮样式对象
@property (nonatomic,assign) BOOL isMultiSelect;//是否可以多选 默认:NO 单选
@property (nonatomic,copy) NSString *key;//搜索关键词

@property (nonatomic,copy) void (^completion)(NSArray *selectTags,NSInteger currentIndex);//选中的标签数组,当前点击的index

//刷新界面
- (void)reloadData;

@end



#pragma mark - 标签样式

@interface HXTagAttribute : NSObject

@property (nonatomic,assign) CGFloat borderWidth;//标签边框宽度
@property (nonatomic,strong) UIColor *borderColor;//标签边框颜色
@property (nonatomic,assign) CGFloat cornerRadius;//标签圆角大小
@property (nonatomic,strong) UIColor *normalBackgroundColor;//标签默认背景颜色
@property (nonatomic,strong) UIColor *selectedBackgroundColor;//标签选中背景颜色
@property (nonatomic,assign) CGFloat titleSize;//标签字体大小
@property (nonatomic,strong) UIColor *textColor;//标签字体颜色
@property (nonatomic,strong) UIColor *keyColor;//搜索关键词颜色
@property (nonatomic,assign) CGFloat tagSpace;//标签内部左右间距(标题距离边框2边的距离和)

@end

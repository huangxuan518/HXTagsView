//
//  HXTagButton.h
//  HXTagsView
//
//  Created by 黄轩 on 16/4/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXTagButton : UIView

#pragma mark 标签关键字加亮
@property (nonatomic,copy) NSString *tagKey;//关键字
@property (nonatomic,strong) UIColor *keyColor;//关键字颜色

#pragma mark 标签样式定制属性
@property (nonatomic,assign) float borderWidth;//标签边框宽度
@property (nonatomic,strong) UIColor *borderNormalColor;//标签边框默认颜色
@property (nonatomic,strong) UIColor *borderSelectedColor;//标签边框选中颜色
@property (nonatomic,assign) float cornerRadius;//标签圆角大小
@property (nonatomic,strong) UIColor *normalBackgroundColor;//标签默认背景颜色
@property (nonatomic,strong) UIColor *selectedBackgroundColor;//标签选中背景颜色

#pragma mark 标签标题属性
@property (nonatomic,assign) float titleSize;//标签字体大小
@property (nonatomic,copy) NSString *title;//标签内容
@property (nonatomic,strong) UIColor *titleNormalColor;//标签字体默认颜色
@property (nonatomic,strong) UIColor *titleSelectedColor;//标签字体选中颜色

#pragma mark 是否多选
@property (nonatomic,assign) BOOL isMultiSelect;//是否可以多选 默认单选

@property (nonatomic,assign) BOOL selected;

@property (nonatomic,copy) void(^buttonAction)(NSInteger tag);

@end

//
//  HXTagsView.h
//  IT小子
//
//  Created by 黄轩 on 16/1/13.
//  Copyright © 2015年 IT小子. All rights reserved.
//


#import <UIKit/UIKit.h>

#define HXTagSpace 18.0
#define HXTagHeight 32.0
#define HXTagOriginX 10.0
#define HXTagOriginY 10.0
#define HXTagHorizontalSpace 10.0
#define HXTagVerticalSpace 10.0

@class HXTagsView;

@protocol HXTagsViewDelegate <NSObject>

@optional
- (void)tagsViewButtonAction:(HXTagsView *)tagsView button:(UIButton *)sender;

@end

@interface HXTagsView : UIScrollView

@property (nonatomic,assign) id<HXTagsViewDelegate> tagDelegate;

#pragma mark 可不设置,不设置则用默认值
@property (nonatomic,strong) NSDictionary *propertyDic;//属性字典
@property (nonatomic,assign) NSInteger type;//0.单行 1.平铺 默认单行,单行可以不设置type
@property (nonatomic,assign) float tagSpace;//标签内部左右间距(标题距离边框2边的距离和)
@property (nonatomic,assign) float tagHeight;//所有标签高度
@property (nonatomic,assign) float tagOriginX;//第一个标签起点X坐标
@property (nonatomic,assign) float tagOriginY;//第一个标签起点Y坐标
@property (nonatomic,assign) float tagHorizontalSpace;//标签间横向间距
@property (nonatomic,assign) float tagVerticalSpace;//标签间纵向间距

#pragma mark 标签定制属性
@property (nonatomic,assign) float borderWidth;//标签边框宽度
@property (nonatomic,assign) BOOL masksToBounds;//标签是否有圆角
@property (nonatomic,assign) float cornerRadius;//标签圆角大小
@property (nonatomic,assign) float titleSize;//标签字体大小
@property (nonatomic,strong) UIColor *titleNormalColor;//标签字体默认颜色
@property (nonatomic,strong) UIColor *titleSelectedColor;//标签字体选中颜色
@property (nonatomic,strong) UIImage *normalBackgroundImage;//标签默认背景颜色
@property (nonatomic,strong) UIImage *highlightedBackgroundImage;//标签高亮背景颜色
@property (nonatomic,strong) UIImage *selectedBackgroundImage;//标签选中背景颜色

@property (nonatomic,assign) NSInteger currentIndex;//当前点击的标签

/**
 *  设置标签数据和代理
 *
 *  @param tagAry   标签数组,只支持字符串数组
 *  @param delegate 代理
 */
- (void)setTagAry:(NSArray *)tagAry delegate:(id)delegate;

/**
 *  计算标签的高度
 *
 *  @param ary 标签字符串数组
 *  @param dic 
             @{@"frameSizeWidth":@([[UIScreen mainScreen] bounds].size.width),
             @"type":@(0),
             @"tagOriginX":@(10),
             @"tagSpace":@(9),
             @"tagHorizontalSpace":@(10),
             @"tagOriginY":@(10),
             @"tagHeight":@(32),
             @"tagVerticalSpace":@(10)};
 *
 *  @return <#return value description#>
 */
+ (float)getTagsViewHeight:(NSArray *)ary dic:(NSDictionary *)dic;

@end


#pragma mark - 扩展方法

@interface NSString (HXExtention)
- (CGSize)fdd_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
@end

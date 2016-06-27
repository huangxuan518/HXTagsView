//
//  HXTagsView.h
//  IT小子
//
//  Created by 黄轩 on 16/1/13.
//  Copyright © 2015年 IT小子. All rights reserved.
//


#import <UIKit/UIKit.h>

@class HXTagsView;
@class HXTagLayout;
@class HXTagAttribute;

#pragma mark - 代理方法

@protocol HXTagsViewDelegate <NSObject>

@optional

/**
 *  多选模式
 *
 *  @param tagsView <#tagsView description#>
 *  @param tags     多选的标签数组
 */
- (void)tagsViewButtonAction:(HXTagsView *)tagsView tags:(NSArray *)tags;

/**
 *  单选模式
 *
 *  @param tagsView    <#tagsView description#>
 *  @param selectIndex 当前选的标签index
 *  @param title       当前选的标签标题
 */
- (void)tagsViewButtonAction:(HXTagsView *)tagsView selectIndex:(NSInteger)selectIndex tagTitle:(NSString *)title;

@end

#pragma mark - HXTagsView

@interface HXTagsView : UIScrollView

@property (nonatomic,assign) id<HXTagsViewDelegate> tagDelegate;//代理
@property (nonatomic,strong) HXTagLayout *tagLayout;//布局对象
@property (nonatomic,strong) HXTagAttribute *tagAttribute;//按钮样式对象
@property (nonatomic,strong) NSArray *tagAry;//传入的标签数组 字符串数组
@property (nonatomic,copy) NSString *key;//搜索关键词
@property (nonatomic,assign) BOOL isMultiSelect;//是否可以多选 默认单选

//刷新界面
- (void)reloadData;

/**
 *  获取高度
 *
 *  @param ary       标签数组
 *  @param tagLayout 标签的布局
 *  @param width     标签的宽度
 *
 *  @return 标签View的高度
 */
+ (float)getTagsViewHeightWithTags:(NSArray *)ary tagLayout:(HXTagLayout *)tagLayout width:(float)width;

@end

#pragma mark - 布局参数

@interface HXTagLayout : NSObject

@property (nonatomic,assign) NSInteger type;//0.单行 1.平铺 默认单行,单行可以不设置type
@property (nonatomic,assign) float tagSpace;//标签内部左右间距(标题距离边框2边的距离和)
@property (nonatomic,assign) float tagHeight;//标签高度
@property (nonatomic,assign) float tagOriginX;//第一个标签起点X坐标
@property (nonatomic,assign) float tagOriginY;//第一个标签起点Y坐标
@property (nonatomic,assign) float tagHorizontalSpace;//标签间横向间距
@property (nonatomic,assign) float tagVerticalSpace;//标签间纵向间距

@end


#pragma mark - 扩展方法

@interface NSString (HXExtention)
- (CGSize)ex_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
@end

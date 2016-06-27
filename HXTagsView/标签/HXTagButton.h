//
//  HXTagButton.h
//  HXTagsView
//
//  Created by 黄轩 on 16/4/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXTagAttribute.h"

@interface HXTagButton : UIView

#pragma mark 标签样式
@property (nonatomic,strong) HXTagAttribute *tagAttribute;

#pragma mark 标签关键字
@property (nonatomic,copy) NSString *tagKey;//关键字

#pragma mark 标签标题
@property (nonatomic,copy) NSString *title;//标签内容

#pragma mark 是否多选
@property (nonatomic,assign) BOOL isMultiSelect;//是否可以多选 默认单选

#pragma mark 选中状态
@property (nonatomic,assign) BOOL selected;

@property (nonatomic,copy) void(^buttonAction)(HXTagButton *tagButton);

@end

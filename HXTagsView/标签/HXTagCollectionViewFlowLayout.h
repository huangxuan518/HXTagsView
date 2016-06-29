//
//  HXTagCollectionViewFlowLayout.h
//  黄轩 https://github.com/huangxuan518
//
//  Created by 黄轩 on 16/1/13.
//  Copyright © 2015年 IT小子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXTagCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGRect defauleRect;//默认rect
@property (nonatomic,assign) BOOL isMultiLineRoll;//是否多行滚动 默认不滚动

@end

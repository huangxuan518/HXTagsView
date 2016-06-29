//
//  HXTagsView.m
//  黄轩 https://github.com/huangxuan518
//
//  Created by 黄轩 on 16/1/13.
//  Copyright © 2015年 IT小子. All rights reserved.
//

#import "HXTagsView.h"
#import "HXTagCollectionViewCell.h"

@interface HXTagsView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,strong) NSMutableArray *selectedTags;
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation HXTagsView

static NSString * const reuseIdentifier = @"HXTagCollectionViewCellId";

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setup
{
    //初始化样式
    _tagAttribute = [HXTagAttribute new];
    
    _layout = [[HXTagCollectionViewFlowLayout alloc] init];
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _layout.itemSize = CGSizeMake(100.0f, 32.0f);
    _layout.minimumInteritemSpacing = 10.0f;
    _layout.minimumLineSpacing = 10.0f;
    _layout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    
    _layout.defauleRect = self.bounds;
    [self addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDelegate | UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _tags.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HXTagCollectionViewFlowLayout *layout = (HXTagCollectionViewFlowLayout *)collectionView.collectionViewLayout;
    CGSize maxSize = CGSizeMake(collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right, layout.itemSize.height);
    
    CGRect frame = [_tags[indexPath.item] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:_tagAttribute.titleSize]} context:nil];
    
    return CGSizeMake(frame.size.width + _tagAttribute.tagSpace, layout.itemSize.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HXTagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = _tagAttribute.normalBackgroundColor;
    cell.layer.borderColor = _tagAttribute.borderColor.CGColor;
    cell.layer.cornerRadius = _tagAttribute.cornerRadius;
    cell.layer.borderWidth = _tagAttribute.borderWidth;
    cell.titleLabel.textColor = _tagAttribute.textColor;
    cell.titleLabel.font = [UIFont systemFontOfSize:_tagAttribute.titleSize];
    
    NSString *title = self.tags[indexPath.item];
    if (_key.length > 0) {
        cell.titleLabel.attributedText = [self searchTitle:title key:_key keyColor:_tagAttribute.keyColor];
    } else {
        cell.titleLabel.text = title;
    }
        
    if ([self.selectedTags containsObject:self.tags[indexPath.item]]) {
        cell.backgroundColor = _tagAttribute.selectedBackgroundColor;
    }
    
    if (indexPath.item + 1 == _tags.count) {
        if (!_layout.isMultiLineRoll) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.collectionView.collectionViewLayout.collectionViewContentSize.height);
        } else {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _layout.defauleRect.size.height);
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HXTagCollectionViewCell *cell = (HXTagCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if ([self.selectedTags containsObject:self.tags[indexPath.item]]) {
        cell.backgroundColor = _tagAttribute.normalBackgroundColor;
        [self.selectedTags removeObject:self.tags[indexPath.item]];
    }
    else {
        if (_isMultiSelect) {
            cell.backgroundColor = _tagAttribute.selectedBackgroundColor;
            [self.selectedTags addObject:self.tags[indexPath.item]];
        } else {
            [self.selectedTags removeAllObjects];
            [self.selectedTags addObject:self.tags[indexPath.item]];
            
            [self reloadData];
        }
    }
    
    if (_completion) {
        _completion(self.selectedTags,indexPath.item);
    }
}

// 设置文字中关键字高亮
- (NSMutableAttributedString *)searchTitle:(NSString *)title key:(NSString *)key keyColor:(UIColor *)keyColor {
    
    NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:title];
    NSString *copyStr = title;
    
    NSMutableString *xxstr = [NSMutableString new];
    for (int i = 0; i < key.length; i++) {
        [xxstr appendString:@"*"];
    }
    
    while ([copyStr rangeOfString:key].location != NSNotFound) {
        
        NSRange range = [copyStr rangeOfString:key];
        
        [titleStr addAttribute:NSForegroundColorAttributeName value:keyColor range:range];
        copyStr = [copyStr stringByReplacingCharactersInRange:NSMakeRange(range.location, range.length) withString:xxstr];
    }
    return titleStr;
}

- (void)reloadData {
    [self.collectionView reloadData];
}

#pragma mark - 懒加载

- (NSMutableArray *)selectedTags
{
    if (!_selectedTags) {
        _selectedTags = [NSMutableArray array];
    }
    return _selectedTags;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:_layout.defauleRect collectionViewLayout:_layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
        [_collectionView registerClass:[HXTagCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    
    if (_layout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        //垂直
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
    } else {
        _collectionView.showsHorizontalScrollIndicator = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    
    return _collectionView;
}

@end





@implementation HXTagAttribute

- (instancetype)init
{
    self = [super init];
    if (self) {
        int r = arc4random() % 255;
        int g = arc4random() % 255;
        int b = arc4random() % 255;
        
        UIColor *normalColor = [UIColor colorWithRed:b/255.0 green:r/255.0 blue:g/255.0 alpha:1.0];
        UIColor *normalBackgroundColor = [UIColor whiteColor];
        UIColor *selectedBackgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        
        _borderWidth = 0.5f;
        _borderColor = normalColor;
        _cornerRadius = 2.0;
        _normalBackgroundColor = normalBackgroundColor;
        _selectedBackgroundColor = selectedBackgroundColor;
        _titleSize = 14;
        _textColor = normalColor;
        _keyColor = [UIColor redColor];
        _tagSpace = 20;
    }
    return self;
}

@end

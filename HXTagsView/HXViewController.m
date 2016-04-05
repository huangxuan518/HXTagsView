//
//  HXViewController.m
//  HXTagsView
//
//  Created by 黄轩 on 16/1/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "HXViewController.h"
#import "HXWebViewController.h"
#import "HXTagsView.h"

@interface HXViewController ()

@end

@implementation HXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"标签";
    
    /*单行是否滚动是标签的数量决定的,当标签排列在一起的长度大于屏幕的长度,则会滚动*/

    //单行不滚动 ===
    NSArray *tagAry = @[@"英雄联盟",@"穿越火线",@"地下城与勇士"];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 200, 20)];
    titleLable.text = @"单行不滚动";
    [self.view addSubview:titleLable];
    
    NSDictionary *propertyDic = @{@"type":@"0"};//可添加多个属性
    float height = [HXTagsView getTagsViewHeight:tagAry dic:propertyDic];
    HXTagsView *tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, titleLable.frame.origin.y+titleLable.frame.size.height+10, self.view.frame.size.width, height)];
    //以下2种方式皆可或者不设置,默认为单行
    tagsView.type = 0;
    //tagsView.propertyDic = propertyDic;
    //是否可以多选
    //tagsView.isMultiSelect = YES;
    [tagsView setTagAry:tagAry delegate:self];
    [self.view addSubview:tagsView];
    
    
    //单行滚动 ===
    tagAry = @[@"魔兽世界",@"梦幻西游",@"qq飞车",@"传奇",@"逆战",@"炉石传说",@"剑灵",@"qq炫舞",@"dota2",@"300英雄",@"笑傲江湖ol",@"剑网3",@"坦克世界",@"神武",@"龙之谷"];
    
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, tagsView.frame.origin.y+tagsView.frame.size.height+10, 200, 20)];
    titleLable.text = @"单行滚动";
    [self.view addSubview:titleLable];
    
    propertyDic = @{@"type":@"0"};
    height = [HXTagsView getTagsViewHeight:tagAry dic:propertyDic];
    tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, titleLable.frame.origin.y+titleLable.frame.size.height+10, self.view.frame.size.width, height)];
    //以下2种方式皆可或者不设置,默认为单行
    //tagsView.type = 0;
    //是否可以多选
    //tagsView.isMultiSelect = YES;
    tagsView.propertyDic = propertyDic;
    [tagsView setTagAry:tagAry delegate:self];
    [self.view addSubview:tagsView];
    
    
    /*多行是否滚动是HXTagsView的高度和标签计算出的高度比较后决定的,当HXTagsView的高度小于计算出的高度则自动滚动*/
    
    //多行不滚动 ===
    tagAry = @[@"冒险岛",@"反恐精英ol",@"魔域",@"诛仙",@"火影ol",@"问道",@"天龙八部",@"枪神纪",@"英魂之刃",@"勇者大冒险",@"nba 2k",@"上古世纪",@"跑跑卡丁车",@"传奇世界",@"劲舞团",@"激战2"];
    
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, tagsView.frame.origin.y+tagsView.frame.size.height+10, 200, 20)];
    titleLable.text = @"多行平铺";
    [self.view addSubview:titleLable];

    propertyDic = @{@"type":@"1"};
    height = [HXTagsView getTagsViewHeight:tagAry dic:propertyDic];
    tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, titleLable.frame.origin.y+titleLable.frame.size.height+10, self.view.frame.size.width, height)];
    tagsView.propertyDic = propertyDic;
    [tagsView setTagAry:tagAry delegate:self];
    [self.view addSubview:tagsView];
    
    
    //多行滚动 ===
    tagAry = @[@"蜀山ol",@"天下3",@"大话西游2",@"热血江湖",@"游戏人生",@"梦三国",@"流星蝴蝶剑",@"九阴真经",@"斗战神",@"奇迹mu",@"最终幻想14",@"宠物小精灵",@"天龙八部3",@"qq三国",@"倩女幽魂ol",@"御龙在天"];
    
    tagAry = @[@"蜀山ol",@"蜀山ol",@"蜀山ol",@"蜀山ol",@"蜀山ol",@"蜀山ol",@"蜀山ol",@"蜀山ol",@"蜀山ol",@"蜀山ol",@"蜀山ol",@"蜀山ol"];
    
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, tagsView.frame.origin.y+tagsView.frame.size.height+10, 200, 20)];
    titleLable.text = @"多行滚动";
    [self.view addSubview:titleLable];
    
    tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, titleLable.frame.origin.y+titleLable.frame.size.height+10, self.view.frame.size.width, 100)];
    tagsView.type = 1;
    [tagsView setTagAry:tagAry delegate:self];
    [self.view addSubview:tagsView];
}

#pragma mark HXTagsViewDelegate

/**
 *  tagsView代理方法
 *
 *  @param tagsView tagsView
 *  @param sender   tag:sender.titleLabel.text index:sender.tag
 */
- (void)tagsViewButtonAction:(HXTagsView *)tagsView button:(UIButton *)sender {
    NSLog(@"tag:%@ index:%ld",sender.titleLabel.text,(long)sender.tag);
    
    //是否多选
    BOOL isMultiSelect = NO;
    
    if (isMultiSelect) {
        NSLog(@"选中的标签:%@",tagsView.tags);
    } else {
        HXWebViewController *vc = [[HXWebViewController alloc] init];
        vc.keyWord = sender.titleLabel.text;
        [self.navigationController pushViewController:vc animated:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

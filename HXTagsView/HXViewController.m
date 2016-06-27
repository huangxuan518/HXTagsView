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
#import "HXTagButton.h"

@interface HXViewController () <HXTagsViewDelegate>

@end

@implementation HXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"标签";
    
    HXTagLayout *tagLayout = [HXTagLayout new];
    
    /*单行是否滚动是标签的数量决定的,当标签排列在一起的长度大于屏幕的长度,则会滚动*/

    //单行不滚动 ===
    NSArray *tagAry = @[@"英雄联盟",@"穿越火线",@"地下城与勇士"];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 200, 20)];
    titleLable.text = @"单行不滚动";
    [self.view addSubview:titleLable];
    
    float height = 52;
    HXTagsView *tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, titleLable.frame.origin.y+titleLable.frame.size.height+10, self.view.frame.size.width, height)];
    tagsView.tagAry = tagAry;
    tagsView.tagDelegate = self;
    //改变参数后请执行刷新
    //[tagsView reloadData];
    [self.view addSubview:tagsView];
    
    
    //单行滚动 ===
    tagAry = @[@"魔兽世界",@"梦幻西游",@"qq飞车",@"传奇",@"逆战",@"炉石传说",@"剑灵",@"qq炫舞",@"dota2",@"300英雄",@"笑傲江湖ol",@"剑网3",@"坦克世界",@"神武",@"龙之谷"];
    
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, tagsView.frame.origin.y+tagsView.frame.size.height+10, 200, 20)];
    titleLable.text = @"单行滚动";
    [self.view addSubview:titleLable];
    
    tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, titleLable.frame.origin.y+titleLable.frame.size.height+10, self.view.frame.size.width, height)];
    tagsView.tagAry = tagAry;
    tagsView.tagDelegate = self;
    //改变参数后请执行刷新
    //[tagsView reloadData];
    [self.view addSubview:tagsView];
    
    
    /*多行是否滚动是HXTagsView的高度和标签计算出的高度比较后决定的,当HXTagsView的高度小于计算出的高度则自动滚动*/
    
    //多行不滚动 ===
    tagAry = @[@"冒险岛游戏",@"反恐精英ol游戏",@"游戏魔域",@"诛游戏仙",@"火游戏影ol游戏",@"问游戏道",@"天游戏龙游戏八游戏部",@"枪神纪游戏",@"英魂之游戏刃",@"勇者游戏大冒险",@"nba 游戏2k",@"上古世纪游戏",@"游戏跑跑卡游戏丁车",@"传奇世界游戏",@"劲舞游戏团",@"激游戏战2"];
    
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, tagsView.frame.origin.y+tagsView.frame.size.height+10, 200, 20)];
    titleLable.text = @"多行平铺";
    [self.view addSubview:titleLable];

    tagLayout.type = 1;
    height = [HXTagsView getTagsViewHeightWithTags:tagAry tagLayout:tagLayout width:self.view.frame.size.width];
    tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, titleLable.frame.origin.y+titleLable.frame.size.height+10, self.view.frame.size.width, height)];
    //改变标签的各种样式请修改tagAttribute字段
    tagsView.tagAttribute.titleSize = 20;
    tagsView.tagLayout.type = 1;
    tagsView.isMultiSelect = YES;
    tagsView.key = @"游戏";
    tagsView.tagAry = tagAry;
    tagsView.tagDelegate = self;
    //改变参数后请执行刷新
    //[tagsView reloadData];
    [self.view addSubview:tagsView];
    
    
    //多行滚动 ===
    tagAry = @[@"蜀山ol",@"天下3",@"大话西游2",@"热血江湖",@"游戏人生",@"梦三国",@"流星蝴蝶剑",@"九阴真经",@"斗战神",@"奇迹mu",@"最终幻想14",@"宠物小精灵",@"天龙八部3",@"qq三国",@"倩女幽魂ol",@"御龙在天"];
        
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, tagsView.frame.origin.y+tagsView.frame.size.height+10, 200, 20)];
    titleLable.text = @"多行滚动";
    [self.view addSubview:titleLable];
    
    tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, titleLable.frame.origin.y+titleLable.frame.size.height+10, self.view.frame.size.width, 100)];
    tagsView.tagAry = tagAry;
    tagsView.tagLayout = tagLayout;
    tagsView.tagDelegate = self;
    //改变参数后请执行刷新
    //[tagsView reloadData];
    [self.view addSubview:tagsView];
}

#pragma mark HXTagsViewDelegate

- (void)tagsViewButtonAction:(HXTagsView *)tagsView tags:(NSArray *)tags {
    NSLog(@"选中的所有标签:{%@}",tags.description);
}

/**
 *  单选模式
 *
 *  @param tagsView    <#tagsView description#>
 *  @param selectIndex 当前选的标签index
 *  @param title       当前选的标签标题
 */
- (void)tagsViewButtonAction:(HXTagsView *)tagsView selectIndex:(NSInteger)selectIndex tagTitle:(NSString *)title {    
    HXWebViewController *vc = [[HXWebViewController alloc] init];
    vc.keyWord = title;
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

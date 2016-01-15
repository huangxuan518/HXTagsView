//
//  ViewController.m
//  HXTagsView
//
//  Created by 黄轩 on 16/1/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "ViewController.h"
#import "HXTagsView.h"
#import "UIView+Helpers.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //测试数据 标签数组
    NSArray *tagAry = @[@"英雄联盟",@"穿越火线",@"地下城与勇士",@"魔兽世界",@"梦幻西游",@"qq飞车",@"传奇",@"逆战",@"炉石传说",@"剑灵",@"qq炫舞",@"dota2",@"300英雄",@"笑傲江湖ol",@"剑网3",@"坦克世界",@"神武",@"龙之谷",@"冒险岛",@"反恐精英ol",@"魔域",@"诛仙",@"火影ol",@"问道",@"天龙八部",@"枪神纪",@"英魂之刃",@"勇者大冒险",@"nba 2k",@"上古世纪",@"跑跑卡丁车",@"传奇世界",@"劲舞团",@"激战2",@"蜀山ol",@"天下3",@"大话西游2",@"热血江湖",@"游戏人生",@"梦三国",@"流星蝴蝶剑",@"九阴真经",@"斗战神",@"奇迹mu",@"最终幻想14",@"宠物小精灵",@"天龙八部3",@"qq三国",@"倩女幽魂ol",@"御龙在天"];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 200, 20)];
    titleLable.text = @"单行滚动";
    [self.view addSubview:titleLable];
    
    //单行滚动实例化方法
    HXTagsView *tagsView1 = [[HXTagsView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, 0)];
    tagsView1.type = 1;
    tagsView1.frameSizeHeight = [tagsView1 getTagsViewHeight:tagAry];
    [tagsView1 setTagAry:tagAry delegate:self];
    [self.view addSubview:tagsView1];
    
    UILabel *titleLable2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, 200, 20)];
    titleLable2.text = @"多行平铺";
    [self.view addSubview:titleLable2];
    
    //多行不滚动实例化方法
    HXTagsView *tagsView2 = [[HXTagsView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 100)];
    tagsView2.type = 0;
    tagsView2.frameSizeHeight = [tagsView2 getTagsViewHeight:tagAry];
    [tagsView2 setTagAry:tagAry delegate:self];
    [self.view addSubview:tagsView2];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

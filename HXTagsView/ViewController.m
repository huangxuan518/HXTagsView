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
    NSArray *tagAry = @[@"精装修精装修",@"学区房",@"高得房率",@"品牌",@"地铁盘",@"优惠精装修",@"现房得",@"小户型",@"低总价",@"优质学区",@"精装修精装修学区房",@"高得房率品牌",@"地铁盘优惠精装修",@"现房得小户型",@"低总价优质学区"];
    
    //单行滚动实例化方法
    HXTagsView *tagsView1 = [HXTagsView new];
    tagsView1.type = 1;
    tagsView1.frameOriginY = 100;
    tagsView1.frameSizeHeight = 52;
    [tagsView1 setTagAry:tagAry delegate:self];
    [self.view addSubview:tagsView1];
    
    //多行不滚动实例化方法
    HXTagsView *tagsView2 = [HXTagsView new];
    tagsView2.type = 0;
    tagsView2.frameOriginY = 200;
    tagsView2.frameSizeHeight = [tagsView2 getCellFrame:tagAry];
    [tagsView2 setTagAry:tagAry delegate:self];
    [self.view addSubview:tagsView2];
}

#pragma mark HXTagsViewDelegate

- (void)tagsViewButtonAction:(HXTagsView *)tagsView button:(UIButton *)sender {
    NSLog(@"tag:%@ index:%ld",sender.titleLabel.text,(long)sender.tag);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

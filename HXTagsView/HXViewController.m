//
//  HXViewController.m
//  HXTagsView
//
//  Created by 黄轩 on 16/1/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "HXViewController.h"
#import "HXTagTableViewController.h"
#import "HXTagsView.h"

@interface HXViewController () <UIActionSheetDelegate>

@property (nonatomic,strong) UILabel *titleLabel;//标题
@property (nonatomic, strong) HXTagsView *tagsView;//tagsView
@property (nonatomic,assign) BOOL isScrollDirection;//单行多行开关
@property (nonatomic,assign) BOOL isMultiLineRoll;//多行滚动不滚动开关
@property (nonatomic,assign) BOOL isMultiSelect;//单选多选开关

@property (nonatomic,strong) UIView *scrollDirectionView;
@property (nonatomic,strong) UIView *multiLineRollView;
@property (nonatomic,strong) UIView *multiSelectView;

@end

@implementation HXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"tableView使用" style:UIBarButtonItemStyleDone target:self action:@selector(gotoTagTableViewController)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.title = @"标签";
    
    [self addView];
    
    self.titleLabel.text = @"单行滚动";
    [self showTagsView];
}

- (void)switchValueChanged:(UISwitch *)sender {
    BOOL on = sender.on;
    
    if (sender.tag == 1) {
        //单行多行开关
        if (on) {
            self.tagsView.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        } else {
            self.tagsView.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        }
        _isScrollDirection = on;
    } else if (sender.tag == 2) {
        //滚动不滚动开关
        _isMultiLineRoll = on;
    } else if (sender.tag == 3) {
        //单选多选开关
        self.tagsView.isMultiSelect = on;
        _isMultiSelect = on;
    }

    CGFloat height = [HXTagsView getHeightWithTags:self.tagsView.tags layout:self.tagsView.layout tagAttribute:self.tagsView.tagAttribute width:self.view.frame.size.width];
    NSLog(@"高度:==== %f",height);

    NSMutableString *str;
    
    if (_isScrollDirection) {
        str = [NSMutableString stringWithString:@"多行"];
        _multiLineRollView.hidden = NO;
        
        if (_isMultiLineRoll) {
            [str appendString:@"滚动"];
            self.tagsView.frame = CGRectMake(0, 300, self.view.frame.size.width, 100);
        } else {
            [str appendString:@"不滚动"];
            self.tagsView.frame = CGRectMake(0, 300, self.view.frame.size.width, height);
        }
    } else {
        str = [NSMutableString stringWithString:@"单行"];
        self.tagsView.frame = CGRectMake(0, 300, self.view.frame.size.width, 52);
        _multiLineRollView.hidden = YES;
    }
    
    if (_isMultiSelect) {
        [str appendString:@"多选"];
    } else {
        [str appendString:@"单选"];
    }
    
    self.titleLabel.text = str;
    
    [self.tagsView reloadData];
}

/**
 *  显示
 */
- (void)showTagsView {
    self.tagsView.tags = @[@"火游戏影ol游戏",@"问游戏道",@"天游戏龙游戏八游戏部",@"枪神纪游戏",@"英魂之游戏刃",@"勇者游戏大冒险",@"nba 游戏2k",@"上古世纪游戏",@"游戏跑跑卡游戏丁车",@"传奇世界游戏",@"劲舞游戏团",@"激游戏战2",@"蜀山ol",@"天下3",@"大话西游2",@"热血江湖",@"游戏人生",@"梦三国",@"流星蝴蝶剑",@"九阴真经",@"斗战神",@"奇迹mu",@"最终幻想14",@"宠物小精灵"];
    [self.tagsView reloadData];
}

#pragma mark - 添加View

- (void)addView {
    //单行多行开关
    _scrollDirectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 74, self.view.frame.size.width, 40)];
    _scrollDirectionView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 300, 40)];
    titleLabel.text = @"单行(NO)多行(YES)开关";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor grayColor];
    [_scrollDirectionView addSubview:titleLabel];
    
    UISwitch *mySwitch = [[ UISwitch alloc]initWithFrame:CGRectMake(_scrollDirectionView.frame.size.width - 70,0,0.0,0.0)];
    mySwitch.tag = 1;
    [mySwitch addTarget: self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_scrollDirectionView addSubview:mySwitch];
    
    [self.view addSubview:_scrollDirectionView];
    
    //滚动不滚动开关
    _multiLineRollView = [[UIView alloc] initWithFrame:CGRectMake(0, 74 + 40, self.view.frame.size.width, 40)];
    _multiLineRollView.backgroundColor = [UIColor whiteColor];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 300, 40)];
    titleLabel.text = @"多行滚动(YES)不滚动(NO)开关(多行起作用)";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor grayColor];
    _multiLineRollView.hidden = YES;
    [_multiLineRollView addSubview:titleLabel];
    
    mySwitch = [[ UISwitch alloc]initWithFrame:CGRectMake(_multiLineRollView.frame.size.width - 70,0,0.0,0.0)];
    mySwitch.tag = 2;
    [mySwitch addTarget: self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_multiLineRollView addSubview:mySwitch];
    
    [self.view addSubview:_multiLineRollView];
    
    //单选多选开关
    _multiSelectView = [[UIView alloc] initWithFrame:CGRectMake(0, 74 + 80, self.view.frame.size.width, 40)];
    _multiSelectView.backgroundColor = [UIColor whiteColor];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 300, 40)];
    titleLabel.text = @"单选(NO)多选(YES)开关";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor grayColor];
    [_multiSelectView addSubview:titleLabel];
    
    mySwitch = [[ UISwitch alloc]initWithFrame:CGRectMake(_multiSelectView.frame.size.width - 70,0,0.0,0.0)];
    mySwitch.tag = 3;
    [mySwitch addTarget: self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_multiSelectView addSubview:mySwitch];
    
    [self.view addSubview:_multiSelectView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 200.0f, self.view.frame.size.width - 20, 40.0f)];
    [textField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    textField.placeholder = @"请输入搜索词";//默认显示的字
    textField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    [textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    UIView *inputAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(inputAccessoryView.frame.size.width - 42, 0, 32, 43.5);
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:@"收起" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(hideButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [inputAccessoryView addSubview:button];
    textField.inputAccessoryView = inputAccessoryView;
    [self.view addSubview:textField];
}

- (void)hideButtonAction:(UIButton *)sender {
    [self.view endEditing:YES];
}

- (void)textFieldChange:(UITextField *)sender {
    self.tagsView.key = sender.text;
    [self.tagsView reloadData];
}

#pragma mark - 懒加载

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 270, 200, 20)];
        [self.view addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (HXTagsView *)tagsView {
    if (!_tagsView) {
        _tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 52)];
        _tagsView.completion = ^(NSArray *selectTags,NSInteger currentIndex) {
            NSLog(@"selectTags:%@ currentIndex:%ld",selectTags, (long)currentIndex);
        };
        [self.view addSubview:_tagsView];
    }
    return _tagsView;
}

#pragma mark - goto

- (void)gotoTagTableViewController {
    HXTagTableViewController *vc = [HXTagTableViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

# HXTagsView
公司最近新做的一个项目中有个标签的需求,标签内容是服务器控制,也就是说,标签的位置需要动态计算,在网上找了一下相关代码,发现都不能满足项目需求,于是自己动手写了此开源标签类,希望能给有同样需求的你一点帮助.

# 适用
本标签类适用于标签长度不确定等动态计算的标签显示需求,当然固定的也是适用的,该类有2种展示方式,一种是一行滑动展示所有的标签,另一种是平铺展示所有标签

# 集成方法
1.下载本工程
2.将工程中标签文件全部拖到需要使用的工程中,标签类下除了HXTagsView一个类外,还有8个category扩展,因为HXTagsView类用到一些扩展方法.

# 用法
    NSArray *tagAry = @[@"英雄联盟",@"穿越火线",@"地下城与勇士",@"魔兽世界",@"梦幻西游",@"qq飞车",@"传奇",@"逆战",@"炉石传说",@"剑灵",@"qq炫舞",@"dota2",@"300英雄",@"笑傲江湖ol",@"剑网3",@"坦克世界",@"神武",@"龙之谷",@"冒险岛",@"反恐精英ol",@"魔域",@"诛仙",@"火影ol",@"问道",@"天龙八部",@"枪神纪",@"英魂之刃",@"勇者大冒险",@"nba 2k",@"上古世纪",@"跑跑卡丁车",@"传奇世界",@"劲舞团",@"激战2",@"蜀山ol",@"天下3",@"大话西游2",@"热血江湖",@"游戏人生",@"梦三国",@"流星蝴蝶剑",@"九阴真经",@"斗战神",@"奇迹mu",@"最终幻想14",@"宠物小精灵",@"天龙八部3",@"qq三国",@"倩女幽魂ol",@"御龙在天"];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 200, 20)];
    titleLable.text = @"单行滚动";
    [self.view addSubview:titleLable];
    
    //单行滚动实例化方法
    HXTagsView *tagsView1 = [HXTagsView new];
    tagsView1.type = 1;
    tagsView1.frameOriginY = 90;
    tagsView1.frameSizeHeight = 52;
    [tagsView1 setTagAry:tagAry delegate:self];
    [self.view addSubview:tagsView1];
    
    UILabel *titleLable2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, 200, 20)];
    titleLable2.text = @"多行平铺";
    [self.view addSubview:titleLable2];
    
    //多行不滚动实例化方法
    HXTagsView *tagsView2 = [HXTagsView new];
    tagsView2.type = 0;
    tagsView2.frameOriginY = 200;
    tagsView2.frameSizeHeight = [tagsView2 getCellFrame:tagAry];
    [tagsView2 setTagAry:tagAry delegate:self];
    [self.view addSubview:tagsView2];
    
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
# 用法说明
1. 实例化HXTagsView的时候不需要设置它的frame,因为它的frame是动态计算的
2. 根据type来设置单行滚动还是多行不滚动
3. 标签还有很多属性,比如标签边框颜色,边框宽度,圆角等等,所有都可以自己定制,详见.h文件
4. 单行滚动只需要设置一个高度即可,滑动范围,内部自动计算,多行不滚动高度需要调用- (float)getCellFrame:(NSArray *)ary计算

# 博客交流
 http://blog.libuqing.com/
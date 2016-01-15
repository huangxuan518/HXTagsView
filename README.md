# HXTagsView
公司最近新做的一个项目中有个标签的需求,标签内容是服务器控制,也就是说,标签的位置需要动态计算,在网上找了一下相关代码,发现都不能满足项目需求,于是自己动手写了此开源标签类,希望能给有同样需求的你一点帮助.

# 适用
本标签类适用于标签长度不确定等动态计算的标签显示需求,当然固定的也是适用的,该类有2种展示方式,一种是单行展示所有的标签,当超过一屏可以滚动显示,另一种是平铺展示所有标签,可以设置标签View的高度,当高度不够展示所有标签时,会滚动展示.

# 集成方法
1.下载本工程
2.将工程中标签文件全部拖到需要使用的工程中,目前只有HXTagsView一个类.

# 使用示例
    //单行不滚动 ===============
    NSArray *tagAry = @[@"英雄联盟",@"穿越火线",@"地下城与勇士"];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 200, 20)];
    titleLable.text = @"单行不滚动";
    [self.view addSubview:titleLable];
    
    //单行不需要设置高度,内部根据初始化参数自动计算高度
    HXTagsView *tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, titleLable.frameOriginY+titleLable.frameSizeHeight+10, self.view.frame.size.width, 0)];
    tagsView.type = 1;
    [tagsView setTagAry:tagAry delegate:self];
    [self.view addSubview:tagsView];
    
    
    //单行滚动  ===============
    tagAry = @[@"魔兽世界",@"梦幻西游",@"qq飞车",@"传奇",@"逆战",@"炉石传说",@"剑灵",@"qq炫舞",@"dota2",@"300英雄",@"笑傲江湖ol",@"剑网3",@"坦克世界",@"神武",@"龙之谷"];
    
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, tagsView.frameOriginY+tagsView.frameSizeHeight+10, 200, 20)];
    titleLable.text = @"单行滚动";
    [self.view addSubview:titleLable];
    
    //单行不需要设置高度,内部根据初始化参数自动计算高度
    tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, titleLable.frameOriginY+titleLable.frameSizeHeight+10, self.view.frame.size.width, 0)];
    tagsView.type = 1;
    [tagsView setTagAry:tagAry delegate:self];
    [self.view addSubview:tagsView];
    
    
    //多行不滚动 ===============
    tagAry = @[@"冒险岛",@"反恐精英ol",@"魔域",@"诛仙",@"火影ol",@"问道",@"天龙八部",@"枪神纪",@"英魂之刃",@"勇者大冒险",@"nba 2k",@"上古世纪",@"跑跑卡丁车",@"传奇世界",@"劲舞团",@"激战2"];
    
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, tagsView.frameOriginY+tagsView.frameSizeHeight+10, 200, 20)];
    titleLable.text = @"多行平铺";
    [self.view addSubview:titleLable];

    //多行不滚动,则计算出全部展示的高度,让maxHeight等于计算出的高度即可,初始化不需要设置高度
    tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, titleLable.frameOriginY+titleLable.frameSizeHeight+10, self.view.frame.size.width, 0)];
    tagsView.type = 0;
    tagsView.maxHeight = [tagsView getTagsViewHeight:tagAry];
    [tagsView setTagAry:tagAry delegate:self];
    [self.view addSubview:tagsView];
    
    
    //多行滚动 ===============
    tagAry = @[@"蜀山ol",@"天下3",@"大话西游2",@"热血江湖",@"游戏人生",@"梦三国",@"流星蝴蝶剑",@"九阴真经",@"斗战神",@"奇迹mu",@"最终幻想14",@"宠物小精灵",@"天龙八部3",@"qq三国",@"倩女幽魂ol",@"御龙在天"];
    
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, tagsView.frameOriginY+tagsView.frameSizeHeight+10, 200, 20)];
    titleLable.text = @"多行滚动";
    [self.view addSubview:titleLable];
    
    //多行滚动需要设置HXTagsView高度,当高度小于计算出的实际高度时,则自动滚动展示
    tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, titleLable.frameOriginY+titleLable.frameSizeHeight+10, self.view.frame.size.width, 100)];
    tagsView.type = 0;
    [tagsView setTagAry:tagAry delegate:self];
    [self.view addSubview:tagsView];
    
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
1. 实例化HXTagsView的时候只有平铺滚动展示需要设置HXTagsView的高度,其他几种情况都不需要设置HXTagsView的高度,因为它的高度是动态计算的,当您选择平铺展示,并且设置了HXTagsView的高度,当您设置的高度有值并且小于标签的计算高度时,则滚动显示,否则全部平铺.当您设置的高度过大时,也会将高度更改为全铺显示.
2. 根据type来设置单行滚动还是多行不滚动,type=0,是平铺,1.为单行
3. 标签还有很多属性,比如标签边框颜色,边框宽度,圆角等等,所有都可以自己定制,详见.h文件,完全可以满足您的需要

# 自动高度计算方法
单行:第一个标签起点Y坐标+标签高度+标签间纵向间距
多行平铺:第一个标签起点Y坐标+平铺行数*(标签高度+标签间纵向间距)

# 博客交流
 http://blog.libuqing.com/

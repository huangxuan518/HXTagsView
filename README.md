# HXTagsView
HXTagsView是一款支持自动布局的标签tag

特性： 

-流式展示标签 

-可以配置标签的字体大小、颜色、边框颜色、边框弧度大小、边框的宽度、高度、间隔、外边距等 

-支持单行 多行显示 

-可以在UITableViewCell中良好展示 

-不使用UICollectionView. 

-支持多选操作,控制字段isMultiSelect

-支持搜索关键词标签加亮以及关键词颜色自定义

# 效果展示


![image](https://github.com/huangxuan518/HXTagsView/blob/master/HXTagsView/xiaoguo.gif)
# 适用
本标签类适用于标签长度不确定等动态计算的标签显示需求,当然固定的也是适用的,该类有2种展示方式,一种是单行展示所有的标签,当超过一屏可以滚动显示,另一种是平铺展示所有标签,可以设置标签View的高度,当高度不够展示所有标签时,会滚动展示.

#参数说明图
![image](https://github.com/huangxuan518/HXTagsView/blob/master/HXTagsView/canshu.png)

# 使用示例
    /*单行是否滚动是标签的数量决定的,当标签排列在一起的长度大于屏幕的长度,则会滚动*/

    //单行不滚动 ===
    NSArray *tagAry = @[@"英雄联盟",@"穿越火线",@"地下城与勇士"];
    
    HXTagsView *tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
tagsView.tagAry = tagAry;
tagsView.tagDelegate = self;
    [self.view addSubview:tagsView];

    ![image](https://github.com/huangxuan518/HXTagsView/blob/master/HXTagsView/danhangbugundongxiaoguo.gif)
    
    
    //单行滚动 ===
    NSArray *tagAry = @[@"魔兽世界",@"梦幻西游",@"qq飞车",@"传奇",@"逆战",@"炉石传说",@"剑灵",@"qq炫舞",@"dota2",@"300英雄",@"笑傲江湖ol",@"剑网3",@"坦克世界",@"神武",@"龙之谷"];
    
    HXTagsView *tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    tagsView.tagAry = tagAry;
    tagsView.tagDelegate = self;
    [self.view addSubview:tagsView];

![image](https://github.com/huangxuan518/HXTagsView/blob/master/HXTagsView/danhanggundongxiaoguo.gif)
    
    
    /*多行是否滚动是HXTagsView的高度和标签计算出的高度比较后决定的,当HXTagsView的高度小于计算出的高度则自动滚动*/
    //多行不滚动单选 ===
    NSArray *tagAry = @[@"冒险岛",@"反恐精英ol",@"魔域",@"诛仙",@"火影ol",@"问道",@"天龙八部",@"枪神纪",@"英魂之刃",@"勇者大冒险",@"nba 2k",@"上古世纪",@"跑跑卡丁车",@"传奇世界",@"劲舞团",@"激战2"];
    
    propertyDic = @{@"type":@"1"};
    height = [HXTagsView getTagsViewHeight:tagAry dic:propertyDic];
    HXTagsView *tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
    tagsView.propertyDic = propertyDic;
tagsView.tagAry = tagAry;
tagsView.tagDelegate = self;
    [self.view addSubview:tagsView];

![image](https://github.com/huangxuan518/HXTagsView/blob/master/HXTagsView/duohangpingpudan1xiaoguo.gif)
    
    
    //多行滚动单选 ===
    NSArray *tagAry = @[@"蜀山ol",@"天下3",@"大话西游2",@"热血江湖",@"游戏人生",@"梦三国",@"流星蝴蝶剑",@"九阴真经",@"斗战神",@"奇迹mu",@"最终幻想14",@"宠物小精灵",@"天龙八部3",@"qq三国",@"倩女幽魂ol",@"御龙在天"];
    
    HXTagsView *tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    tagsView.type = 1;
    tagsView.tagAry = tagAry;
    tagsView.tagDelegate = self;
    [self.view addSubview:tagsView];

![image](https://github.com/huangxuan518/HXTagsView/blob/master/HXTagsView/duohanggundongxiaoguo.gif)

    //多行不滚动多选
    NSArray *tagAry = @[@"冒险岛游戏",@"反恐精英ol游戏",@"游戏魔域",@"诛游戏仙",@"火游戏影ol游戏",@"问游戏道",@"天游戏龙游戏八游戏部",@"枪神纪游戏",@"英魂之游戏刃",@"勇者游戏大冒险",@"nba 游戏2k",@"上古世纪游戏",@"游戏跑跑卡游戏丁车",@"传奇世界游戏",@"劲舞游戏团",@"激游戏战2"];

    propertyDic = @{@"type":@"1"};
    height = [HXTagsView getTagsViewHeight:tagAry dic:propertyDic];
    HXTagsView *tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, titleLable.frame.origin.y+titleLable.frame.size.height+10, self.view.frame.size.width, height)];
    tagsView.type = 1;
    tagsView.isMultiSelect = YES;
    tagsView.tagAry = tagAry;
    tagsView.tagDelegate = self;
    [self.view addSubview:tagsView];

![image](https://github.com/huangxuan518/HXTagsView/blob/master/HXTagsView/duohangpingpudanxiaoguo.gif)

    //多行不滚动有关键字多选
    NSArray *tagAry = @[@"冒险岛游戏",@"反恐精英ol游戏",@"游戏魔域",@"诛游戏仙",@"火游戏影ol游戏",@"问游戏道",@"天游戏龙游戏八游戏部",@"枪神纪游戏",@"英魂之游戏刃",@"勇者游戏大冒险",@"nba 游戏2k",@"上古世纪游戏",@"游戏跑跑卡游戏丁车",@"传奇世界游戏",@"劲舞游戏团",@"激游戏战2"];

    propertyDic = @{@"type":@"1"};
    height = [HXTagsView getTagsViewHeight:tagAry dic:propertyDic];
    HXTagsView *tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, titleLable.frame.origin.y+titleLable.frame.size.height+10, self.view.frame.size.width, height)];
    tagsView.type = 1;
    tagsView.isMultiSelect = YES;
    tagsView.key = @"游戏";
    tagsView.tagAry = tagAry;
    tagsView.tagDelegate = self;
    [self.view addSubview:tagsView];

![image](https://github.com/huangxuan518/HXTagsView/blob/master/HXTagsView/duohangpingpuxiaoguo.gif)
    
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
        NSLog(@"tag:%@ index:%ld",title,selectIndex);
    }
    
# 用法说明
1. 当您选择平铺展示,并且设置了HXTagsView的高度,当您设置的高度有值并且小于标签的计算高度时,则滚动显示,否则全部平铺.当您设置的高度过大时,也会将高度更改为全铺显示.
2. 根据type来设置单行滚动还是多行不滚动,type=1,是平铺,0.为单行,默认单行
3. 标签还有很多属性,比如标签边框颜色,边框宽度,圆角等等,所有都可以自己定制,详见.h文件,完全可以满足您的需要
4. 高度计算+ (float)getTagsViewHeight:(NSArray *)ary dic:(NSDictionary *)dic计算,ary为标签字符串数组,字典里面装对应的更改的属性值进去,方法会根据传人的值进行高度计算,如果传nil则用默认值进行计算

# 自动高度计算方法说明
单行:第一个标签起点Y坐标+标签高度+标签间纵向间距

多行平铺:第一个标签起点Y坐标+平铺行数*(标签高度+标签间纵向间距)

# 博客交流
 http://blog.libuqing.com/

# HXTagsView 如果对你有一点点帮助,请给一颗★,你的支持是对我的最大鼓励！推荐工具 iOS打包机器人 https://github.com/huangxuan518/HXPackRobot
HXTagsView是一款支持自动布局的标签tag

特性： 

-流式展示标签 

-可以配置标签的字体大小、颜色、边框颜色、边框弧度大小、边框的宽度、高度、间隔、外边距、标签内部左右间距等 

-支持单行 多行滚动显示 多行不滚动显示 

-支持多选操作,控制字段isMultiSelect

-支持cell，高度计算方法+ (CGFloat)getCellHeightWithTags:(NSArray *)tags layout:(HXTagCollectionViewFlowLayout *)layout tagAttribute:(HXTagAttribute *)tagAttribute width:(CGFloat)width;

-支持搜索关键词标签加亮以及关键词颜色自定义,设置key字段的值即可

-标签样式更改tagAttribute,tagSpace是标签内部左右间隔和，还有titleSize，这2个参数影响到计算

-标签布局计算属性更改layout,即更改HXTagCollectionViewFlowLayout的属性，包括.scrollDirection .itemSize .minimumInteritemSpacing .minimumLineSpacing .sectionInset等属性，用法同UICollectionViewFlowLayout;

# 效果展示


![image](https://github.com/huangxuan518/HXTagsView/blob/master/HXTagsView/xiaoguo.gif)
# 适用
本标签类适用于标签长度不确定等动态计算的标签显示需求

# View上使用HXTagsView示例

    //单行不滚动 ===
    NSArray *tagAry = @[@"英雄联盟",@"穿越火线",@"地下城与勇士"];


    HXTagsView *tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 52)];
    tagsView.tags = tagAry;
    [self.view addSubview:tagsView];

![image](https://github.com/huangxuan518/HXTagsView/blob/master/HXTagsView/danhangbugundongxiaoguo.gif)
    
    //单行滚动 ===
    NSArray *tagAry = @[@"魔兽世界",@"梦幻西游",@"qq飞车",@"传奇",@"逆战",@"炉石传说",@"剑灵",@"qq炫舞",@"dota2",@"300英雄",@"笑傲江湖ol",@"剑网3",@"坦克世界",@"神武",@"龙之谷"];
    
    HXTagsView *tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 52)];
    tagsView.tags = tagAry;
    [self.view addSubview:tagsView];

![image](https://github.com/huangxuan518/HXTagsView/blob/master/HXTagsView/danhanggundongxiaoguo.gif)
    
    //多行不滚动单选 ===
    NSArray *tagAry = @[@"冒险岛",@"反恐精英ol",@"魔域",@"诛仙",@"火影ol",@"问道",@"天龙八部",@"枪神纪",@"英魂之刃",@"勇者大冒险",@"nba 2k",@"上古世纪",@"跑跑卡丁车",@"传奇世界",@"劲舞团",@"激战2"];
    
    //高度需要计算出来
    HXTagsView *tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 52)];
    tagsView.tags = tagAry;
    tagsView.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    [self.view addSubview:tagsView];

![image](https://github.com/huangxuan518/HXTagsView/blob/master/HXTagsView/duohangpingpudan1xiaoguo.gif)
    
    //多行滚动单选 ===
    NSArray *tagAry = @[@"蜀山ol",@"天下3",@"大话西游2",@"热血江湖",@"游戏人生",@"梦三国",@"流星蝴蝶剑",@"九阴真经",@"斗战神",@"奇迹mu",@"最终幻想14",@"宠物小精灵",@"天龙八部3",@"qq三国",@"倩女幽魂ol",@"御龙在天"];
    
    float height = [HXTagsCell getCellHeightWithTags:self.tags layout:self.layout tagAttribute:nil width:tableView.frame.size.width];
    HXTagsView *tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, height)];
    tagsView.tags = tagAry;
    tagsView.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    tagsView.layout.isMultiLineRoll = YES;
    [self.view addSubview:tagsView];

![image](https://github.com/huangxuan518/HXTagsView/blob/master/HXTagsView/duohanggundongxiaoguo.gif)

    //多行不滚动多选
    NSArray *tagAry = @[@"冒险岛游戏",@"反恐精英ol游戏",@"游戏魔域",@"诛游戏仙",@"火游戏影ol游戏",@"问游戏道",@"天游戏龙游戏八游戏部",@"枪神纪游戏",@"英魂之游戏刃",@"勇者游戏大冒险",@"nba 游戏2k",@"上古世纪游戏",@"游戏跑跑卡游戏丁车",@"传奇世界游戏",@"劲舞游戏团",@"激游戏战2"];
    
    //高度需要计算出来
    float height = [HXTagsCell getCellHeightWithTags:self.tags layout:self.layout tagAttribute:nil width:tableView.frame.size.width];
    HXTagsView *tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, height)];
    tagsView.tags = tagAry;
    tagsView.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    tagsView.isMultiSelect = YES;
    [self.view addSubview:tagsView];

![image](https://github.com/huangxuan518/HXTagsView/blob/master/HXTagsView/duohangpingpudanxiaoguo.gif)

    //多行不滚动有关键字多选
    NSArray *tagAry = @[@"冒险岛游戏",@"反恐精英ol游戏",@"游戏魔域",@"诛游戏仙",@"火游戏影ol游戏",@"问游戏道",@"天游戏龙游戏八游戏部",@"枪神纪游戏",@"英魂之游戏刃",@"勇者游戏大冒险",@"nba 游戏2k",@"上古世纪游戏",@"游戏跑跑卡游戏丁车",@"传奇世界游戏",@"劲舞游戏团",@"激游戏战2"];

    //高度需要计算出来
    float height = [HXTagsCell getCellHeightWithTags:self.tags layout:self.layout tagAttribute:nil width:tableView.frame.size.width];
    HXTagsView *tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, height)];
    tagsView.tags = tagAry;
    tagsView.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    tagsView.isMultiSelect = YES;
    tagsView.key = @"游戏";
    [self.view addSubview:tagsView];

![image](https://github.com/huangxuan518/HXTagsView/blob/master/HXTagsView/duohangpingpuxiaoguo.gif)

# UITableView上使用HXTagsCell示例

    #import "HXTagTableViewController.h"
    #import "HXTagsCell.h"

    @interface HXTagTableViewController ()

    @property (nonatomic,strong) HXTagCollectionViewFlowLayout *layout;//布局layout
    @property (nonatomic,strong) NSArray *selectTags;

    @end

    @implementation HXTagTableViewController

    - (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {

        }
        return self;
    }

    - (HXTagCollectionViewFlowLayout *)layout {
        if (!_layout) {
            _layout = [HXTagCollectionViewFlowLayout new];
            _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        }
        return _layout;
    }

    - (NSArray *)tags {
        return @[@"火游戏影ol游戏",@"问游戏道",@"天游戏龙游戏八游戏部",@"枪神纪游戏",@"英魂之游戏刃",@"勇者游戏大冒险",@"nba 游戏2k",@"上古世纪游戏",@"游戏跑跑卡游戏丁车",@"传奇世界游戏",@"劲舞游戏团",@"激游戏战2",@"蜀山ol",@"天下3",@"大话西游2",@"热血江湖",@"游戏人生",@"梦三国",@"流星蝴蝶剑",@"九阴真经",@"斗战神",@"奇迹mu",@"最终幻想14",@"宠物小精灵"];
    }

    - (void)viewDidLoad {
        [super viewDidLoad];

        // Uncomment the following line to preserve selection between presentations.

        [self.tableView registerClass:HXTagsCell.class forCellReuseIdentifier:@"cellId"];
    }

    #pragma mark UITableViewDataSource/UITableViewDelegate

    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 1;
    }

    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        HXTagsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        if (!cell) {
        cell = [[HXTagsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
        }

        cell.tags = self.tags;
        cell.selectedTags = [NSMutableArray arrayWithArray:_selectTags];
        cell.layout = self.layout;
        cell.completion = ^(NSArray *selectTags,NSInteger currentIndex) {
            _selectTags = selectTags;
        };
        [cell reloadData];

        return cell;
    }

    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        float height = [HXTagsCell getCellHeightWithTags:self.tags layout:self.layout tagAttribute:nil width:tableView.frame.size.width];
        return height;
    }

    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

    @end


#高度计算方法

//View高度
+ (CGFloat)getHeightWithTags:(NSArray *)tags layout:(HXTagCollectionViewFlowLayout *)layout tagAttribute:(HXTagAttribute *)tagAttribute width:(CGFloat)width;
//cell高度
+ (CGFloat)getCellHeightWithTags:(NSArray *)tags layout:(HXTagCollectionViewFlowLayout *)layout tagAttribute:(HXTagAttribute *)tagAttribute width:(CGFloat)width;
    
# 选择回调方法
    
    self.tagsView.completion = ^(NSArray *selectTags,NSInteger currentIndex) {

    };
    
# 刷新方法

- (void)reloadData;

# 说明
1.当多行模式下，自定义高度小于计算出的高度时则滚动，大于或者等于计算出的高度时则不滚动
2.用高度计算方法，因为涉及到很多参数，所以如果需要计算，请设置layout，默认可以不设置，则是默认参数

更改参数后，请执行reloadData

# 在线预览
https://appetize.io/app/f9a5kn2tnfe0kade2zy7g2mja

# 博客交流
 http://blog.libuqing.com/

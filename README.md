# HXTagsView
公司最近新做的一个项目中有个标签的需求,标签内容是服务器控制,也就是说,标签的位置需要动态计算,在网上找了一下相关代码,发现都不能满足项目需求,于是自己动手写了此开源标签类,希望能给有同样需求的你一点帮助.

# 适用
本标签类适用于标签长度不确定等动态计算的标签显示需求,当然固定的也是适用的,该类有2种展示方式,一种是一行滑动展示所有的标签,另一种是平铺展示所有标签

# 集成方法
1.下载本工程
2.将工程中标签文件全部拖到需要使用的工程中,标签类下除了HXTagsView一个类外,还有8个category扩展,因为HXTagsView类用到一些扩展方法.

# 用法
    NSArray *tagAry = @[@"精装修精装修",@"学区房",@"高得房率",@"品牌",@"地铁盘",@"优惠精装修",@"现房得",@"小户型",@"低总价",@"优质学区",@"精装修精装修学区房",@"高得房率品牌",@"地铁盘优惠精装修",@"现房得小户型",@"低总价优质学区"];
    
    //单行滚动实例化方法
    HXTagsView *tagsView1 = [HXTagsView new];
    tagsView1.type = 1;
    tagsView1.frameSizeHeight = 52;
    [tagsView1 setTagAry:tagAry delegate:self];
    [self.view addSubview:tagsView1];
    
    //多行不滚动实例化方法
    HXTagsView *tagsView2 = [HXTagsView new];
    tagsView2.type = 0;
    tagsView2.frameSizeHeight = [tagsView2 getCellFrame:tagAry];
    [tagsView2 setTagAry:tagAry delegate:self];
    [self.view addSubview:tagsView2];
    
    #pragma mark HXTagsViewDelegate
    //代理方法,返回当前标签View 标签标题和标签所在的位置
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

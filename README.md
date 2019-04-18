&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;前端代码纯**Swift**编写,基本页面已经编写完成,下面首先将展示一下登录注册模块.后端接口用**Python3.0**编写,实现部分接口,数据库采用MySql.项目是完全仿照Twitter 客户端编写.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **由于项目时间较长,内容不乏一些OC的编程思想,有需要的随意看看思路吧.** 由于内容较多,文章简要介绍了一下,列了几张图.不麻烦的话给个赞或者star,谢谢!

**前台代码地址:**
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;https://github.com/waitwalker/MyTwitter

**后台代码地址:** 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;https://github.com/waitwalker/MyTwitterAPI

## 一. 项目主要架构模式:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.1 尽量采用现在比较流行的MVVM(model,view,viewModel),这里举一个简单的使用例子=>关于页面是一个列表页面:

![图1.1 关于页面(登录页面右上角按钮触发)](https://upload-images.jianshu.io/upload_images/1715253-7e6c4ac7164a1a17.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.2 列表的数据源来自MTTAboutViewModel,MTTAboutViewModel通过一个类方法将数据回调给MTTAboutTwitterViewController, MTTAboutTwitterViewController将数据传给cell(view).MTTAboutTwitterViewController不负责数据的请求以及业务处理.

![图1.2 MTTAboutViewModel数据请求处理](https://upload-images.jianshu.io/upload_images/1715253-e26ad030d2ff728e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)

1.3 将数据回调给VC:
![图1.3  VC获取viewModel回调过来的数据](https://upload-images.jianshu.io/upload_images/1715253-4ba934e05c919217.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)

1.4 view显示
![图1.4 view显示数据](https://upload-images.jianshu.io/upload_images/1715253-6ab558991c0764b5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)

## 二. 项目主要技术和第三方框架:
项目的架构主要采用mvvm模式,布局采用的是SnapKit(3.0+版本).

网络请求用的是Alamofire.

json数据解析用的SwiftyJSON.

事件流的监控用的是RxSwift,之前用过ReactiveCocoa,ReactiveCocoa也有自己的swift版本,两者都属于响应式编程框架,在语法上还是有很大区别.学习RxSwift比一门新的语言学习起来还要难受(个人感觉),不过基本用法掌握后使用起来很方便,具体实现可以参考项目中的代码.

还有其他方面的,比如设计模式什么的,太多,大家有兴趣的可以把项目克隆下来看看.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**由于项目时间较长,内容不乏一些OC的编程思想,有需要的随意看看思路吧.**

## 三 .项目结构主要分为:
### 3.1 登录&注册:

![3.1-1 登录注册](https://upload-images.jianshu.io/upload_images/1715253-0ac28327a678d9d2.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)

![3.1-2 登录注册](https://upload-images.jianshu.io/upload_images/1715253-d3c1a942b5172fff.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)


![3.1-3 登录注册](https://upload-images.jianshu.io/upload_images/1715253-1c06dc7eedb2ec75.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)

![3.1-4 登录注册](https://upload-images.jianshu.io/upload_images/1715253-82f3e95e86e340a5.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)

![3.1-5 登录注册](https://upload-images.jianshu.io/upload_images/1715253-82f3e95e86e340a5.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)


### 3.2 首页
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;首页页面,目前实现首页发推功能


![首页页面](https://upload-images.jianshu.io/upload_images/1715253-18161e97459cec50.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)

![发推页面](https://upload-images.jianshu.io/upload_images/1715253-0245434b010b04bd.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)



![选择相片](https://upload-images.jianshu.io/upload_images/1715253-a5aae56c642a3dc1.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)


### 3.3 搜索

![搜索页面](https://upload-images.jianshu.io/upload_images/1715253-7b41c8a9205b4544.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)


### 3.4 通知

![通知页面](https://upload-images.jianshu.io/upload_images/1715253-68f9e46124d6297a.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)

### 3.5 私信

![私信页面](https://upload-images.jianshu.io/upload_images/1715253-a90ffb5b6a14294b.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)

## 四. 后台接口
![4.1 后台接口](https://upload-images.jianshu.io/upload_images/1715253-24de6f1a3dbd7c7b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)
### 东西太多,一次写不了太多,未完待续...

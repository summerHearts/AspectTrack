最新的一套解决前后端数据埋点方案  https://github.com/summerHearts/Track  。
       如果你的公司用户基数足够大，那么根据埋点数据分析得到的反馈是非常有用的。除了第三方的埋点数据分析，比如友盟，如果我们希望自己也存一份数据，作为对友盟数据的对比，在iOS工程中如何实现呢？
       一般的埋点分为PV(界面级别的)，PA(action事件级别).下边为了减少冗余，简称PV,PA。PV中的数据一般都是静态的，与业务逻辑不相关，比如进入时间，离开时间，是否进入该界面等等。
       所以这类需求是很好处理的，一般都会让所有的controller都继承BaseViewController。这样左右的信息都基于一个类中，符合高聚合的表现。
       那么PA的事件埋点数据如何处理呢？最传统的方法是在每个action中添加相应的埋点数据，但是这样功能和业务逻辑就混在一起，代码结构很混乱，不简洁，不优雅。
       混在在一起，放眼望去，怎么埋点到处都是啊，自己都烦的不行。尤其是每一次action改变之后，对应的逻辑就要改变，我要去不同的类中去更改。实在是不胜其烦。
       其实早就有解决之道，而且非常好用，这里推荐MOAspect。它校于Aspect，有一个功能很重要就是支持相同的方法名注册，而Aspect是不支持不同类相同方法名注册的。
       这些都是都是在去年经过验证，并且线上反馈还不错的。大家可以放心去用，坑都是踩过的。
       因为项目中的业务是分模块来处理的，那么我们在埋点的时候也是根据业务逻辑来处理的。那么如何划分呢？
       我是这么划分的：
           
![Snip20160304_1.png](http://upload-images.jianshu.io/upload_images/325120-c00ead403c228366.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

       给出图片，大家自己看，后边有一个简单的Demo，已经放在github上。顺便说一句，希望大家遇到问题的时候能够冷静下来一点点分析。
     
       首先为了便于修改埋点数据，给出了宏定义的.h文件
        
![Snip20160304_2.png](http://upload-images.jianshu.io/upload_images/325120-60fac04f37f9a424.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

然后是埋点辅助类：
           
![Snip20160304_3.png](http://upload-images.jianshu.io/upload_images/325120-746b3f8253a23ab5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)


![Snip20160304_4.png](http://upload-images.jianshu.io/upload_images/325120-0170074a52641bc3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

接下来就是在具体的类中实现了：
       
![Snip20160304_5.png](http://upload-images.jianshu.io/upload_images/325120-53981a8e9cf7cd47.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

   

       
 
        



to 张浩千：
更新在mainpage中
你写的map的view controller已全部导入，在SubViewController.swift中	
然后我run了下可以build，但是地图好像没开始定位，可能plist没有加全
然后我试着把另一个工程导入……有些bug，最后剩两个实在改不动了
如果你想run一下的话,把“mapSelect”文件夹删了，再把我添在SubViewController.swift里的相关语句注释掉，应该就好了
主界面HKViewController也可以改swift，我之后改一下，然后你研究下怎么把画面中的块块变成按钮吧，以及和map页的衔接
然后还有注册登录页面和设置页面……



附：
swift，objc混编方法
http://www.jb51.net/article/52427.htm
其实就是向桥接文件（已添加在工程最上面：SlideMenu3D-Bridging-Header.h）里添加头文件就好了

11.24
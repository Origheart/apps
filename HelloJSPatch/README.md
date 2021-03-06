##JSPatch初探

####什么是JSPatch
JSPatch是一个开源项目，最初是腾讯@bang的个人项目，诞生于2015年5月。它能够使用JavaScript调用Objective-C的原生接口，从而动态植入代码来替换旧代码，以实现修复线上bug。

####JSPatch平台
JSPatch 需要使用者有一个后台可以下发和管理脚本，并且需要处理传输安全等部署工作。如果自己搭建后台下发 JSPatch 脚本，可以直接使用 github 上的代码。JSPatch 平台提供了脚本后台托管，版本管理，保证传输安全等功能，无需搭建一个后台，无需关心部署操作，只需引入一个 SDK 即可立即使用 JSPatch。

####JSPatch实现原理
#####基本原理
Objective-C是动态语言，具有运行时特性，该特性可通过类名称和方法名的字符串获取该类和该方法，并实例化和调用：

```
    Class class = NSClassFromString(@"DataManager");
    id dataManager = [[class alloc] init];
    SEL selector = NSSelectorFromString(@"saveData");
    [dataManager performSelector:selector];
```
也可以替换某个类的方法为新的实现：

```
    static void mySaveData(id slf, SEL sel) { }
    class_replaceMethod(class, selector, mySaveData, "");
```
新注册一个类，为类添加方法：

```
    Class cls = objc_allocateClassPair([NSObject class], "MyObject", 0);
    objc_registerClassPair(cls);
    class_addMethod(cls, selector, implement, typedesc);
```
#####Javascript调用
可以用Javascript对象定义一个Objective-C类：

```
{
  __isCls: 1,
  __clsName: "UIView"
}
```
在OC执行JS脚本前，通过正则把所有方法调用都改成调用 __c() 函数，再执行这个JS脚本，做到了消息转发机制：

```
UIView.alloc().init()
->
UIView.__c('alloc')().__c('init')()
```
#####互传消息
- `JavaScriptCore`: 通过此framework实现消息互传
- `JSContext`: JS代码的执行环境。JS通过调用 JSContext 定义的方法把数据传给OC，OC通过返回值传会给JS。

####集成步骤
通过JSPatch平台。

- 创建App，获得AppKey
- 下载SDK并导入到项目
- 设置App Transport Security Settings
- 添加依赖框架：`libz.dylib`和`JavaScriptCore.framework`
- 添加代码：

```
    [JSPatch startWithAppKey:@"c08857f72a4e5f7b"];
    [JSPatch sync]; //检查更新
```

####如何使用
在 JSPatch 平台的规范里，JS脚本的文件名必须是 `main.js`。
直接在main.js中添加JavaScript代码！
详细使用请见`Github Wiki`

####测试
- 在项目中添加`main.js`文件
- 添加代码
- `didFinishLaunchingWithOptions`添加一行：

```
[JSPatch testScriptInBundle];
```
- Run!

####在平台中添加JS脚本
1. 在创建的应用中添加版本
2. 在添加的版本中上传`main.js`
上传后，对应版本的App会请求下载此 脚本并保存在本地，以后App每次启动都会执行。
亲测第一次并不会执行！！！

####部署安全策略
使用 JSPatch 有两个安全问题：

- 传输安全：JS 脚本可以调用任意 OC 方法，权限非常大，若被中间人攻击替换代码，会造成较大的危害。
- 执行安全：下发的 JS 脚本灵活度大，相当于一次小型更新，若未进行充分测试，可能会出现 crash 等情况对 APP 稳定性造成影响。

针对传输安全问题，作者的建议是对下发的JS代码进行RSA校验，而执行安全，除了在发布JS脚本之前做好周全测试之外，还需要建立回退机制，实现方式是后台下发命令，让 APP 在下次启动时不执行 JSPatch 脚本即可。但这里能回退的前提是 APP 可以接收到后台下发的回退命令，若因为下发的脚本导致 APP 启动即时 crash，这个回退命令也会接收不到。所以建议再加一层防启动 crash 的机制，APP 在连续启动即 crash 后，下次启动不再执行脚本文件。

####Swift项目中使用JSPatch
使用 `defineClass()` 覆盖 Swift 类时，类名应为 `项目名.原类名`:

```
defineClass('demo.ViewController', {})
```
需要注意的是：
1. 只支持调用继承自 NSObject 的 Swift 类；
2. 继承自 NSObject 的 Swift 类，其继承自父类的方法和属性可以在 JS 调用，其他自定义方法和属性同样需要加 dynamic 关键字才行；
3. 若方法的参数/属性类型为 Swift 特有的(如 Character / Tuple)，则此方法和属性无法通过 JS 调用。

####不会JavaScript?
[JSPatch Convertor](http://bang590.github.io/JSPatchConvertor/)

---
参考：

[JSPatch平台](http://jspatch.com)

[Github Wiki](https://github.com/bang590/JSPatch/wiki)



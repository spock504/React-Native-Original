<!--
 * @Author: liujian
 * @Date: 2021-04-29 18:01:28
 * @Description: file content
 * @LastEditors: liujian
 * @LastEditTime: 2021-05-10 10:32:23
-->
RN与原生通讯
学习链接：https://www.jianshu.com/p/e413e84cd28b

React-Native 版本：`0.63.2`
示例代码：`App.js`

### Android
1. **RN调用安卓代码**
    - 新建一个类MyReactPackage继承ReactContextBaseJavaModule，实现getName方法，实现类的构造方法，创建暴露给RN调用的方法（要用注释符号@ReactMethod修饰。）
    - 实现接口ReactPackage包管理器，添加到ReactPackage列表里
    - 在RN代码中用`NativeModules`组件去调用原生模块  
  
2. **RN用消息机制方式与安卓原生代码切换**
<!-- Android Studio中，右键创建一个Activity -->
Activity是android系统的最小调度单位，而Intent则是安卓的进程之间、activity之间、线程之间交换数据的载体。
`Intent intent = new Intent(mContext,MyActivity.class);  //创建一个意图，意图是android进程之间、线程之间、交换数据的载体`  

3. **RN用Promise机制与安卓原生代码通信**
   在原生代码的MyNativeModule文件中创建桥接方法。当桥接的原生方法的最后一个参数是一个Promise对象，那么该方法会返回一个JS的Promise对象给与之对应的js方法。  
   
4. **RN用callback回调方式与安卓原生代码通信**
   参数传入一个成功的回调和一个失败的回调。


### IOS
新建 `CalendarManager.m` 和 `CalendarManager.h` 文件，`.h` 文件。
- callback 回调
  - 在`.m`文件中创建 `createCalendarEventCallback`方法，用于RN端调用，并且通过`callback`原生回调RN端。
- promise回调
  - 在`.m`文件中创建 `createCalendarEvent`方法，用于RN端调用，并且通过`promise`原生回调RN端。

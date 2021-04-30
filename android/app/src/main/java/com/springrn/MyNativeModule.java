package com.springrn;

import android.content.Intent;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.uimanager.IllegalViewOperationException;

public class MyNativeModule extends ReactContextBaseJavaModule {
    // 创建一个上下文，放到构造函数中，得到reactContext
    private ReactApplicationContext mContext;

    @NonNull
    @Override
    public String getName() {
        // RN代码要通过名字来调用该类的方法
        return "ToastModule";
    }

    public MyNativeModule(ReactApplicationContext reactContext) {
        super(reactContext);
        mContext = reactContext;
    }

    //方法不能返回值 因为被调用的原生代码是异步的 原生代码执行结束之后只能通过回调函数或者发送消息给RN
    @ReactMethod
    public void rnCallNative(String msg) {
        Toast.makeText(mContext, msg, Toast.LENGTH_LONG).show();
        // 跳转到新页面
        Intent intent = new Intent(mContext, MyActivity.class);  //创建一个意图，意图是android进程之间、线程之间、交换数据的载体
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);    //一定要加上这句
        mContext.startActivity(intent);
    }

    // promise方法，Promise 放最后
    @ReactMethod
    public void rnCallNativePromise(String msg, Promise promise){
        Toast.makeText(mContext,msg,Toast.LENGTH_SHORT).show();
        //得到组件名称
        String componentName = getCurrentActivity().getComponentName().toString();
        promise.resolve(componentName);
    }


    // callback 方法
    @ReactMethod
    public void measureLayout(Callback errorCallback, Callback successCallback){
        try {
            successCallback.invoke(100,100,200,200); //调用回调函数，返回结果
        }catch (IllegalViewOperationException e){
            errorCallback.invoke(e.getMessage());
        }
    }

}

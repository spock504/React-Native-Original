package com.springrn;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;

public class MyActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my);
    }

    //点击按钮，直接完成  activity_my.xml 中的按钮事件
    public void onBack(View v){
        finish();
    }
}
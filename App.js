/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React from 'react';
import {
  SafeAreaView,
  StyleSheet,
  ScrollView,
  View,
  Text,
  StatusBar,
  NativeModules,
} from 'react-native';

import {
  Header,
  LearnMoreLinks,
  Colors,
  DebugInstructions,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

const App: () => React$Node = () => {

  // 1. Android方法
  const fn = () => {
    NativeModules.ToastModule.rnCallNative("react-native 调用android原生 弹窗提示！");
  }
  const callAndroidPromise = async () => {
    try {
      const rnCall = await NativeModules.ToastModule.rnCallNativePromise('promise调用原生')
      console.log('原生返回信息', rnCall);
    } catch (error) {
      console.log('err', error);
    }
  }

  const callAndroidCallback = () => {
    NativeModules.ToastModule.measureLayout(
      (msg) => {
        console.log(msg);
      },
      (x, y, width, height) => {
        console.log('x坐标:' + x + 'y坐标:' + y + '高:' + height + '宽' + width);
      }
    )
  }

  // 2. IOS方法
  const CalendarManager = NativeModules.CalendarManager;
  const callIosPromise = async () => {
    try {
      const eventId = await CalendarManager.createCalendarEvent(
        'Party',
        'my house'
      );
      console.log(`Created a new event with id ${eventId}`);
    } catch (e) {
      console.error(e);
    }
  }

  const callIosCallback = () => {
    CalendarManager.createCalendarEventCallback(
      'testName',
      {
        location: 'location 详情'
      },
      (error, eventId) => {
        if (error) {
          console.error(`Error found! ${error}`);
        }
        console.log(`event id ${eventId} returned`);
      }
    );
  }

  return (
    <>
      <StatusBar barStyle="dark-content" />
      <SafeAreaView>
        <ScrollView
          contentInsetAdjustmentBehavior="automatic"
          style={styles.scrollView}>
          <Header />
          <View style={styles.body}>

            <View style={styles.sectionContainer}>
              <Text style={styles.sectionTitle}>Android</Text>
              <Text style={styles.sectionDescription} onPress={() => fn()}>RN 调用android原生 </Text>
              <Text style={styles.sectionDescription} onPress={() => callAndroidPromise()}>RN Promise通信 </Text>
              <Text style={styles.sectionDescription} onPress={() => callAndroidCallback()}>RN callback通信 </Text>
            </View>
            <View style={styles.sectionContainer}>
              <Text style={styles.sectionTitle}>IOS</Text>
              <Text style={styles.sectionDescription} onPress={() => callIosPromise()}>RN Promise通信 </Text>
              <Text style={styles.sectionDescription} onPress={() => callIosCallback()}>RN callback通信 </Text>
            </View>
            <LearnMoreLinks />
          </View>
        </ScrollView>
      </SafeAreaView>
    </>
  );
};

const styles = StyleSheet.create({
  scrollView: {
    backgroundColor: Colors.lighter,
  },
  engine: {
    position: 'absolute',
    right: 0,
  },
  box: {
    alignItems: 'center',
    justifyContent: 'flex-start'
  },
  body: {
    backgroundColor: Colors.white,
  },
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
    color: Colors.black,
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
    color: Colors.dark,
  },
  highlight: {
    fontWeight: '700',
  },
  footer: {
    color: Colors.dark,
    fontSize: 12,
    fontWeight: '600',
    padding: 4,
    paddingRight: 12,
    textAlign: 'right',
  },
});

export default App;

//
//  CalendarManager.h
//  springRN
//
//  Created by henry on 2021/5/8.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

// 一个“原生模块”就是一个实现了“RCTBridgeModule”协议的 Objective-C 类
@interface CalendarManager : RCTEventEmitter <RCTBridgeModule>
+ (id)allocWithZone:(NSZone *)zone;
- (void)calendarEventReminderReceived:(NSNotification *)notification;
@end

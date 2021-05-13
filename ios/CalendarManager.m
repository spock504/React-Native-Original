//
//  CalendarManager.m
//  springRN
//
//  Created by henry on 2021/5/8.
//


#import "CalendarManager.h"
#import <React/RCTConvert.h>

#define RNEVENTREMINDER @"EventReminder"

@implementation CalendarManager
{
  bool hasListeners;
}

// 在添加第一个监听函数时触发
-(void)startObserving {
    hasListeners = YES;
    // Set up any upstream listeners or background tasks as necessary
}

// Will be called when this module's last listener is removed, or on dealloc.
-(void)stopObserving {
    hasListeners = NO;
    // Remove upstream listeners, stop unnecessary background tasks
}


//为了实现RCTBridgeModule协议，类需要包含RCT_EXPORT_MODULE()宏
// To export a module named CalendarManager
RCT_EXPORT_MODULE();

// This would name the module AwesomeCalendarManager instead
// RCT_EXPORT_MODULE(AwesomeCalendarManager); 通过RCT_EXPORT_METHOD()宏, 声明要给 JavaScript 导出的方法

// 1. callback 回调 #
RCT_EXPORT_METHOD(createCalendarEventCallback:(NSString *)name details:(NSDictionary *)details callback: (RCTResponseSenderBlock)callback)
{
  NSString *location = [RCTConvert NSString:details[@"location"]];
//  NSNumber *eventId = [NSNumber numberWithInt:123];
  callback(@[[NSNull null], location]);
}

// 2. promise回调 #
RCT_EXPORT_METHOD(createCalendarEvent:(NSString *)title
                 location:(NSString *)location
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
  NSNumber *eventId = @12;       //整型
  if (eventId) {
    resolve(eventId);
  } else {
    reject(@"event_failure", @"没有返回正确的 event id ", nil);
  }
}

// 3. 给 JavaScript 端发送事件#
RCT_EXPORT_METHOD(sendEventReminder:(NSString *)notification)
{
  CalendarManager *manager = [CalendarManager allocWithZone:nil];
  [manager calendarEventReminderReceived:(NSNotification *)notification];
}

//（1）必须使用单例
//（2）必须复写alloczone
+ (id)allocWithZone:(NSZone *)zone {
  static CalendarManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [super allocWithZone:zone];
  });
  return sharedInstance;
}

- (NSArray<NSString *> *)supportedEvents
{
  return @[@"EventReminder"]; // 监听事件名称
}

- (void)calendarEventReminderReceived:(NSNotification *)notification
{
  
  if (hasListeners) { // Only send events if anyone is listening
    [self sendEventWithName:@"EventReminder" body:@{@"name": notification}];
  }
}

@end

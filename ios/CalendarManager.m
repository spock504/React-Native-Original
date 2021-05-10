//
//  CalendarManager.m
//  springRN
//
//  Created by henry on 2021/5/8.
//


#import "CalendarManager.h"
#import <React/RCTConvert.h>


@implementation CalendarManager

//为了实现RCTBridgeModule协议，类需要包含RCT_EXPORT_MODULE()宏
// To export a module named CalendarManager
RCT_EXPORT_MODULE();

// This would name the module AwesomeCalendarManager instead
// RCT_EXPORT_MODULE(AwesomeCalendarManager); 通过RCT_EXPORT_METHOD()宏, 声明要给 JavaScript 导出的方法

// callback 回调
RCT_EXPORT_METHOD(createCalendarEventCallback:(NSString *)name details:(NSDictionary *)details callback: (RCTResponseSenderBlock)callback)
{
  NSString *location = [RCTConvert NSString:details[@"location"]];
  NSNumber *eventId = [NSNumber numberWithInt:123];
  callback(@[[NSNull null], eventId]);
}

// promise回调
RCT_EXPORT_METHOD(createCalendarEvent:(NSString *)title
                 location:(NSString *)location
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
  NSNumber *eventId = @12;       //整型
  if (eventId == nil) {
    resolve(eventId);
  } else {
    reject(@"event_failure", @"没有返回正确的 event id ", nil);
  }
}

@end

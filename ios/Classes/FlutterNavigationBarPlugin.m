#import "FlutterNavigationBarPlugin.h"
#import <flutter_navigation_bar/flutter_navigation_bar-Swift.h>
#import <Flutter/Flutter.h>

@import CoreLocation;

FlutterEventSink eventSinkFirst;

@implementation FlutterNavigationBarPlugin
+(void) registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {

  // Not really used on iOS at this time.
  FirstStreamHandler* firstStreamHandler = [[FirstStreamHandler alloc] init];
  FlutterEventChannel* firstEventChannel = [FlutterEventChannel eventChannelWithName:@"github.com/pontusbredin/flutter_navigation_bar" binaryMessenger:[registrar messenger]];
  [firstEventChannel setStreamHandler:firstStreamHandler];

  [SwiftFlutterNavigationBarPlugin registerWithRegistrar:registrar];

}
@end

@implementation FirstStreamHandler
- (FlutterError*)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)eventSink {
    eventSinkFirst = eventSink;
  return nil;
}

- (FlutterError*)onCancelWithArguments:(id)arguments {
    eventSinkFirst = nil;
  return nil;
}
@end
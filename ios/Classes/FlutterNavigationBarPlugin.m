#import "FlutterNavigationBarPlugin.h"
#import <flutter_navigation_bar/flutter_navigation_bar-Swift.h>

@implementation FlutterNavigationBarPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterNavigationBarPlugin registerWithRegistrar:registrar];
}
@end

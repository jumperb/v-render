#import "VrenderPlugin.h"
#if __has_include(<vrender/vrender-Swift.h>)
#import <vrender/vrender-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "vrender-Swift.h"
#endif

@implementation VrenderPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftVrenderPlugin registerWithRegistrar:registrar];
}
@end

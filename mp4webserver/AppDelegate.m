#import "AppDelegate.h"

#import "VideoViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    VideoViewController *vc = [[VideoViewController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end

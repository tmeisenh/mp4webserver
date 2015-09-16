#import "AppDelegate.h"

#import "VideoViewController.h"

@interface AppDelegate ()

@property (nonatomic) Server *server;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
    VideoViewController *vc = [[VideoViewController alloc] init];
    
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end

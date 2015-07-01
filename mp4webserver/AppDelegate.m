#import "AppDelegate.h"

#import "VideoViewController.h"

#import "Server.h"

@interface AppDelegate ()

@property (nonatomic) Server *server;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.server = [[Server alloc] init];
    
    VideoViewController *vc = [[VideoViewController alloc] initWithServer:self.server];
    
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end

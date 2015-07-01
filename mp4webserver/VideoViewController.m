#import "VideoViewController.h"

#import "Server.h"

#define MAS_SHORTHAND
#import <Masonry/Masonry.h>
#import <MediaPlayer/MPMoviePlayerViewController.h>

@interface VideoViewController()

@property (nonatomic) Server *server;

@end

@implementation VideoViewController

- (instancetype)initWithServer:(Server *)server {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _server = server;
    }
    return self;
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    UIButton *launch = [[UIButton alloc] initWithFrame:CGRectZero];
    
    launch.tintColor = [UIColor redColor];
    launch.backgroundColor = [UIColor purpleColor];
    [launch setTitle:@"Serve Movie Up!!" forState:UIControlStateNormal];
    launch.layer.cornerRadius = 5.0f;
    
    [launch addTarget:self
               action:@selector(launchPlayer)
     forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:launch];
    
    [launch makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@200);
        make.height.equalTo(@50);
        make.centerX.equalTo(self.view.centerX);
        make.centerY.equalTo(self.view.centerY);
    }];
}

- (void)launchPlayer {
    [self.server serveFile];
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8080/playlist/"];
    MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    
    [self presentMoviePlayerViewControllerAnimated:player];
}

@end

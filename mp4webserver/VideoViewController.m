#import "VideoViewController.h"

#define MAS_SHORTHAND
#import <Masonry/Masonry.h>
#import <MediaPlayer/MPMoviePlayerViewController.h>

@interface VideoViewController()

@property (nonatomic) MPMoviePlayerViewController *movieController;

@end

@implementation VideoViewController

- (void)didReceiveMemoryWarning {
    NSLog(@"OK Great");
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (void)handleNotification:(NSNotification *)notification {
    NSLog(@"received notification: %@", notification.name);
}

- (void)launchPlayer {
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8000/playlist.m3u8"];
    self.movieController = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [self presentMoviePlayerViewControllerAnimated:self.movieController];
}

@end

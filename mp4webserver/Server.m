#import "Server.h"

#import "SegmentedFile.h"
#import <GCDWebServer/GCDWebServer.h>
#import <GCDWebServer/GCDWebServerDataRequest.h>
#import <GCDWebServer/GCDWebServerDataResponse.h>

@interface Server()

@property (nonatomic) SegmentedFile *segmentedFile;
@property (nonatomic) GCDWebServer *server;

@end

@implementation Server

- (instancetype)init {
    self = [super init];
    if (self) {
        _segmentedFile = [[SegmentedFile alloc] init];
        _server = [[GCDWebServer alloc] init];
    }
    
    return self;
}

- (void)serveFile {
    if ([self.server isRunning]) {
        [self.server stop];
    }
    __weak typeof(self) weakSelf = self;
    
    /* Note, when running on the simulator you can test these end points on your browser. */
    
    [self.server addHandlerForMethod:@"GET"
                                path:@"/test"
                        requestClass:[GCDWebServerRequest class]
                        processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
                            
                            return [GCDWebServerDataResponse responseWithHTML:@"<html><body><p>Hello World</p></body></html>"];
                            
                        }];
    
    [self.server addHandlerForMethod:@"GET"
                           pathRegex:@"/playlist/*"
                        requestClass:[GCDWebServerRequest class]
                   asyncProcessBlock:^(GCDWebServerRequest *request, GCDWebServerCompletionBlock completionBlock) {
                       
                       
                       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                           NSLog(@"Requesting playlist");
                           NSData *playlistData = [NSData dataWithContentsOfURL:[weakSelf.segmentedFile m3u8]];
                           
                           GCDWebServerDataResponse *response = [[GCDWebServerDataResponse alloc] initWithData:playlistData
                                                                                                   contentType:@"application/x-mpegURL"];
                           completionBlock(response);
                       });
                   }];
    
    [self.server addHandlerForMethod:@"GET"
                           pathRegex:@"/mp4*"
                        requestClass:[GCDWebServerRequest class]
                   asyncProcessBlock:^(GCDWebServerRequest *request, GCDWebServerCompletionBlock completionBlock) {
                       
                       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                           NSString *requestedSegmentId = [request.path lastPathComponent];
                           NSLog(@"Requesting segment %@", requestedSegmentId);
                           NSURL *segmentUrl = [weakSelf.segmentedFile segmentUrls][requestedSegmentId];
                           NSData *segmentData = [NSData dataWithContentsOfURL:segmentUrl];
                           GCDWebServerDataResponse *response = [[GCDWebServerDataResponse alloc] initWithData:segmentData
                                                                                                   contentType:@"video/MP2T"];
                           completionBlock(response);
                       });
                       
                   }];
    
    NSDictionary *serverOptions = @{
                                    GCDWebServerOption_Port : @8080,
                                    GCDWebServerOption_MaxPendingConnections : @10,
                                    GCDWebServerOption_AutomaticallySuspendInBackground : @YES
                                    };
    
    [self.server startWithOptions:serverOptions error:nil];
}


@end

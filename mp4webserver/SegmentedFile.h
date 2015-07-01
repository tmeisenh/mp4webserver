#import <Foundation/Foundation.h>

@interface SegmentedFile : NSObject

- (NSURL *)m3u8;
- (NSDictionary *)segmentUrls;

@end

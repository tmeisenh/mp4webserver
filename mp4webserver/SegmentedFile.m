#import "SegmentedFile.h"

@implementation SegmentedFile

- (NSURL *)m3u8 {
    return [[NSBundle mainBundle] URLForResource:@"playlist" withExtension:@"m3u8"];
}

- (NSDictionary *)segmentUrls {
    
    return @{
             @"000000.ts" : [[NSBundle mainBundle] URLForResource:@"000000" withExtension:@"ts"],
             @"000001.ts" : [[NSBundle mainBundle] URLForResource:@"000001" withExtension:@"ts"],
             @"000002.ts" : [[NSBundle mainBundle] URLForResource:@"000002" withExtension:@"ts"]
             };
}

@end

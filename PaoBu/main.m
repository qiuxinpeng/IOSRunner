#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        @try{
//            NSString *key = @"abcdefgh";
//            NSString *input = @"a";
//            NSString *cryptText = [[[DES alloc] init] encryptUseDES:input key:key];
//            NSLog(@"%@", cryptText);
//            NSLog(@"%@", [[[DES alloc] init] decryptUseDES:cryptText key:key]);
            
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
        @catch(NSException *exception) {
            NSLog(@"exception:%@", exception);
        }
        @finally {
            
        }
    }
}

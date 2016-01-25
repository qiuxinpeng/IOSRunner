//
//  PassValueDelegate.h
//  PaoBu
//
//  Created by Apple on 16/1/22.
//  Copyright © 2016年 LunSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PassValueDelegate <NSObject>

- (void) passValue:(NSString *)value;
@end
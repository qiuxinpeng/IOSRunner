//
//  NSObject+Units.m
//  DOOCT_IPhone
//
//  Created by 邱新鹏 on 13-7-10.
//  Copyright (c) 2013年 DCT. All rights reserved.
//

#import "NSObject+Units.h"

@implementation NSObject (Units)
- (NSString *)turnString{

    if ([self isKindOfClass:[NSNumber class]]) {
    }
    return [NSString stringWithFormat:@"%@",self];
}
@end

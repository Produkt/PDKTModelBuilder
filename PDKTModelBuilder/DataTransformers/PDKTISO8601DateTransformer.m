//
//  PDKTISO8601DateTransformer.m
//  PDKTModelBuilder
//
//  Created by sergio on 01/03/16.
//  Copyright © 2016 Produkt. All rights reserved.
//

#import "PDKTISO8601DateTransformer.h"

@implementation PDKTISO8601DateTransformer

- (id)tranformValueFromObject:(id)object {
    // Returns a NSDate object that corresponds to the specified RFC 3339 date time string.
    
    if (!object || [object isEqual:[NSNull null]]) {
        return nil;
    }
    NSString *objectDescription = [NSString stringWithFormat:@"%@", object];
    NSDate *date = nil;
    NSCharacterSet *alphaNumbersSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:objectDescription];
    if ([alphaNumbersSet isSupersetOfSet:stringSet]) {
        date = [NSDate dateWithTimeIntervalSince1970:[objectDescription integerValue]];
    } else {
        static dispatch_once_t onceToken;
        static NSDateFormatter *entityPropertyDateFormatter;
        dispatch_once(&onceToken, ^{
            entityPropertyDateFormatter = [[NSDateFormatter alloc] init];
            entityPropertyDateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            [entityPropertyDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        });
        date = [entityPropertyDateFormatter dateFromString:objectDescription];
    }
    return date;
}

@end

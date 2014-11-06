//
//  EntityPropertyURL.m
//  PDKTModelBuilder
//
//  Created by Javier Soto on 03/01/12.
//  Copyright (c) 2012 , Inc. All rights reserved.
//

#import "PDKTURLTransformer.h"

@implementation PDKTURLTransformer

- (id)tranformValueFromObject:(id)object
{
    if ([object isKindOfClass:[NSURL class]]) {
        return [object copy];
    }else if ([object isKindOfClass:[NSString class]]){
        NSString *urlString = [object stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        return [self isValidURLString:urlString] ? [NSURL URLWithString:urlString] : nil;
    }
    return nil;
}

- (BOOL)isValidURLString:(NSString *)urlString{
    NSString *urlRegEx = @"((http|https)://)?(([A-Za-z0-9-_+]+)[.])?([A-Za-z0-9-_+]+)[.]([A-Za-z0-9-_+]+)(/([A-Za-z0-9-_])*)*([?](&?[A-Za-z0-9-_]+=[A-Za-z0-9-_]+)+)?(#[A-Za-z0-9-_]+)?";
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSTextCheckingResult *match = [regex firstMatchInString:urlString options:0 range:NSMakeRange(0, [urlString length])];
    return match!=nil ? YES : NO;
}

@end

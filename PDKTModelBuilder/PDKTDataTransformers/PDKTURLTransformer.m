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
    NSString *urlRegEx = @"((http|https)://)?((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    BOOL validURL = [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx] evaluateWithObject:urlString];
    return validURL;
}

@end

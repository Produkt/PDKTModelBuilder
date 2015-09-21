//
//  PictureEntity+PDKTModelBuilderEntity.m
//  PDKTModelBuilder
//
//  Created by Daniel García García on 11/11/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "PictureEntity+PDKTModelBuilderEntity.h"
#import "PDKTDataTransformers.h"

@implementation PictureEntity (PDKTModelBuilderEntity)
+ (NSString *)entityName {
    return @"PictureEntity";
}
+ (NSDictionary *)propertiesBindings{
    return @{
             @"pictureId":@"id",
             @"picturePublishedDate":@"published_on",
             @"pictureURL":@"url"
             };
}
+ (NSDictionary *)propertiesTypeTransformers{
    return @{
             @"picturePublishedDate":[PDKTDateTransformer new],
             @"pictureURL":[PDKTURLTransformer new]
             };
}
+ (NSString *)entityIdPropertyName {
    return @"pictureId";
}
@end

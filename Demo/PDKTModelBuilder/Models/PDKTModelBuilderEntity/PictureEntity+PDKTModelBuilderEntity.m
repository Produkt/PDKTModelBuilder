//
//  PictureEntity+PDKTModelBuilderEntity.m
//  PDKTModelBuilder
//
//  Created by Daniel García García on 11/11/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "PictureEntity+PDKTModelBuilderEntity.h"
#import "PDKTDataTransformers.h"
#import "UserEntity.h"

@implementation PictureEntity (PDKTModelBuilderEntity)
+ (NSString *)entityName {
    return @"PictureEntity";
}
+ (NSDictionary *)propertiesBindings{
    return @{
             @"pictureId":@"id",
             @"picturePublishedDate":@"published_on",
             @"pictureURL":@"url",
             @"pictureModificationDateUnixTimestamp": @"updated_at"
             };
}
+ (NSDictionary *)propertiesTypeTransformers{
    return @{
             @"picturePublishedDate":[PDKTDateTransformer new],
             @"pictureURL":[PDKTURLTransformer new],
             @"pictureModificationDateUnixTimestamp": [PDKTIntegerTransformer new]
             };
}
+ (NSString *)entityIdPropertyName {
    return @"pictureId";
}
+ (NSDictionary *)relationshipsBindings{
    return @{
             @"author": [PDKTCoreDataEntityRelationship oneToOneRelationshipForKeyPath:@"author" andClass:[UserEntity class]]
             };
}
+ (NSString *)comparableAttribute {
    return @"pictureModificationDateUnixTimestamp";
}
@end

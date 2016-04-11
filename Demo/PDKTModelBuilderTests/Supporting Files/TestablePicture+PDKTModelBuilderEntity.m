//
//  TestablePicture+PDKTModelBuilderEntity.m
//  PDKTModelBuilder
//
//  Created by Daniel García on 31/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "TestablePicture+PDKTModelBuilderEntity.h"
#import "PDKTDataTransformers.h"

@implementation TestablePicture (PDKTModelBuilderEntity)
+ (NSDictionary *)propertiesBindings{
    return @{
             @"pictureId":@"id",
             @"pictureURL":@"url",
             @"pictureRating":@"rating",
             @"picturePublishedDate":@"published_on"
             };
}
+ (NSDictionary *)propertiesTypeTransformers{
    return @{
             @"pictureURL":[PDKTURLTransformer new],
             @"pictureRating":[PDKTFloatTransformer new],
             @"picturePublishedDate":[PDKTDateTransformer new]
             };
}
+ (NSString *)entityName {
    return @"TestablePicture";
}
+ (NSString *)entityIdPropertyName {
    return @"pictureId";
}
@end

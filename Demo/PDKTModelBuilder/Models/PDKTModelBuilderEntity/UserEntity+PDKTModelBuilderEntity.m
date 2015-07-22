//
//  UserEntity+PDKTModelBuilderEntity.m
//  PDKTModelBuilder
//
//  Created by Daniel García García on 11/11/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "UserEntity+PDKTModelBuilderEntity.h"
#import "PDKTDataTransformer.h"
#import "PictureEntity.h"

@implementation UserEntity (PDKTModelBuilderEntity)
+ (NSDictionary *)propertiesBindings{
    return @{
             @"userId":@"id",
             @"userName":@"name",
             @"userEmail":@"email",
             @"userBlogURL":@"blog_url",
             @"entityUpdateUnixTimestamp": @"updated_at"
             };
}
+ (NSDictionary *)propertiesTypeTransformers{
    return @{
             @"userBlogURL":[PDKTURLTransformer new],
             @"entityUpdateUnixTimestamp": [PDKTIntegerTransformer new]
             };
}
+ (NSDictionary *)relationshipsBindings{
    return @{
             @"hasPictures":[PDKTCoreDataEntityRelationship oneToManyRelationshipForKeyPath:@"pictures" andClass:[PictureEntity class]]
             };
}
+ (NSString *)comparableUnixTimestampAttribute {
    return @"entityUpdateUnixTimestamp";
}
+ (NSDictionary *)customDataDictionaryWithSourceDataDictionary:(NSDictionary *)dictionary{
    NSMutableDictionary *dataDictionary = [dictionary mutableCopy];
    
    // Some API endpoints returns blog information as a blog entity.
    // We can hotfix the dataDictionary so it can be parsed using the same propertiesBindings
    if ([dictionary valueForKey:@"Blog"] && [dictionary valueForKeyPath:@"Blog.url"]) {
        [dataDictionary setValue:[dictionary valueForKeyPath:@"Blog.url"] forKey:@"blog_url"];
    }
    
    // We can also hotfix a relationships
    if ([dictionary valueForKey:@"user_pictures"]) {
        [dataDictionary setValue:[dictionary valueForKey:@"user_pictures"] forKey:@"pictures"];
    }
    
    return dataDictionary;
}
@end

//
//  UserEntity.h
//  PDKTModelBuilder
//
//  Created by Daniel García García on 11/11/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PictureEntity;

@interface UserEntity : NSManagedObject

@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * userEmail;
@property (nonatomic, retain) id userBlogURL;
@property (nonatomic, retain) NSSet *hasPictures;
@end

@interface UserEntity (CoreDataGeneratedAccessors)

- (void)addHasPicturesObject:(PictureEntity *)value;
- (void)removeHasPicturesObject:(PictureEntity *)value;
- (void)addHasPictures:(NSSet *)values;
- (void)removeHasPictures:(NSSet *)values;

@end

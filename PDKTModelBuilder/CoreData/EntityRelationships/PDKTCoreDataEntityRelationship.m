//
//  PDKTEntityRelationship.m
//  PDKTModelBuilder
//
//  Created by Daniel García García on 06/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "PDKTCoreDataEntityRelationship.h"
#import "__PDKTCoreDataEntityRelationshipOneToOne.h"
#import "__PDKTCoreDataEntityRelationshipOneToMany.h"

@interface PDKTCoreDataEntityRelationship()
@property (copy,nonatomic,readwrite) NSString *keyPath;
@property (assign,nonatomic,readwrite) Class relatedClass;
@end
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation PDKTCoreDataEntityRelationship
- (instancetype)initWithKeyPath:(NSString *)keyPath andClass:(Class)relatedClass{
    self = [super init];
    if (self) {
        _keyPath = [keyPath copy];
        _relatedClass = relatedClass;
    }
    return self;
}
+ (instancetype)oneToOneRelationshipForKeyPath:(NSString *)keyPath andClass:(Class)relatedClass{
    return [[__PDKTCoreDataEntityRelationshipOneToOne alloc] initWithKeyPath:keyPath andClass:relatedClass];
}
+ (instancetype)oneToManyRelationshipForKeyPath:(NSString *)keyPath andClass:(Class)relatedClass{
    return [[__PDKTCoreDataEntityRelationshipOneToMany alloc] initWithKeyPath:keyPath andClass:relatedClass];
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"\n\n*** '%@' selector must be implemented by the subclass %@ ***\n\n",NSStringFromSelector(aSelector),NSStringFromClass([self class]));
    [self doesNotRecognizeSelector:aSelector];
    return nil;
}
@end

//
//  PDKTEntityRelationship.m
//  PDKTModelBuilder
//
//  Created by Daniel García García on 06/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import "PDKTEntityRelationship.h"
#import "__PDKTEntityRelationshipOneToOne.h"
#import "__PDKTEntityRelationshipOneToMany.h"

@interface PDKTEntityRelationship()
@property (copy,nonatomic,readwrite) NSString *keyPath;
@property (assign,nonatomic,readwrite) Class relatedClass;
@end
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation PDKTEntityRelationship
- (instancetype)initWithKeyPath:(NSString *)keyPath andClass:(Class)relatedClass{
    self = [super init];
    if (self) {
        _keyPath = [keyPath copy];
        _relatedClass = relatedClass;
    }
    return self;
}
+ (instancetype)oneToOneRelationshipForKeyPath:(NSString *)keyPath andClass:(Class)relatedClass{
    return [[__PDKTEntityRelationshipOneToOne alloc] initWithKeyPath:keyPath andClass:relatedClass];
}
+ (instancetype)oneToManyRelationshipForKeyPath:(NSString *)keyPath andClass:(Class)relatedClass{
    return [[__PDKTEntityRelationshipOneToMany alloc] initWithKeyPath:keyPath andClass:relatedClass];
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"\n\n*** '%@' selector must be implemented by the subclass %@ ***\n\n",NSStringFromSelector(aSelector),NSStringFromClass([self class]));
    [self doesNotRecognizeSelector:aSelector];
    return nil;
}
@end

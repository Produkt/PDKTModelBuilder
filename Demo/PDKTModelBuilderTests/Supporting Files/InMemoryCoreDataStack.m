//
//  InMemoryCoreDataStack.m
//
//  Created by Daniel García on 13/05/14.
//  Copyright (c) 2014 Produkt All rights reserved.
//

#import "InMemoryCoreDataStack.h"
@interface InMemoryCoreDataStack()
@property (copy,nonatomic) NSString *modelName;
@property (strong,nonatomic,readwrite) NSManagedObjectContext *managedObjectContext;
@property (strong,nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong,nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end
@implementation InMemoryCoreDataStack
- (instancetype)initWithModelName:(NSString *)modelName
{
    NSParameterAssert(modelName);
    self = [super init];
    if (self) {
        _modelName = [modelName copy];
    }
    return self;
}
- (instancetype)init
{
    return [self initWithModelName:nil];
}
- (NSManagedObjectContext *)managedObjectContext{
    if (!_managedObjectContext) {
        _managedObjectContext=[[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    }
    return _managedObjectContext;
}
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (!_persistentStoreCoordinator) {
        NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        NSDictionary *options=[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        NSError *error;
        [persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:options error:&error];
        _persistentStoreCoordinator=persistentStoreCoordinator;
        if (error) {
            NSLog(@"%@",error);
        }
    }
    return _persistentStoreCoordinator;
}
- (NSManagedObjectModel *)managedObjectModel{
    if (!_managedObjectModel) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:self.modelName withExtension:@"momd"];
        _managedObjectModel=[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}
@end

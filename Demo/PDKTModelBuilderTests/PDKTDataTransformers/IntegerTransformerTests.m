//
//  IntegerTransformerTests.m
//  PDKTModelBuilder
//
//  Created by Daniel García on 31/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PDKTIntegerTransformer.h"

@interface IntegerTransformerTests : XCTestCase
@property (strong,nonatomic) PDKTIntegerTransformer *integerTransformer;
@end

@implementation IntegerTransformerTests

- (void)setUp {
    [super setUp];
    self.integerTransformer = [PDKTIntegerTransformer new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testReturnsAnInteger {
    XCTAssert([[self.integerTransformer tranformValueFromObject:@"10"] isKindOfClass:NSClassFromString(@"__NSCFNumber")]);
}

- (void)testDoubleFromString {
    NSNumber *number = [self.integerTransformer tranformValueFromObject:@"10"];
    XCTAssertEqual([number integerValue], 10);
}


@end

//
//  FloatTransformerTests.m
//  PDKTModelBuilder
//
//  Created by Daniel García on 31/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PDKTFloatTransformer.h"

@interface FloatTransformerTests : XCTestCase
@property (strong,nonatomic) PDKTFloatTransformer *floatTransformer;
@end

@implementation FloatTransformerTests

- (void)setUp {
    [super setUp];
    self.floatTransformer = [PDKTFloatTransformer new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testReturnsAFloat {
    XCTAssert([[self.floatTransformer tranformValueFromObject:@"0.5"] isKindOfClass:NSClassFromString(@"__NSCFNumber")]);
}

- (void)testDoubleFromString {
    NSNumber *number = [self.floatTransformer tranformValueFromObject:@"0.5"];
    XCTAssertEqual([number floatValue], 0.5);
}

@end

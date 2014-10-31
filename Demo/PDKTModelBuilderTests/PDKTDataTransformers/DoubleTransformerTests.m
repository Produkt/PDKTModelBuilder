//
//  DoubleTransformerTests.m
//  PDKTModelBuilder
//
//  Created by Daniel García on 31/10/14.
//  Copyright (c) 2014 Produkt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PDKTDoubleTransformer.h"

@interface DoubleTransformerTests : XCTestCase
@property (strong,nonatomic) PDKTDoubleTransformer *doubleTransformer;
@end

@implementation DoubleTransformerTests

- (void)setUp {
    [super setUp];
    self.doubleTransformer = [PDKTDoubleTransformer new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testReturnsADouble {
    XCTAssert([[self.doubleTransformer tranformValueFromObject:@"0.5"] isKindOfClass:NSClassFromString(@"__NSCFNumber")]);
}

- (void)testDoubleFromString {
    NSNumber *number = [self.doubleTransformer tranformValueFromObject:@"0.5"];
    XCTAssertEqual([number doubleValue], 0.5);
}

@end

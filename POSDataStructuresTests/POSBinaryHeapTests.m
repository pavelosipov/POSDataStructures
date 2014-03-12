//
//  POSBinaryHeapTests.m
//  POSDataStructures
//
//  Created by Pavel Osipov on 07.08.13.
//  Copyright (c) 2013 Pavel Osipov. All rights reserved.
//

#import "POSBinaryHeapTests.h"
#import "POSBinaryHeap.h"

@implementation POSBinaryHeapTests {
    POSBinaryHeap *_ascendingHeap;
    POSBinaryHeap *_descendingHeap;
}

- (void)setUp {
    NSComparator numberComparator = ^(NSNumber *l, NSNumber *r) {
        return [l compare:r];
    };
    _ascendingHeap = [[POSBinaryHeap alloc] initWithOrderingType:POSBinaryHeapOrderingAscending
                                                      comparator:numberComparator];
    _descendingHeap = [[POSBinaryHeap alloc] initWithOrderingType:POSBinaryHeapOrderingDescending
                                                       comparator:numberComparator];
}

- (void)tearDown {
    _ascendingHeap = nil;
    _descendingHeap = nil;
}

- (void)testTopObjectAfterAscendingInsertion {
    [_ascendingHeap  addObjectsFromArray:@[@-4, @-3, @-2, @-1, @0, @1, @2, @3, @4]];
    [_descendingHeap addObjectsFromArray:@[@-4, @-3, @-2, @-1, @0, @1, @2, @3, @4]];
    STAssertEqualObjects([_ascendingHeap  topObject], @-4, @"-4 is the smallest number so it should be on top.");
    STAssertEqualObjects([_descendingHeap topObject], @4,  @"4 is the biggest number so it should be on top.");
    STAssertTrue(_ascendingHeap.count == 9, @"9 objects were inserted.");
    STAssertTrue(_descendingHeap.count == 9, @"9 objects were inserted.");
}

- (void)testTopObjectAfterDescendingInsertion {
    [_ascendingHeap  addObjectsFromArray:@[@4, @3, @2, @1, @0, @-1, @-2, @-3, @-4]];
    [_descendingHeap addObjectsFromArray:@[@4, @3, @2, @1, @0, @-1, @-2, @-3, @-4]];
    STAssertEqualObjects([_ascendingHeap  topObject], @-4, @"-4 is the smallest number so it should be on top.");
    STAssertEqualObjects([_descendingHeap topObject], @4,  @"4 is the biggest number so it should be on top.");
    STAssertTrue(_ascendingHeap.count == 9, @"9 objects were inserted.");
    STAssertTrue(_descendingHeap.count == 9, @"9 objects were inserted.");
}

- (void)testTopObjectOfEmptyHeap {
    STAssertNil([_ascendingHeap  topObject], @"Top of the empty heap should return nil.");
    STAssertNil([_descendingHeap topObject], @"Top of the empty heap should return nil.");
}

- (void)testRemoveTopObject {
    [_ascendingHeap  addObjectsFromArray:@[@9, @0, @8, @1, @7, @2, @6, @3, @5, @4]];
    [_descendingHeap addObjectsFromArray:@[@9, @0, @8, @1, @7, @2, @6, @3, @5, @4]];
    [_ascendingHeap  removeTopObject];
    [_descendingHeap removeTopObject];
    STAssertEqualObjects([_ascendingHeap  topObject], @1, @"1 is the next smallest number after 0.");
    STAssertEqualObjects([_descendingHeap topObject], @8, @"8 is the biggest number after 9.");
}

- (void)testRemoveDuplicatedTopObject {
    [_ascendingHeap  addObjectsFromArray:@[@9, @0, @8, @1, @7, @2, @6, @3, @0, @4]];
    [_descendingHeap addObjectsFromArray:@[@9, @0, @8, @1, @7, @2, @6, @3, @5, @9]];
    [_ascendingHeap  removeTopObject];
    [_descendingHeap removeTopObject];
    STAssertEqualObjects([_ascendingHeap  topObject], @0, @"2nd 0 is the next smallest number after removed 0.");
    STAssertEqualObjects([_descendingHeap topObject], @9, @"2nd 9 is the biggest number after removed 9.");
}

- (void)testRemoveTopObjectOfEmptyHeap {
    STAssertNoThrow([_ascendingHeap  removeTopObject], @"If the heap is empty, the method has no effect.");
    STAssertNoThrow([_descendingHeap removeTopObject], @"If the heap is empty, the method has no effect.");
}

- (void)testRemoveTopObjectOfHeapWithOneElement {
    [_ascendingHeap addObject:@0];
    STAssertNoThrow([_ascendingHeap removeTopObject], @"If the heap is empty, the method has no effect.");
    STAssertNil([_ascendingHeap topObject], @"Should return nil for empty heap.");
}

- (void)testPopTopObject {
    [_ascendingHeap  addObjectsFromArray:@[@9, @0, @8, @1, @7, @2, @6, @3, @5, @4]];
    [_descendingHeap addObjectsFromArray:@[@9, @0, @8, @1, @7, @2, @6, @3, @5, @4]];
    NSNumber *smallestNumber = [_ascendingHeap popTopObject];
    STAssertEqualObjects(smallestNumber, @0, @"0 is a smallest number in initial array.");
    STAssertEqualObjects([_ascendingHeap  topObject], @1, @"1 is the next smallest number after 0.");
    NSNumber *biggestNumber = [_descendingHeap popTopObject];
    STAssertEqualObjects(biggestNumber, @9, @"9 is a biggest number in initial array.");
    STAssertEqualObjects([_descendingHeap topObject], @8, @"8 is the biggest number after 9.");
}

- (void)testPopTopObjectOfEmptyHeap {
    STAssertNil([_ascendingHeap  popTopObject], @"Should return nil for empty heap.");
    STAssertNil([_descendingHeap popTopObject], @"Should return nil for empty heap.");
}

- (void)testRemoveAllObjects {
    [_ascendingHeap  addObjectsFromArray:@[@9, @0, @8, @1, @7, @2, @6, @3, @5, @4]];
    [_descendingHeap addObjectsFromArray:@[@9, @0, @8, @1, @7, @2, @6, @3, @5, @4]];
    [_ascendingHeap  removeAllObjects];
    [_descendingHeap removeAllObjects];
    STAssertNil([_ascendingHeap  topObject], @"Should return nil for empty heap.");
    STAssertNil([_descendingHeap topObject], @"Should return nil for empty heap.");
}

- (void)testRemoveAllObjectsOfEmptyHeap {
    [_ascendingHeap  removeAllObjects];
    [_descendingHeap removeAllObjects];
    STAssertNil([_ascendingHeap  topObject], @"Should return nil for empty heap.");
    STAssertNil([_descendingHeap topObject], @"Should return nil for empty heap.");
}

- (void)testRemoveObject {
    NSNumber *smallest = @0;
    NSNumber *biggest = @9;
    [_ascendingHeap  addObjectsFromArray:@[@9, smallest, @8, @1, @7, @2, @6, @3, @5, @4]];
    [_descendingHeap addObjectsFromArray:@[biggest, @0, @8, @1, @7, @2, @6, @3, @5, @4]];
    STAssertEqualObjects([_ascendingHeap topObject], smallest, @"Assume smallest object is on top.");
    STAssertEqualObjects([_descendingHeap topObject], biggest, @"Assume biggest object is on top.");
    [_ascendingHeap removeObject:smallest];
    [_descendingHeap removeObject:biggest];
    STAssertEqualObjects([_ascendingHeap topObject], @1, @"1 is the next smallest number after 0.");
    STAssertEqualObjects([_descendingHeap topObject], @8, @"8 is the biggest number after 9.");
}

- (void)testRemoveObjectOfEmptyHeap {
    NSNumber *n = @0;
    STAssertNoThrow([_ascendingHeap removeObject:n], @"If the heap is empty, the method has no effect.");
    STAssertNoThrow([_descendingHeap removeObject:n], @"If the heap is empty, the method has no effect.");
}

- (void)testRemoveObjectShouldBeBasedOnObjectsEquality {
    [_ascendingHeap addObject:@"abc"];
    NSMutableString *equalObject = [NSMutableString stringWithString:@"abc"];
    STAssertEqualObjects([_ascendingHeap topObject], equalObject, @"Test precondition: top object is equal to removing object.");
    [_ascendingHeap removeObject:equalObject];
    STAssertNil([_ascendingHeap topObject], @"Equal object should be removed.");
}

- (void)testRemoveObjectIdenticalToShouldBeBasedOnObjectsAddressesEquality {
    [_ascendingHeap addObject:@"abc"];
    NSMutableString *equalObject = [NSMutableString stringWithString:@"abc"];
    STAssertEqualObjects([_ascendingHeap topObject], equalObject, @"Test precondition: top object is equal to removing object.");
    [_ascendingHeap removeObjectIdenticalTo:equalObject];
    STAssertNotNil([_ascendingHeap topObject], @"Equal object should be removed.");
}

- (void)testAscendingHeapSort {
    [_ascendingHeap addObjectsFromArray:@[@9, @8, @7, @6, @5, @4, @3, @2, @1, @0, @0, @1, @2, @3, @4, @5, @6, @7, @8, @9]];
    NSMutableArray *ascendingArray = [NSMutableArray new];
    while ([_ascendingHeap count]) {
        [ascendingArray addObject:[_ascendingHeap popTopObject]];
    }
    const BOOL heapSortIsWorking = [ascendingArray isEqualToArray:@[@0, @0, @1, @1, @2, @2, @3, @3, @4, @4, @5, @5, @6, @6, @7, @7, @8, @8, @9, @9]];
    STAssertTrue(heapSortIsWorking, @"Ascending heap sort is working.");
}

- (void)testDescendingHeapSort {
    [_descendingHeap addObjectsFromArray:@[@9, @8, @7, @6, @5, @4, @3, @2, @1, @0, @0, @1, @2, @3, @4, @5, @6, @7, @8, @9]];
    NSMutableArray *descendingArray = [NSMutableArray new];
    while ([_descendingHeap count]) {
        [descendingArray addObject:[_descendingHeap popTopObject]];
    }
    const BOOL heapSortIsWorking = [descendingArray isEqualToArray:@[@9, @9, @8, @8, @7, @7, @6, @6, @5, @5, @4, @4, @3, @3, @2, @2, @1, @1, @0, @0]];
    STAssertTrue(heapSortIsWorking, @"Descending heap sort is working.");
}

@end

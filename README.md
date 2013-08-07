<h1>Data Structures Collection

Here will be data structures which are completely absent in iOS SDK
or their functionality is insufficient. All data structures have been
tested in production code of iOS 5.0 applications and use ARC memory
management model.

<h2>POSBinaryHeap</h2>
Binary Heap is implemented over `NSMutableArray`. There is `CFBinaryHeapRef`
in Core Foundation framework but it has a very poor interface for removing
objects from it. The only possible options are `CFBinaryHeapRemoveAllValues`
and `CFBinaryHeapRemoveMinimumValue`. So here are two reasons to create that
Binary Heap:

* Make possible to remove from the heap equal and identical objects.
* Make Objective-C ARC compatible implementation instead of plain C.

<h3>Example</h3>
Ascending heap sort implementation with `POSBinaryHeap`

```objc
- (void)testAscendingHeapSort {
    POSBinaryHeap *heap = [[POSBinaryHeap alloc] initWithOrderingType:POSBinaryHeapOrderingAscending
                                                           comparator:^(NSNumber *l, NSNumber *r) {
        return [l compare:r];
    }];
    [heap addObjectsFromArray:@[@5, @4, @3, @2, @1, @0, @0, @1, @2, @3, @4, @5]];
    NSMutableArray *sortedArray = [NSMutableArray new];
    while ([heap count]) {
        [sortedArray addObject:[heap popTopObject]];
    }
    const BOOL sorted = [sortedArray isEqualToArray:@[@0, @0, @1, @1, @2, @2, @3, @3, @4, @4, @5, @5]];
    STAssertTrue(sorted, @"Ascending heap sort is working.");
}
```

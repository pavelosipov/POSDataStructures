<h1>Data Structures Collection

Repository contains data structures which are completely absent in iOS
SDK or its implementation their is insufficient. All of them were tested
in production code of iOS 5.0 applications with ARC memory management
model.

<h2>POSBinaryHeap</h2>
Binary Heap is implemented over `NSMutableArray`. There is `CFBinaryHeapRef`
in Core Foundation framework. But `CFBinaryHeapRef` has a very poor interface
for removing objects from it. The only possible options are `CFBinaryHeapRemoveAllValues`
and `CFBinaryHeapRemoveMinimumValue`. So there are two reasons to create my
Binary Heap:

* Make possible to remove equal and identical objects from the heap.
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

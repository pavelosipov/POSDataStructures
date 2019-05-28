//
//  POSBinaryHeap.m
//  POSDataStructures
//
//  Created by Pavel Osipov on 07.08.13.
//  Copyright (c) 2013 Pavel Osipov. All rights reserved.
//

#import "POSBinaryHeap.h"

@implementation POSBinaryHeap {
    NSComparator _comparator;
    NSMutableArray *_objects;
}

@dynamic count;

- (instancetype)initWithOrderingType:(POSBinaryHeapOrdering)ordering comparator:(NSComparator)comparator {
    NSParameterAssert(comparator);
    if (self = [super init]) {
        NSComparator comparatorCopy = [comparator copy];
        if (ordering == POSBinaryHeapOrderingAscending) {
            _comparator = comparatorCopy;
        } else {
            _comparator = [^(id l, id r) {
                NSComparisonResult result = comparatorCopy(l, r);
                switch (result) {
                    case NSOrderedSame:       return NSOrderedSame;
                    case NSOrderedAscending:  return NSOrderedDescending;
                    case NSOrderedDescending: return NSOrderedAscending;
                }
            } copy];
        }
        _objects = [NSMutableArray array];
    }
    return self;
}

- (NSUInteger)count {
    return [_objects count];
}

- (id)topObject {
    if ([_objects count] > 0) {
        return [_objects objectAtIndex:0];
    }
    return nil;
}

- (void)addObject:(id)object {
    [_objects addObject:object];
    NSUInteger index = [_objects count] - 1;
    while (index > 0) {
        const NSUInteger parentIndex = (index - 1) >> 1;
        if (NSOrderedAscending != _comparator(_objects[index], _objects[parentIndex])) {
            break;
        }
        [_objects exchangeObjectAtIndex:index withObjectAtIndex:parentIndex];
        index = parentIndex;
    }
}

- (void)addObjectsFromArray:(NSArray *)objects {
    for (id object in objects) {
        [self addObject:object];
    }
}

- (id)popTopObject {
    id topObject = [self topObject];
    [self removeTopObject];
    return topObject;
}

- (void)removeTopObject {
    if ([_objects count] > 0) {
        [self pos_removeObjectAtIndex:0];
    }
}

- (void)removeAllObjects {
    [_objects removeAllObjects];
}

- (void)removeObject:(id)object {
    const NSUInteger index = [_objects indexOfObject:object];
    if (NSNotFound != index) {
        [self pos_removeObjectAtIndex:index];
    }
}

- (void)removeObjectIdenticalTo:(id)object {
    const NSUInteger index = [_objects indexOfObjectIdenticalTo:object];
    if (NSNotFound != index) {
        [self pos_removeObjectAtIndex:index];
    }
}

#pragma mark - Private

- (void)pos_removeObjectAtIndex:(NSUInteger)index {
    [_objects exchangeObjectAtIndex:index withObjectAtIndex:[_objects count] - 1];
    [_objects removeLastObject];
    [self pos_heapifyObjectAtIndex:index];
}

- (void)pos_heapifyObjectAtIndex:(NSUInteger)index {
    NSUInteger minIndex = index;
    const NSUInteger count = [_objects count];
    while (true) {
        const NSUInteger leftIndex = (index << 1) + 1;;
        const NSUInteger rightIndex = (index << 1) + 2;
        if (leftIndex < count && NSOrderedAscending == _comparator(_objects[leftIndex], _objects[index])) {
            minIndex = leftIndex;
        }
        if (rightIndex < count && NSOrderedAscending == _comparator(_objects[rightIndex], _objects[minIndex])) {
            minIndex = rightIndex;
        }
        if (index == minIndex) {
            break;
        }
        [_objects exchangeObjectAtIndex:index withObjectAtIndex:minIndex];
        index = minIndex;
    }
}

@end

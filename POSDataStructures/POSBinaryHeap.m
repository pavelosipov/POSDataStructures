//
//  POSBinaryHeap.m
//  POSDataStructures
//
//  Created by Pavel Osipov on 07.08.13.
//  Copyright (c) 2013 Pavel Osipov. All rights reserved.
//

#import "POSBinaryHeap.h"

#pragma mark - POSBinaryHeap helpers

NS_INLINE NSUInteger ParentIndex(NSUInteger index) { return (index - 1) >> 1; }
NS_INLINE NSUInteger   LeftIndex(NSUInteger index) { return (index << 1) + 1; }
NS_INLINE NSUInteger  RightIndex(NSUInteger index) { return (index << 1) + 2; }

#pragma mark - POSBinaryHeap

@implementation POSBinaryHeap {
  NSComparator _comparator;
  NSMutableArray *_objects;
}

@dynamic count;

- (id)init {
  @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                 reason:[NSString stringWithFormat:@"Unexpected deadly init invokation '%@', use '%@' instead.",
                                         NSStringFromSelector(_cmd),
                                         NSStringFromSelector(@selector(initWithOrderingType:comparator:))]
                               userInfo:nil];
}

- (id)initWithOrderingType:(POSBinaryHeapOrdering)ordering comparator:(NSComparator)comparator {
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
    const NSUInteger parentIndex = ParentIndex(index);
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
  const NSUInteger count = [_objects count];
  if (count == 0) {
    return;
  }
  [_objects exchangeObjectAtIndex:0 withObjectAtIndex:count - 1];
  [_objects removeLastObject];
  [self pos_heapifyObjectAtIndex:0];
}

- (void)removeAllObjects {
  [_objects removeAllObjects];
}

- (void)removeObject:(id)object {
  const NSUInteger index = [_objects indexOfObject:object];
  if (NSNotFound != index) {
    [_objects exchangeObjectAtIndex:index withObjectAtIndex:[_objects count] - 1];
    [_objects removeLastObject];
    [self pos_heapifyObjectAtIndex:index];
  }
}

#pragma mark - Private

- (void)pos_heapifyObjectAtIndex:(NSUInteger)i {
  NSUInteger iMin = i;
  const NSUInteger count = [_objects count];
  while (true) {
    const NSUInteger l = LeftIndex(i);
    const NSUInteger r = RightIndex(i);
    if (l < count && NSOrderedAscending == _comparator(_objects[l], _objects[i])) {
      iMin = l;
    }
    if (r < count && NSOrderedAscending == _comparator(_objects[r], _objects[iMin])) {
      iMin = r;
    }
    if (i == iMin) {
      break;
    }
    [_objects exchangeObjectAtIndex:i withObjectAtIndex:iMin];
    i = iMin;
  }
}

@end

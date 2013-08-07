//
//  POSBinaryHeap.h
//  POSDataStructures
//
//  Created by Pavel Osipov on 07.08.13.
//  Copyright (c) 2013 Pavel Osipov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, POSBinaryHeapOrdering) {
  // On the top of the heap will be always the object with the smallest value.
  POSBinaryHeapOrderingAscending,
  // On the top of the heap will be always the object with the biggest value.
  POSBinaryHeapOrderingDescending
};

@interface POSBinaryHeap : NSObject

@property (nonatomic, readonly) NSUInteger count;

// Raises NSInternalInconsistencyException exception.
- (id)init;
// The designated initializer.
- (id)initWithOrderingType:(POSBinaryHeapOrdering)ordering comparator:(NSComparator)comparator;

// Returns the object on the top of the heap. If the heap is empty, returns nil.
- (id)topObject;

// Inserts a given object at the appropriate position of the heap.
- (void)addObject:(id)object;
// Inserts objects contained in another given array to the appropriate positions of the heap.
- (void)addObjectsFromArray:(NSArray *)objects;

// Returns the object on the top of the heap and then removes it. If the heap is empty, returns nil.
- (id)popTopObject;
// Removes top object from the heap. If the heap is empty, the method has no effect.
- (void)removeTopObject;
// Empties the heap of all its elements.
- (void)removeAllObjects;
// Removes specified object from the heap. If the heap is empty, the method has no effect.
- (void)removeObject:(id)object;

@end

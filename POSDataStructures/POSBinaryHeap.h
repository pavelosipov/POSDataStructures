//
//  POSBinaryHeap.h
//  POSDataStructures
//
//  Created by Pavel Osipov on 07.08.13.
//  Copyright (c) 2013 Pavel Osipov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, POSBinaryHeapOrdering) {
    // The smallest object is on the top of the heap.
    POSBinaryHeapOrderingAscending,
    // The biggest object is on the top of the heap.
    POSBinaryHeapOrderingDescending
};

@interface POSBinaryHeap : NSObject

@property (nonatomic, readonly) NSUInteger count;

// Raises NSInternalInconsistencyException exception.
- (id)init;
// The designated initializer.
- (id)initWithOrderingType:(POSBinaryHeapOrdering)ordering comparator:(NSComparator)comparator;

// Returns the object which is on the top of the heap. If the heap is empty, returns nil.
- (id)topObject;

// Inserts a given object in the heap.
- (void)addObject:(id)object;
// Inserts objects contained in another given array in the heap.
- (void)addObjectsFromArray:(NSArray *)objects;

// Returns the object on the top of the heap and then removes it. Returns nil if the heap is empty.
- (id)popTopObject;
// Removes top object. If the heap is empty, the method has no effect.
- (void)removeTopObject;
// Empties the heap of all its elements.
- (void)removeAllObjects;
// Removes object which is equal to the given object. If the heap is empty, the method has no effect.
- (void)removeObject:(id)object;
// Removes object with the same address as the given object address. If the heap is empty, the method has no effect.
- (void)removeObjectIdenticalTo:(id)object;

@end

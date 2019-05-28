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

@interface POSBinaryHeap <__covariant ItemType> : NSObject

@property (nonatomic, readonly) NSUInteger count;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithOrderingType:(POSBinaryHeapOrdering)ordering
                          comparator:(NSComparator)comparator NS_DESIGNATED_INITIALIZER;

/// Returns the object which is on the top of the heap. If the heap is empty, returns nil.
- (ItemType)topObject;

/// Inserts a given object in the heap.
- (void)addObject:(ItemType)object;
/// Inserts objects contained in another given array in the heap.
- (void)addObjectsFromArray:(NSArray<ItemType> *)objects;

/// Returns the object on the top of the heap and then removes it. Returns nil if the heap is empty.
- (ItemType)popTopObject;
/// Removes top object. If the heap is empty, the method has no effect.
- (void)removeTopObject;
/// Empties the heap of all its elements.
- (void)removeAllObjects;
/// Removes object which is equal to the given object. If the heap is empty, the method has no effect.
- (void)removeObject:(ItemType)object;
/// Removes object with the same address as the given object address. If the heap is empty, the method has no effect.
- (void)removeObjectIdenticalTo:(ItemType)object;

@end

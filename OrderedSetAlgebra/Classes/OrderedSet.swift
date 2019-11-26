
//===--- OrderedSet.swift ------------------------------------------*- swift -*-===//
//
// Copyright (c) 2019 Leonardo Savio Dabus
// Licensed under GNU General Public License v3.0
//
//===----------------------------------------------------------------------===//
//
//    Usage:
//
//
//
//===----------------------------------------------------------------------===//
/// A collection of unique ordered objects
   
    public struct OrderedSet<T: Hashable> {
        public init() { }
        private var elements: [T] = []
        private var set: Set<T> = []
    }

    extension OrderedSet: RandomAccessCollection {
        public typealias Index = Int
        public typealias Indices = Range<Int>
        
        public typealias Element = T
        public typealias SubSequence = Self
        public typealias Iterator = IndexingIterator<Self>
        
        public subscript(position: Index) -> Element { elements[position] }
        public subscript(bounds: Range<Index>) -> SubSequence { .init(elements[bounds]) }
        
        public var endIndex: Index { elements.endIndex }
        public var startIndex: Index { elements.startIndex }

        public func formIndex(after i: inout Index) { elements.formIndex(after: &i) }
        
        public var isEmpty: Bool { elements.isEmpty }
    
        @discardableResult
        public mutating func append(_ newElement: T) -> Bool { insert(newElement).inserted }
    }

    extension OrderedSet: Hashable {
        public static func ==(lhs: Self, rhs: Self) -> Bool { lhs.elements.elementsEqual(rhs.elements) }
    }

    extension OrderedSet: SetAlgebra {  
        public mutating func insert(_ newMember: T) -> (inserted: Bool, memberAfterInsert: T) {
            let insertion = set.insert(newMember)
            if insertion.inserted {
                elements.append(newMember)
            }
            return insertion
        }
        public mutating func remove(_ member: T) -> T? {
            if let index = elements.firstIndex(of: member) {
                elements.remove(at: index)
                return set.remove(member)
            }
            return nil
        }
        public mutating func update(with newMember: T) -> T? {
            if let index = elements.firstIndex(of: newMember) {
                elements[index] = newMember
                return set.update(with: newMember)
            } else {
                elements.append(newMember)
                set.insert(newMember)
                return nil
            }
        }
        
        public func union(_ other: Self) -> Self {
            var orderedSet = self
            orderedSet.formUnion(other)
            return orderedSet
        }
        public func intersection(_ other: Self) -> Self {
            var orderedSet = self
            orderedSet.formIntersection(other)
            return orderedSet
        }
        public func symmetricDifference(_ other: Self) -> Self {
            var orderedSet = self
            orderedSet.formSymmetricDifference(other)
            return orderedSet
        }
        
        public mutating func formUnion(_ other: Self) {
            other.forEach { append($0) }
        }
        public mutating func formIntersection(_ other: Self) {
            self = .init(filter{other.contains($0)})
        }
        public mutating func formSymmetricDifference(_ other: Self) {
            self = .init(filter{!other.set.contains($0)}+other.filter{!set.contains($0)})
        }
    }

    extension OrderedSet: ExpressibleByArrayLiteral {
        public init(arrayLiteral elements: T...) { self.init(elements) }
    }

    extension OrderedSet: CustomStringConvertible {
        public var description: String { .init(describing: elements) }
    }

    extension OrderedSet: AdditiveArithmetic {
        public static var zero: Self { .init() }
        public static func + (lhs: Self, rhs: Self) -> Self { lhs.union(rhs) }
        public static func += (lhs: inout Self, rhs: Self) { lhs.formUnion(rhs) }
        public static func - (lhs: Self, rhs: Self) -> Self { lhs.subtracting(rhs) }
        public static func -= (lhs: inout Self, rhs: Self) { lhs.subtract(rhs) }
    }


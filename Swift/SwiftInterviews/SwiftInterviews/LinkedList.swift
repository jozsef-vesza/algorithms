//
//  DataStructures.swift
//  SwiftInterviews
//
//  Created by József Vesza on 02/12/14.
//
//  The MIT License (MIT)

//  Copyright (c) 2014 József Vesza

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

public protocol LinkedListNodeType {
    
    typealias DataType
    typealias NodeType: LinkedListNodeType
    
    var data: DataType { get }
    var next: NodeType? { get }
}

public protocol LinkedListType {
    
    typealias ElementType
    typealias NodeType: LinkedListNodeType
    
    var first: NodeType? { get }
    
    func head() -> NodeType?
    func tail() -> [NodeType]?
    func last() -> NodeType?
    
    func addToBeginning(newValue value: ElementType) -> NodeType
    func insert(newValue value: ElementType, afterNode node: NodeType) -> NodeType
    
    func remove(afterNode node: NodeType) -> NodeType
    func removeFirst() -> NodeType
}

public class LinkedListNode<T>: LinkedListNodeType {
    
    public var data: T
    public var next: LinkedListNode<T>?
    
    public init(data: T) {
        self.data = data
    }
}

public class DoublyLinkedListNode<T>: LinkedListNodeType {
    
    public var data: T
    public var next: DoublyLinkedListNode<T>?
    public weak var previous: DoublyLinkedListNode<T>?
    
    public init(data: T) {
        self.data = data
    }
}

public class LinkedList<T>: LinkedListType {
    
    public var first: LinkedListNode<T>?
    
    public init() { }
    
    public func head() -> LinkedListNode<T>? {
        return first
    }
    
    public func tail() -> [LinkedListNode<T>]? {
        
        var returnArray = [LinkedListNode<T>]()
        if var current = first {
            
            while current.next != nil {
                
                returnArray.append(current.next!)
                current = current.next!
            }
            
            return returnArray
        }
        
        return nil
    }
    
    public func last() -> LinkedListNode<T>? {
        
        if var current = first {
            
            while current.next != nil {
                current = current.next!
            }
            
            return current
        }
        return nil
    }
    
    public func insert(newValue value: T, afterNode node: LinkedListNode<T>) -> LinkedListNode<T> {
        
        let newNode = LinkedListNode(data: value)
        
        newNode.next = node.next
        node.next = newNode
        
        return newNode
    }
    
    public func addToBeginning(newValue value: T) -> LinkedListNode<T> {
        
        let newNode = LinkedListNode(data: value)
        newNode.next = first
        first = newNode
        
        return newNode
    }
    
    public func remove(afterNode node: LinkedListNode<T>) -> LinkedListNode<T> {
        let obsoleteNode = node.next!
        node.next = node.next?.next
        
        return obsoleteNode
    }
    
    public func removeFirst() -> LinkedListNode<T> {
        let obsoleteNode = first!
        first = first!.next
        
        return obsoleteNode
    }
}

public class DoublyLinkedList<T>: LinkedListType {
    
    public var first: DoublyLinkedListNode<T>?
    
    public init() { }
    
    public func head() -> DoublyLinkedListNode<T>? {
        return first
    }
    
    public func tail() -> [DoublyLinkedListNode<T>]? {
        
        if var current = first {
            
            var returnArray = [DoublyLinkedListNode<T>]()
            while current.next != nil {
                returnArray.append(current.next!)
                current = current.next!
            }
            
            return returnArray
        }
        
        return nil
    }
    
    public func last() -> DoublyLinkedListNode<T>? {
        
        if var current = first {
            
            while current.next != nil {
                current = current.next!
            }
            
            return current
        }
        return nil
    }
    
    public func insert(newValue value: T, afterNode node: DoublyLinkedListNode<T>) -> DoublyLinkedListNode<T> {
        
        let newNode = DoublyLinkedListNode(data: value)
        
        newNode.next = node.next
        newNode.previous = node
        node.next = newNode
        
        return newNode
    }
    
    public func addToBeginning(newValue value: T) -> DoublyLinkedListNode<T> {
        let newNode = DoublyLinkedListNode(data: value)
        newNode.next = first
        first = newNode
        
        return newNode
    }
    
    public func remove(afterNode node: DoublyLinkedListNode<T>) -> DoublyLinkedListNode<T> {
        let obsoleteNode = node.next!
        node.next = node.next!.next
        node.next?.previous = node
        
        return obsoleteNode
    }
    
    public func removeFirst() -> DoublyLinkedListNode<T> {
        let obsoleteNode = first!
        first!.next?.previous = nil
        first = first?.next
        return obsoleteNode
    }
}

public class CircularLinkedList<T>: LinkedList<T> {
    
    override public func insert(newValue value: T, afterNode node: LinkedListNode<T>) -> LinkedListNode<T> {
        
        let newNode = LinkedListNode(data: value)
        
        newNode.next = node.next
        node.next = newNode
        
        return newNode
    }
    
    override public func addToBeginning(newValue value: T) -> LinkedListNode<T> {
        
        let newNode = LinkedListNode(data: value)
        newNode.next = first
        first = newNode
        last()!.next = first
        
        return newNode
    }
    
    override public func removeFirst() -> LinkedListNode<T> {
        
        let obsoleteNode = first!
        last()!.next = first!.next
        first!.next = first
        
        return obsoleteNode
    }
    
    override public func remove(afterNode node: LinkedListNode<T>) -> LinkedListNode<T> {
        
        let obsoleteNode = node.next!
        
        if obsoleteNode.next != nil {
            return super.remove(afterNode: node)
        }
        
        node.next = first
        
        return obsoleteNode
    }
}
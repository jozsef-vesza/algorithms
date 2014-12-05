//
//  DataStructures.swift
//  SwiftInterviews
//
//  Created by József Vesza on 02/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

import Foundation

protocol LinkedListNodeType {
    
    typealias DataType
    typealias NodeType: LinkedListNodeType
    
    var data: DataType { get }
    var next: NodeType? { get }
}

protocol LinkedListType {
    
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

class LinkedListNode<T>: LinkedListNodeType {
    
    var data: T
    var next: LinkedListNode<T>?
    
    init(data: T) {
        self.data = data
    }
}

class DoublyLinkedListNode<T>: LinkedListNodeType {
    
    var data: T
    var next: DoublyLinkedListNode<T>?
    weak var previous: DoublyLinkedListNode<T>?
    
    init(data: T) {
        self.data = data
    }
}

class LinkedList<T>: LinkedListType {
    
    var first: LinkedListNode<T>?
    
    init() { }
    
    func head() -> LinkedListNode<T>? {
        return first
    }
    
    func tail() -> [LinkedListNode<T>]? {
        
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
    
    func last() -> LinkedListNode<T>? {
        
        if var current = first {
            
            while current.next != nil {
                current = current.next!
            }
            
            return current
        }
        return nil
    }
    
    func insert(newValue value: T, afterNode node: LinkedListNode<T>) -> LinkedListNode<T> {
        
        let newNode = LinkedListNode(data: value)
        
        newNode.next = node.next
        node.next = newNode
        
        return newNode
    }
    
    func addToBeginning(newValue value: T) -> LinkedListNode<T> {
        
        let newNode = LinkedListNode(data: value)
        newNode.next = first
        first = newNode
        
        return newNode
    }
    
    func remove(afterNode node: LinkedListNode<T>) -> LinkedListNode<T> {
        let obsoleteNode = node.next!
        node.next = node.next?.next
        
        return obsoleteNode
    }
    
    func removeFirst() -> LinkedListNode<T> {
        let obsoleteNode = first!
        first = first!.next
        
        return obsoleteNode
    }
}

class DoublyLinkedList<T>: LinkedListType {
    
    var first: DoublyLinkedListNode<T>?
    
    init() { }
    
    func head() -> DoublyLinkedListNode<T>? {
        return first
    }
    
    func tail() -> [DoublyLinkedListNode<T>]? {
        
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
    
    func last() -> DoublyLinkedListNode<T>? {
        
        if var current = first {
            
            while current.next != nil {
                current = current.next!
            }
            
            return current
        }
        return nil
    }
    
    func insert(newValue value: T, afterNode node: DoublyLinkedListNode<T>) -> DoublyLinkedListNode<T> {
        
        let newNode = DoublyLinkedListNode(data: value)
        
        newNode.next = node.next
        newNode.previous = node
        node.next = newNode
        
        return newNode
    }
    
    func addToBeginning(newValue value: T) -> DoublyLinkedListNode<T> {
        let newNode = DoublyLinkedListNode(data: value)
        newNode.next = first
        first = newNode
        
        return newNode
    }
    
    func remove(afterNode node: DoublyLinkedListNode<T>) -> DoublyLinkedListNode<T> {
        let obsoleteNode = node.next!
        node.next = node.next!.next
        node.next?.previous = node
        
        return obsoleteNode
    }
    
    func removeFirst() -> DoublyLinkedListNode<T> {
        let obsoleteNode = first!
        first!.next?.previous = nil
        first = first?.next
        return obsoleteNode
    }
}

class CircularLinkedList<T>: LinkedList<T> {
    
    override func insert(newValue value: T, afterNode node: LinkedListNode<T>) -> LinkedListNode<T> {
        
        let newNode = LinkedListNode(data: value)
        
        newNode.next = node.next
        node.next = newNode
        
        return newNode
    }
    
    override func addToBeginning(newValue value: T) -> LinkedListNode<T> {
        
        let newNode = LinkedListNode(data: value)
        newNode.next = first
        first = newNode
        last()!.next = first
        
        return newNode
    }
    
    override func removeFirst() -> LinkedListNode<T> {
        
        let obsoleteNode = first!
        last()!.next = first!.next
        first!.next = first
        
        return obsoleteNode
    }
    
    override func remove(afterNode node: LinkedListNode<T>) -> LinkedListNode<T> {
        
        let obsoleteNode = node.next!
        
        if obsoleteNode.next != nil {
            return super.remove(afterNode: node)
        }
        
        node.next = first
        
        return obsoleteNode
    }
}
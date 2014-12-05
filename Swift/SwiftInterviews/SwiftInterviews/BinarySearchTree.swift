//
//  BinarySearchTree.swift
//  SwiftInterviews
//
//  Created by József Vesza on 03/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

import Foundation

// source: Functional Programming in Swift - http://www.objc.io/books/
class Box<T> {
    let unbox: T
    init(_ value: T) { self.unbox = value }
}

enum ResultType<T> {
    // source: http://owensd.io/2014/08/06/fixed-enum-layout.html
    //    case Success(@autoclosure() -> T)
    case Success(Box<T>)
    case Error(String)
}

class BinaryNode<T: Comparable> {
    
    var value: T
    var left: BinaryNode<T>?
    var right: BinaryNode<T>?
    
    init(value: T) {
        self.value = value
    }
}

class BinarySearchTree<T: Comparable> {
    
    var root: BinaryNode<T>?
    
    init() { }
    
    func insert(newValue value: T) -> ResultType<BinaryNode<T>> {
        
        let newNode = BinaryNode(value: value)
        return insert(newNode, afterNode: root, withParent: nil)
        
    }
    
    private func insert(
        newNode: BinaryNode<T>,
        afterNode node: BinaryNode<T>?,
        withParent parent: BinaryNode<T>?) -> ResultType<BinaryNode<T>> {
            
            if let current = node {
                
                if current.value == newNode.value {
                    return .Error("Attempting to insert existing item!")
                } else if current.value > newNode.value {
                    return insert(newNode, afterNode: current.left, withParent: current)
                } else if current.value < newNode.value {
                    return insert(newNode, afterNode: current.right, withParent: current)
                }
                
            } else if let parentNode = parent {
                
                if parentNode.value > newNode.value {
                    parentNode.left = newNode
                } else {
                    parentNode.right = newNode
                }
                
            } else {
                root = newNode
            }
            
            return .Success(Box(newNode))
    }
    
    func findNodeWithValue(value: T) -> ResultType<BinaryNode<T>> {
        return findNodeWithValue(value, startingAt: root)
    }
    
    private func findNodeWithValue(
        value: T,
        startingAt node: BinaryNode<T>?) -> ResultType<BinaryNode<T>> {
            
            if let current = node {
                
                if current.value == value {
                    return .Success(Box(current))
                } else if current.value > value {
                    return findNodeWithValue(value, startingAt: current.left)
                } else  if current.value < value {
                    return findNodeWithValue(value, startingAt: current.right)
                }
            }
            
            return .Error("Value not found")
    }
    
    func preorderTraverseFrom(node: BinaryNode<T>, action: T -> ()) {
        
        action(node.value)
        
        if let left = node.left {
            preorderTraverseFrom(left, action: action)
        }
        
        if let right = node.right {
            preorderTraverseFrom(right, action: action)
        }
    }
    
    func inorderTraverseFrom(node: BinaryNode<T>, action: T -> ()) {
        
        if let left = node.left {
            inorderTraverseFrom(left, action: action)
        }
        
        action(node.value)
        
        if let right = node.right {
            inorderTraverseFrom(right, action: action)
        }
    }
    
    func postorderTraverseFrom(node: BinaryNode<T>, action: T -> ()) {
        
        if let left = node.left {
            postorderTraverseFrom(left, action: action)
        }
        
        if let right = node.right {
            postorderTraverseFrom(right, action: action)
        }
        
        action(node.value)
    }
}
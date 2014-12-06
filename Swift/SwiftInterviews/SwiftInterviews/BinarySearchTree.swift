//
//  BinarySearchTree.swift
//  SwiftInterviews
//
//  Created by József Vesza on 03/12/14.
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

// source: Functional Programming in Swift - http://www.objc.io/books/
public class Box<T> {
    let unbox: T
    init(_ value: T) { self.unbox = value }
}

public enum ResultType<T> {
    // source: http://owensd.io/2014/08/06/fixed-enum-layout.html
    //    case Success(@autoclosure() -> T)
    case Success(Box<T>)
    case Error(String)
}

public enum TraverseType {
    case Preorder, Inorder, Postorder
}

private enum ReplaceStrategy {
    case LeftTree
    case RightTree
}

public class BinaryNode<T: Comparable> {
    
    var value: T
    var left: BinaryNode<T>?
    var right: BinaryNode<T>?
    
    init(value: T) {
        self.value = value
    }
}

public class BinarySearchTree<T: Comparable> {
    
    public var root: BinaryNode<T>?
    private var strategy: ReplaceStrategy = .LeftTree
    
    public init() { }
    
    public func insert(newValue value: T) -> ResultType<BinaryNode<T>> {
        
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
    
    public func findNodeWithValue(value: T) -> ResultType<BinaryNode<T>> {
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
    
    private func findNode(
        value: T,
        startAt startNode: BinaryNode<T>?,
        parent: BinaryNode<T>?) -> (node: BinaryNode<T>?, parent: BinaryNode<T>?) {
            
            if let current = startNode {
                
                if current.value == value {
                    return (current, parent)
                } else if current.value > value {
                    return findNode(value, startAt: current.left, parent: current)
                } else if current.value < value {
                    return findNode(value, startAt: current.right, parent: current)
                }
            }
            
            return (nil, parent)
    }
    
    public func deleteNode(#value: T) -> ResultType<BinaryNode<T>> {
        
        if root == nil {
            return .Error("Tree is empty")
        }
        
        let soughtNode = findNode(value, startAt: root, parent: nil)
        
        switch soughtNode {
            
        case (nil, _): return .Error("Could not find node with value: \(value)")
            
        case (let node, let parent):
            
            if var parentNode = parent {
                
                var subTree = [T]()
                
                preorderTraverseFrom(node!) { nextValue in
                    subTree.append(nextValue)
                }
                
                parentNode = removeNode(node!, fromParent: parentNode)
                
                if !subTree.isEmpty {
                    let subNodes = subTree.filter({ (nextVal) -> Bool in
                        nextVal != value
                    }).map { next -> BinaryNode<T> in
                        BinaryNode<T>(value: next)
                    }
                    
                    for node in subNodes {
                        insert(node, afterNode: parentNode, withParent: nil)
                    }
                }
                
            } else {
                root = nil
            }
        }
        
        switchStrategy()
        
        return .Success(Box(soughtNode.node!))
    }
    
    private func switchStrategy() {
        
        var nextStrategy: ReplaceStrategy
        
        switch strategy {
        case .LeftTree: nextStrategy = .RightTree
        case .RightTree: nextStrategy = .LeftTree
        }
        
        strategy = nextStrategy
    }
    
    private func addNode(
        childNode: BinaryNode<T>?,
        toParent parent: BinaryNode<T>) -> BinaryNode<T> {
            
            if let node = childNode {
                if node.value < parent.value { parent.left = node }
                else { parent.right = node }
            }
            
            return parent
    }
    
    private func removeNode(
        childNode: BinaryNode<T>,
        fromParent parent: BinaryNode<T>) -> BinaryNode<T> {
            
            if childNode.value < parent.value { parent.left = nil }
            else { parent.right = nil }
            
            return parent
    }
    
    public func traverseTree(
        order: TraverseType,
        action: T -> ()) -> String? {
            
            if let rootNode = root {
                
                switch order {
                    
                case .Preorder: preorderTraverseFrom(rootNode, action: action)
                case .Inorder: inorderTraverseFrom(rootNode, action: action)
                case .Postorder: postorderTraverseFrom(rootNode, action: action)
                    
                }
            } else {
                return "Tree is empty!"
            }
            
            return nil
    }
    
    private func preorderTraverseFrom(node: BinaryNode<T>, action: T -> ()) {
        
        action(node.value)
        
        if let left = node.left {
            preorderTraverseFrom(left, action: action)
        }
        
        if let right = node.right {
            preorderTraverseFrom(right, action: action)
        }
    }
    
    private func inorderTraverseFrom(node: BinaryNode<T>, action: T -> ()) {
        
        if let left = node.left {
            inorderTraverseFrom(left, action: action)
        }
        
        action(node.value)
        
        if let right = node.right {
            inorderTraverseFrom(right, action: action)
        }
    }
    
    private func postorderTraverseFrom(node: BinaryNode<T>, action: T -> ()) {
        
        if let left = node.left {
            postorderTraverseFrom(left, action: action)
        }
        
        if let right = node.right {
            postorderTraverseFrom(right, action: action)
        }
        
        action(node.value)
    }
}
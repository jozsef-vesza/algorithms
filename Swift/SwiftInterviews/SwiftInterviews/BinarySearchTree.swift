//
//  BinarySearchTree.swift
//  SwiftInterviews
//
//  Created by József Vesza on 03/12/14.
//

import Foundation

public class Box<T> {
    let unbox: T
    init(_ value: T) { self.unbox = value }
}

public enum ResultType<T> {
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

public struct Queue<T> {
    
    var queue = [T]()
    
    mutating func enqueue(item: T) {
        queue.append(item)
    }
    
    mutating func dequeue() -> T {
        return queue.removeAtIndex(0)
    }
    
    func isEmpty() -> Bool {
        return queue.isEmpty
    }
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
    private var _strategy: ReplaceStrategy = .LeftTree
    
    public init() { }
    
    public func insert(newValue value: T) -> ResultType<BinaryNode<T>> {
        return insert(BinaryNode(value: value), afterNode: root, withParent: nil)
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
                
            } else if var parentNode = parent {
                
                parentNode = addChild(newNode, toParent: parentNode)
                
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
    
    private func findNodeAndParent(
        value: T,
        startAt startNode: BinaryNode<T>?,
        parent: BinaryNode<T>?) -> (node: BinaryNode<T>?, parent: BinaryNode<T>?) {
            
            if let current = startNode {
                
                if current.value == value {
                    
                    return (current, parent)
                    
                } else if current.value > value {
                    
                    return findNodeAndParent(value, startAt: current.left, parent: current)
                    
                } else if current.value < value {
                    
                    return findNodeAndParent(value, startAt: current.right, parent: current)
                }
            }
            
            return (nil, parent)
    }
    
    public func deleteNode(#value: T) -> ResultType<T> {
        
        if root == nil {
            return .Error("Tree is empty")
        }
        
        let soughtNode = findNodeAndParent(value, startAt: root, parent: nil)
        
        switch soughtNode {
            
        case (nil, _): return .Error("Could not find node with value: \(value)")
            
        case (let node, nil): root = nil
            
        case (var node, var parent):
            
            if node!.left == nil && node!.right == nil {
                
                parent = removeChild(node!, fromParent: parent!)
                
            } else if node!.left != nil && node!.right != nil {
                
                node = replaceNode(node!)
                
            } else if node!.left != nil || node!.right != nil {
                
                parent = addChild(node!.left ?? node!.right, toParent: parent!)
            }
        }
        
        return .Success(Box(value))
    }
    
    private func replaceNode(
        node: BinaryNode<T>) -> BinaryNode<T> {
            
            var subTreeValues = [T]()
            var replacementNode: ResultType<BinaryNode<T>>
            
            switch _strategy {
                
            case .LeftTree:
                inorderTraverseFrom(node.left!) { smallestInLeftTree in
                    subTreeValues.append(smallestInLeftTree)
                }
                
            case .RightTree:
                inorderTraverseFrom(node.right!) { smallestInRightTree in
                    subTreeValues.append(smallestInRightTree)
                }
            }
            
            replacementNode = findNodeWithValue(subTreeValues.first!, startingAt: node)
            
            switch replacementNode {
                
            case .Success(let foundNode):
                let value = foundNode.unbox.value
                deleteNode(value: value)
                node.value = value
                
            default:
                assert(false, "This will never happen")
            }
            
            switchStrategy()
            
            return node
    }
    
    private func addChild(
        child: BinaryNode<T>?,
        toParent parent: BinaryNode<T>) -> BinaryNode<T> {
            
            if let node = child {
                if node.value < parent.value { parent.left = node }
                else { parent.right = node }
            }
            
            return parent
    }
    
    private func removeChild(
        child: BinaryNode<T>,
        fromParent parent: BinaryNode<T>) -> BinaryNode<T> {
            
            if child.value < parent.value { parent.left = nil }
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
    
    public func findBreadthFirst(
        value: T,
        action: T -> ()) {
            
            if let rootNode = root {
                
                var queue = Queue<BinaryNode<T>>()
                queue.enqueue(rootNode)
                
                searchNodes(value, inQueue: queue, action: action)
            }
    }
    
    private func searchNodes(value: T, var inQueue queue: Queue<BinaryNode<T>>, action: T -> ()) {
        
        while !queue.isEmpty() {
            
            let next = queue.dequeue()
            
            if next.value == value {
                
                action(next.value)
                
                return
                
            } else {
                
                if let left = next.left {
                    queue.enqueue(left)
                }
                
                if let right = next.right {
                    queue.enqueue(right)
                }
            }
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
    
    private func switchStrategy() {
        
        var nextStrategy: ReplaceStrategy
        
        switch _strategy {
        case .LeftTree: nextStrategy = .RightTree
        case .RightTree: nextStrategy = .LeftTree
        }
        
        _strategy = nextStrategy
    }
}
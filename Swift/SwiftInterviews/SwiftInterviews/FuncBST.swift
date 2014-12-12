//
//  FuncBST.swift
//  SwiftInterviews
//
//  Created by József Vesza on 11/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
//

import Foundation

public enum Tree<T: Comparable> {
    case Leaf
    case Node(Box<Tree<T>>, Box<T>, Box<Tree<T>>)
}

public func single<T: Comparable>(x: T) -> Tree<T> {
    return Tree.Node(Box(Tree.Leaf), Box(x), Box(Tree.Leaf))
}

public func emptyTree<T>() -> Tree<T> {
    return Tree.Leaf
}

public func isEmptyTree<T>(tree: Tree<T>) -> Bool {
    
    switch tree {
        
    case Tree.Leaf:
        return true
        
    case Tree.Node(_, _, _):
        return false
    }
}

public func count<T>(tree: Tree<T>) -> Int {

    switch tree {
        
    case Tree.Leaf:
        return 0
        
    case let Tree.Node(left, x, right):
        return 1 + count(left.unbox) + count(right.unbox)
    }
}

public func insert<T: Comparable>(x: T, inTree tree: Tree<T>) -> Tree<T> {

    switch tree {
        
    case Tree.Leaf:
        return single(x)
        
    case let Tree.Node(left, y, right) where x == y.unbox:
        return tree
        
    case let Tree.Node(left, y, right) where x < y.unbox:
        return Tree.Node(Box(insert(x, inTree: left.unbox)), y, right)
        
    case let Tree.Node(left, y, right) where x > y.unbox:
        return Tree.Node(left, y, Box(insert(x, inTree: right.unbox)))
        
    default:
        assert(false, "This will never happen")
    }
}

public func find<T: Comparable>(x: T, inTree tree: Tree<T>) -> ResultType<Tree<T>> {
    
    switch tree {
        
    case Tree.Leaf:
        return ResultType.Error("Could not find subtree with value: \(x)")
        
    case let Tree.Node(left, y, right) where x == y.unbox:
        return ResultType.Success(Box(Tree.Node(left, y, right)))
        
    case let Tree.Node(left, y, right) where x < y.unbox:
        return find(x, inTree: left.unbox)
        
    case let Tree.Node(left, y, right) where x > y.unbox:
        return find(x, inTree: right.unbox)
        
    default:
        assert(false, "This will never happen")
    }

}

public func delete<T: Comparable>(x: T, fromTree tree: Tree<T>) -> Tree<T> {
    
    switch tree {
        
    case Tree.Leaf:
        return tree
        
    case let Tree.Node(left, y, right) where x == y.unbox:
        return rotate(Tree.Node(left, y, right))
        
    case let Tree.Node(left, y, right) where x < y.unbox:
        return Tree.Node(Box(delete(x, fromTree: left.unbox)), y, right)
        
    case let Tree.Node(left, y, right) where x > y.unbox:
        return Tree.Node(left, y, Box(delete(x, fromTree: right.unbox)))
        
    default:
        assert(false, "This will never happen")
    }
}

private func rotate<T>(tree: Tree<T>) -> Tree<T> {
    
    switch tree {
        
    case Tree.Leaf:
        return tree
        
    case let Tree.Node(left, x, right) where isEmptyTree(left.unbox) && isEmptyTree(right.unbox):
        return emptyTree()
        
    case let Tree.Node(left, x, right) where !isEmptyTree(left.unbox) && isEmptyTree(right.unbox):
        return left.unbox
        
    case let Tree.Node(left, x, right) where isEmptyTree(left.unbox) && !isEmptyTree(right.unbox):
        return right.unbox
        
    case let Tree.Node(left, x, right) where !isEmptyTree(left.unbox) && !isEmptyTree(right.unbox):
        return Tree.Node(left, Box(inorderTraverseTree(right.unbox).first!), Box(delete(inorderTraverseTree(right.unbox).first!, fromTree: tree)))
        
    default:
        assert(false, "This will never happen")
    }
    
}

public func traverseTree<T>(tree: Tree<T>, order: TraverseType) -> [T] {
    
    switch order {
        
    case TraverseType.Inorder:
        return inorderTraverseTree(tree)
        
    case TraverseType.Preorder:
        return preorderTraverseTree(tree)
        
    case TraverseType.Postorder:
        return postorderTraverseTree(tree)
    }
}

private func inorderTraverseTree<T>(tree: Tree<T>) -> [T] {
    
    switch tree {
    
    case Tree.Leaf:
        return []
        
    case let Tree.Node(left, x, right):
        return inorderTraverseTree(left.unbox) + [x.unbox] + inorderTraverseTree(right.unbox)
    }
}

private func preorderTraverseTree<T>(tree: Tree<T>) -> [T] {
    
    switch tree {
        
    case Tree.Leaf:
        return []
        
    case let Tree.Node(left, x, right):
        return [x.unbox] + preorderTraverseTree(left.unbox) + preorderTraverseTree(right.unbox)
    }
}

private func postorderTraverseTree<T>(tree: Tree<T>) -> [T] {
    
    switch tree {
        
    case Tree.Leaf:
        return []
        
    case let Tree.Node(left, x, right):
        return postorderTraverseTree(left.unbox) + postorderTraverseTree(right.unbox) + [x.unbox]
    }
}
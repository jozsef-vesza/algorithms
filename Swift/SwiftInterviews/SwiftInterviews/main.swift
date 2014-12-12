//
//  main.swift
//  SwiftInterviews
//
//  Created by József Vesza on 02/12/14.
//

import Foundation

let intList = LinkedList<Int>()
let stringList = DoublyLinkedList<String>()

intList.addToBeginning(newValue: 1)
stringList.addToBeginning(newValue: "Start")

for var i = 2; i < 11; i++ {
    if let lastItem = intList.last() {
        intList.insert(newValue: i, afterNode: lastItem)
    }
    
    if let lastString = stringList.last() {
        stringList.insert(newValue: "Node \(i)", afterNode: lastString)
    }
}

stringList.insert(newValue: "End", afterNode: stringList.last()!)

if let firstNode = intList.head() {
    intList.insert(newValue: 99, afterNode: firstNode)
}

intList.remove(afterNode: intList.addToBeginning(newValue: 90))
intList.removeFirst()

var node = stringList.head()

while node != nil {
    println(node!.data)
    node = node!.next
}

intList.tail()?.map {
    println($0.data)
}

println("TREES")

var binTree = BinarySearchTree<Int>()

binTree.insert(newValue: 8)
binTree.insert(newValue: 3)
binTree.insert(newValue: 1)
binTree.insert(newValue: 6)
binTree.insert(newValue: 4)
binTree.insert(newValue: 7)
binTree.insert(newValue: 10)
binTree.insert(newValue: 14)
binTree.insert(newValue: 13)

binTree.findBreadthFirst(10) { value in
    println("Found node with value: \(value)")
}

println(binTree.insert(newValue: 3))

switch binTree.insert(newValue: 3) {

case .Success(let boxedNode):
    println("Inserted node with value: \(boxedNode.unbox.value)")
case .Error(let message):
    println(message)
}

switch binTree.findNodeWithValue(3) {
    
case .Success(let boxedNode):
    println("Found node with value: \(boxedNode.unbox.value)")
case .Error(let message):
    println(message)
}

binTree.traverseTree(.Preorder) { node in
    println("Node value: \(node.value)")
}

println()

switch binTree.deleteNode(value: 3) {
case .Success(let boxedNode):
    println("Deleted node with value: \(boxedNode.unbox)")
case .Error(let message):
    println(message)
}

binTree.traverseTree(.Preorder) { node in
    println("Node value: \(node.value)")
}

println()

switch binTree.deleteNode(value: 10) {
case .Success(let boxedNode):
    println("Deleted node with value: \(boxedNode.unbox)")
case .Error(let message):
    println(message)
}

binTree.traverseTree(.Preorder) { node in
    println("Node value: \(node.value)")
}

println("Insertion")

let funcTree = insert(13, inTree: insert(14, inTree: insert(10, inTree: insert(7, inTree: insert(4, inTree: insert(6, inTree: insert(1, inTree: insert(3, inTree: single(8)))))))))

traverseTree(funcTree, TraverseType.Preorder).map { next in
    println(next)
}

println("Search")

switch find(99, inTree: funcTree) {

case ResultType.Success(let tree):
    println("found it")

case ResultType.Error(let message):
    println(message)
}

switch find(3, inTree: funcTree) {

case ResultType.Success(let tree):
    println("found it:")
    traverseTree(tree.unbox, TraverseType.Inorder).map { next in
        println(next)
    }

case ResultType.Error(let message):
    println(message)
}

println("Deletion")

traverseTree(delete(3, fromTree: funcTree), TraverseType.Preorder).map { next in
    println(next)
}
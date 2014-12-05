//
//  main.swift
//  SwiftInterviews
//
//  Created by József Vesza on 02/12/14.
//  Copyright (c) 2014 Jozsef Vesza. All rights reserved.
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

binTree.insert(newValue: 5)
binTree.insert(newValue: 2)
binTree.insert(newValue: 3)
binTree.insert(newValue: 9)
binTree.insert(newValue: 8)

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

binTree.traverseTree(.Inorder) { value in
    println(value)
}
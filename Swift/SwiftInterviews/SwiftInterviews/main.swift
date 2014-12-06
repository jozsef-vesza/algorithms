//
//  main.swift
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
binTree.insert(newValue: 1)
binTree.insert(newValue: 3)
binTree.insert(newValue: 8)
binTree.insert(newValue: 7)
binTree.insert(newValue: 9)

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

binTree.traverseTree(.Preorder) { value in
    println(value)
}

println()

switch binTree.deleteNode(value: 8) {
case .Success(let boxedNode):
    println("Deleted node with value: \(boxedNode.unbox.value)")
case .Error(let message):
    println(message)
}

binTree.traverseTree(.Preorder) { value in
    println(value)
}

println()

switch binTree.deleteNode(value: 2) {
case .Success(let boxedNode):
    println("Deleted node with value: \(boxedNode.unbox.value)")
case .Error(let message):
    println(message)
}

binTree.traverseTree(.Preorder) { value in
    println(value)
}
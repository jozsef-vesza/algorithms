import Foundation

extension Array {
    
    func randomElement() -> Generator.Element {
        return self[Int(arc4random_uniform(UInt32(count)))]
    }
}

extension Array where Element: Comparable {

    func mergeWith(other:[Generator.Element]) -> [Generator.Element] {
        
        var output: [Generator.Element] = []
        
        var leftIndex = startIndex
        var rightIndex = other.startIndex
        
        while leftIndex != endIndex && rightIndex != other.endIndex {
            
            let leftValue = self[leftIndex]
            let rightValue = other[rightIndex]
            
            if leftValue < rightValue {
                
                output.append(leftValue)
                leftIndex = leftIndex.successor()
                
            } else {
                
                output.append(rightValue)
                rightIndex = rightIndex.successor()
            }
        }
        
        output += self[leftIndex ..< endIndex]
        output += other[rightIndex ..< other.endIndex]
        
        return output
    }
}

extension CollectionType where Generator.Element: Comparable, Index.Distance == Int {
    
    func insertionSort() -> [Generator.Element] {
        
        var output = Array(self)
        
        for primaryIndex in 0 ..< count {
            
            let key = output[primaryIndex]
            
            for var secondaryIndex = primaryIndex; secondaryIndex > -1; secondaryIndex-- {
                
                if key < output[secondaryIndex] {
                    
                    output.removeAtIndex(secondaryIndex + 1)
                    output.insert(key, atIndex: secondaryIndex)
                }
            }
        }
        
        return output
    }
    
    func selectionSort() -> [Generator.Element] {
    
        var output = Array(self)
        
        var indexOfSmallest = 0
        
        for primaryIndex in 0 ..< output.count {
        
            indexOfSmallest = primaryIndex
            
            for secondaryIndex in primaryIndex + 1 ..< output.count {
            
                if output[secondaryIndex] < output[indexOfSmallest] {
                
                    indexOfSmallest = secondaryIndex
                }
            }
            
            if primaryIndex != indexOfSmallest {
                swap(&output[primaryIndex], &output[indexOfSmallest])
            }
        }
        
        return output
    }
    
    func bubbleSort() -> [Generator.Element] {
    
        var output = Array(self)
        
        var shouldRepeat = true
        
        while shouldRepeat {
            
            shouldRepeat = false
        
            for index in 1 ..< output.count {
                if output[index] < output[index - 1] {
                    swap(&output[index], &output[index - 1])
                    shouldRepeat = true
                }
            }
        }
        
        return output
    }
    
    func mergeSort() -> [Generator.Element] {
        
        if count < 2 {
            return Array(self)
        }
        
        let middleIndex = count / 2
        let left = enumerate().filter { $0.0 < middleIndex }.map { return $0.1 }.mergeSort()
        let right = enumerate().filter { $0.0 >= middleIndex }.map { return $0.1 }.mergeSort()
        
        return left.mergeWith(right)
    }
    
    func quickSort() -> [Generator.Element] {
        
        if self.count < 1 { return [] }
        
        let unsorted = Array(self)
        
        var less: [Generator.Element] = []
        var more: [Generator.Element] = []
        
        let pivot = unsorted.randomElement()
        
        for element in unsorted where element != pivot {
            if element < pivot { less.append(element) }
            else { more.append(element) }
        }
        
        return less.quickSort() + [pivot] + more.quickSort()
    }
}

let numbers = [9, 8, 7, 5, 6]
let strings = ["gnu", "zebra", "antelope", "aardvark", "yak", "iguana"]

let nums2 = numbers.insertionSort()
let sortedStr2 = strings.insertionSort()
let set = Set(numbers)
let sortedSet = set.insertionSort()

let selectionSortedNums = numbers.selectionSort()
let selectionSortedStrings = strings.selectionSort()

let bubbleSortedNums = numbers.bubbleSort()

let mergeSortedNums = numbers.mergeSort()

let quickSortedNums = numbers.quickSort()

//: [Next](@next)

extension CollectionType where Generator.Element: Comparable, Index.Distance == Int {
    
    func insertionSort() -> [Generator.Element] {
        
        var output = Array(self)
        
        for primaryIndex in 0 ..< self.count {
            
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
    
        var output = Array(self)
        
        
        
        return output
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

//: [Next](@next)
